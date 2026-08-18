import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? name;

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

  @override
  Widget build(BuildContext context) {
    return MADScaffold(
      titleText: 'Home',
      body: ListView(
        children: [
          Text(name ?? ''),       
        ],
      ),
    );
  }
}