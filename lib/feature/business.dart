import 'package:flutter/material.dart';

class Business extends StatelessWidget {
  const Business({super.key});

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 2: Business',
      style: optionStyle,
    );
  }
}