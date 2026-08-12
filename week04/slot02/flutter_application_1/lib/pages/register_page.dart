import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';
import 'package:flutter_application_1/components/mad_textformfield.dart';
import 'package:go_router/go_router.dart';

class RegisterPage extends StatefulWidget {

  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  String _errorText = '';
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );


  @override
  Widget build(BuildContext context) {
    return MADScaffold(
      titleText: 'Register',
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            const Text('Create an account'),
            MADTextformfield(
              labelText: 'Email',
              controller: emailController,
              validator: (value) {
                if(value == null || value == '') {
                  return 'Please fill in email';
                }
                if(!emailRegex.hasMatch(value)) {
                  return 'Invalid Email';
                }
                return null;
              },
            ),
            MADTextformfield(
              labelText: 'Password',
              controller: passwordController,
              validator: (value) {
                if(value == null || value == '') {
                  return 'Please fill in password';
                }
                return null;
              }
            ),
            MADTextformfield(
              labelText: 'Confirm Password',
              controller: confirmPasswordController,
              validator: (value) {
                if(value == null || value == '') {
                  return 'Please fill in confirm password';
                }
                if(value == passwordController.text) {
                  return null;
                }
                return 'Password and confirm password not matched';
              },
            ),
            MADTextformfield(
              labelText: 'Name',
              controller: nameController,
            ),
            ElevatedButton(
              onPressed: _register,
              child: const Text('Register'),
            ),
            ElevatedButton(
              onPressed: _back,
              child: const Text('Back'),
            ),
            Text(_errorText),
          ],
        ),
      ),
    );
  }

  Future<void> _register() async {
    if(mounted && !_formKey.currentState!.validate()) {
      setState(() {
        _errorText = 'Failed to register.';
      });
      return;
    }
    try {
      UserCredential user =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      if(mounted) {
        context.go('/login');
      }
    } on FirebaseAuthException catch (_) {
      setState(() {
        _errorText = 'Failed to register. Please make sure the email is not already used';
      });
    }
  }

  void _back() {
    if(mounted) {
      context.go('/login');
    }
  }
}