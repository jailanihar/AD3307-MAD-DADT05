import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/routes_config.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'AD3307 MAD',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.blueGrey)
      ),
      // home: const LoginPage(),
      routerConfig: routesConfig,
    );
  }
}