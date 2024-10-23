import 'package:flutter/material.dart';
import 'package:pellel_connect/layout/main_layout.dart';

class PellelConnectApp extends StatelessWidget {
  const PellelConnectApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Management App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: const TextTheme(
          headlineSmall: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold, color: Colors.black87),
          bodySmall: TextStyle(fontSize: 16.0, color: Colors.black54),
        ),
      ),
      home: MainLayout(),
    );
  }
}