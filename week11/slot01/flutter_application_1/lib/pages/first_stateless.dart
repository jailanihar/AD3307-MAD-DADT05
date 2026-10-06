import 'package:flutter/material.dart';

class MyFirstStatelessPage extends StatelessWidget {
  const MyFirstStatelessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Hello World'),
          ElevatedButton(
            onPressed: () {},
            child: Text('I dont do anything')
          ),
        ],
      )
    );
  }
}