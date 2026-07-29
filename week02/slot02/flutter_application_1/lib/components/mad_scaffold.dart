import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home_page.dart';

class MADScaffold extends StatelessWidget {
  final String titleText;

  const MADScaffold({
    super.key,
    required this.titleText,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(titleText),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView(
        children: [

        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap:() {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const HomePage())
                );
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