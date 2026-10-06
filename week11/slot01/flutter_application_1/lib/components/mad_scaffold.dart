import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/l10n/app_localizations.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:flutter_application_1/providers/locale_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MADScaffold extends StatelessWidget {
  final String titleText;
  final Widget body;

  const MADScaffold({
    super.key,
    required this.titleText,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          DropdownButton<Locale>(
            items: AppLocalizations.supportedLocales.map(
              (locale) => DropdownMenuItem<Locale>(
                value: locale,
                child: Text(locale.languageCode.toUpperCase()),
              ),
            ).toList(),
            onChanged: (Locale? locale) {
              if(locale != null) {
                localeProvider.setLocale(locale);
              }
            },
          ),
        ],
      ),
      body: body,
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap:() {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => const HomePage())
                // );
                context.go('/home');
              }
            ),
            ListTile(
              leading: const Icon(Icons.one_k),
              title: const Text('MyFirstStatelessPage'),
              onTap:() {
                context.go('/first-stateless');
              }
            ),
            ListTile(
              leading: const Icon(Icons.one_x_mobiledata),
              title: const Text('MyFirstStatefulPage'),
              onTap:() {
                context.go('/first-stateful');
              }
            ),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Map'),
              onTap:() {
                context.go('/map');
              }
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap:() async {
                try {
                  await FirebaseAuth.instance.signOut();
                  context.go('/login');
                } on FirebaseAuthException catch (_) {
                  print('Unable to logout');
                }
              }
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Second Home (PB)',
          ),
        ]
      ),
    );
  }
}