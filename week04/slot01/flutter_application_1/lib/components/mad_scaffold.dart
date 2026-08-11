import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';
import 'package:go_router/go_router.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
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