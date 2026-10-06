import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';
import 'package:flutter_application_1/components/mad_textformfield.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
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
      titleText: AppLocalizations.of(context)!.loginTitle,
      body: ListView(
        children: [
          Image.asset(
            'assets/images/pb_logo.png',
            width: 150,
            height: 150,
          ),
          MADTextformfield(
            labelText: AppLocalizations.of(context)!.email,
            controller: emailTextEditingController,
          ),
          MADTextformfield(
            labelText: AppLocalizations.of(context)!.password,
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
            onPressed: () async {
              try {
                UserCredential user =
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailTextEditingController.text,
                    password: passwordTextEditingController.text,
                  );
                if(mounted) {
                  context.go('/home');
                }
              } on FirebaseAuthException catch (e) {
                print(e.toString());
              }
              // if(emailTextEditingController.text == 'jailani.rahman@pb.edu.bn'
              //   && passwordTextEditingController.text == 'Antah123456'
              // ) {
              //   context.go('/home');
              // }
            },
            child: Text(AppLocalizations.of(context)!.loginTitle),
          ),
          TextButton(
            onPressed: () {
              context.go('/register');
            },
            child: Text(AppLocalizations.of(context)!.registerTitle),
          ),
        ],
      ),
    );
  }
}