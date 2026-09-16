import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  @override
  void initState() {
    super.initState();
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
      });
    }
  }

  Future<void> pickImage() async {
    PlatformFile? file = await FilePicker.pickFile(type: FileType.image);
    
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
        ],
      ),
    );
  }
}