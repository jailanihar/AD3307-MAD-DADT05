import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return MADScaffold(
      titleText: 'Login',
      body: ListView(
        children: [
          Image.asset(
            'assets/images/pb_logo.png',
            width: 150,
            height: 150,
          ),
          Column(
            children: [
              const Text('Email'),
              TextFormField(
                
              ),
            ],
          ),
          Column(
            children: [
              const Text('Password'),
              TextFormField(
                obscureText: !_showPassword,
              ),
            ],
          ),
          Row(
            children: [
              Switch(
                value: _showPassword,
                onChanged: (value) {
                  setState(() {
                    _showPassword = value;
                  });
                },
              ),
              const Text('Show Password'),
            ],
          ),
        ],
      ),
    );
  }
}