import 'package:flutter/material.dart';

class MADTextformfield extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final FormFieldValidator? validator;
  
  const MADTextformfield({
    super.key,
    required this.labelText,
    required this.controller,
    this.obscureText = false,
    this.validator,
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
            autovalidateMode: AutovalidateMode.onUserInteraction,
            obscureText: obscureText,
            controller: controller,
            validator: validator,
          ),
        ],
      ),
    );
  }
}