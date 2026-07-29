import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/mad_scaffold.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MADScaffold(
      titleText: 'Home',
    );
  }
}