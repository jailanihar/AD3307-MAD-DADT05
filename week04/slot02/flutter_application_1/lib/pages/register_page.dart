import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';
import 'package:flutter_application_1/components/mad_textformfield.dart';

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
            ),
            MADTextformfield(
              labelText: 'Password',
              controller: passwordController,
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

  void _register() {
    // if(_formKey.currentState!.validate()) {
    //   print('Error');
    // }
    if(passwordController.text != confirmPasswordController.text) {
      setState(() {
        _errorText = 'Passwords are not same';
      });
      return;
    }
  }

  void _back() {
  }
}