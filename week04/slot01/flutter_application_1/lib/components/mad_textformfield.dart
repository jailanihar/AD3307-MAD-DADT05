import 'package:flutter/material.dart';

class MADTextformfield extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  
  const MADTextformfield({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      // padding: const EdgeInsets.all(12.0),
      padding: const EdgeInsets.symmetric(
        horizontal: 24, vertical: 12
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              labelText,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                // color: Color(0xFFC49799),
                color: Color.fromARGB(255, 49, 34, 112),
              ),
            ),
          ),
          TextFormField(
            obscureText: obscureText,
            controller: controller,
          ),
        ],
      ),
    );
  }
}