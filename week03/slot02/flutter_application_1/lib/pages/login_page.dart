import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';
import 'package:flutter_application_1/components/mad_textformfield.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController sampleTextEditingController =
    TextEditingController();
  final TextEditingController emailTextEditingController =
    TextEditingController();
  final TextEditingController passwordTextEditingController =
    TextEditingController();
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
          MADTextformfield(
            labelText: 'Email',
            controller: emailTextEditingController,
          ),
          MADTextformfield(
            labelText: 'Password',
            obscureText: !_showPassword,
            controller: passwordTextEditingController,
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
          ElevatedButton(
            onPressed: () {
              if(emailTextEditingController.text == 'jailani.rahman@pb.edu.bn'
                && passwordTextEditingController.text == 'Antah123456'
              ) {
                context.go('/home');
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}