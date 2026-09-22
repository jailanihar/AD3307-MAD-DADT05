import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/appwrite_options.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;
  Uint8List? _imageBytes; // Web app
  String? _imagePath; // Mobile app
  late Client appWriteClient;
  late Storage appWriteStorage;
  List<dynamic> _imageIds = [];

  @override
  void initState() {
    super.initState();
    appWriteClient = Client()
      .setEndpoint(AppwriteOptions.endPoint)
      .setProject(AppwriteOptions.projectId);
    appWriteStorage = Storage(appWriteClient);
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) return;
    DocumentSnapshot<Map<String, dynamic>> userData = 
      await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
    if(userData.exists) {
      setState(() {
        name = userData.data()!['name'] ?? '';
        _imageIds = userData.data()!['gallery'] ?? [];
      });
    }
  }

  Future<void> pickImage() async {
    PlatformFile? file = await FilePicker.pickFile(type: FileType.image);
    if(file != null) {
      var bytes = await file.readAsBytes();
      setState(() {
        _imageBytes = bytes;
        _imagePath = file.path;
      });
    }
  }

  Future<void> uploadImage() async {
    if(kIsWeb) {
      if(_imageBytes == null) return;
    } else {
      if(_imagePath == null) return;
    }
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) return;

    String fileName = 
      '${DateTime.now().millisecondsSinceEpoch.toString()}_${user.uid}';
    final result = await appWriteStorage.createFile(
      bucketId: AppwriteOptions.bucketId,
      fileId: ID.unique(),
      file: kIsWeb ?
          InputFile.fromBytes(bytes: _imageBytes!, filename: fileName)
        :
          InputFile.fromPath(path: _imagePath!, filename: fileName)
      ,
    );

    DocumentReference userDoc = 
      FirebaseFirestore.instance.collection('users').doc(user.uid);

    userDoc.update({
      'gallery': FieldValue.arrayUnion([result.$id]),
    });

    setState(() {
      _imageIds.add(result.$id);
      _imageBytes = null;
      _imagePath = null;
    });
  }

  Future<void> deleteImage(String imageId) async {
    User? user = FirebaseAuth.instance.currentUser;
    if(user == null) return;

    await appWriteStorage.deleteFile(
      bucketId: AppwriteOptions.bucketId,
      fileId: imageId,
    );

    DocumentReference userDoc =
      FirebaseFirestore.instance.collection('users').doc(user.uid);

    userDoc.update({
      'gallery': FieldValue.arrayRemove([imageId]),
    });

    setState(() {
      _imageIds.remove(imageId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MADScaffold(
      titleText: 'Home',
      body: ListView(
        children: [
          Text(name ?? ''),
          kIsWeb ?
            (
              _imageBytes != null ?
                Image.memory(
                  _imageBytes!,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              :
                const Text('No image selected (web)')
            )
          :
            (
              _imagePath != null ?
                Image.file(
                  File(_imagePath!),
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                )
              :
                const Text('No image selected (mobile)')
            )
          ,
          ElevatedButton(
            onPressed: pickImage,
            child: const Text('Pick Image'),
          ),
          ElevatedButton(
            onPressed: uploadImage, 
            child: const Text('Upload Image'),
          ),
          SizedBox(height: 20),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10.0,
              mainAxisSpacing: 10.0,
            ),
            itemCount: _imageIds.length,
            itemBuilder: (context, index) => FutureBuilder(
              future: appWriteStorage.getFileDownload(
                bucketId: AppwriteOptions.bucketId,
                fileId: _imageIds[index] as String,
              ),
              builder: (context, snapshot) {
                if(snapshot.hasData && snapshot.data != null) {
                  return Stack(
                    children: [
                      Image.memory(
                        snapshot.data as Uint8List,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => deleteImage(_imageIds[index] as String),
                      ),
                    ]
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}