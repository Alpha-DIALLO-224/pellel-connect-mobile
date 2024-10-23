import 'package:flutter/material.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 4: Settings',
      style: optionStyle,
    );
  }
}