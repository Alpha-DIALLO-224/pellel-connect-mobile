import 'package:flutter/material.dart';

class NotificationMyApp extends StatelessWidget {
  const NotificationMyApp({super.key});

  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'Index 3: Notification',
      style: optionStyle,
    );
  }
}