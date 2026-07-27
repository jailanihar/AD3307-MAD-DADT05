import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/first_stateful.dart';
import 'package:flutter_application_1/pages/first_stateless.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AD3307 MAD',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueGrey)
      ),
      home: const MyFirstStatefulPage(),
    );
  }
}