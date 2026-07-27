import 'package:flutter/material.dart';

class MyFirstStatefulPage extends StatefulWidget {
  const MyFirstStatefulPage({super.key});

  @override
  State<MyFirstStatefulPage> createState() => _MyFirstStatefulPageState();
}

class _MyFirstStatefulPageState extends State<MyFirstStatefulPage> {
  int _counter = 0;
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text('Counter: $_counter'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            child: Text('Increment Counter'),
          ),
        ],
      ),
    );
  }
}