import 'package:flutter/material.dart';
import 'package:pellel_connect/feature/business.dart';
import 'package:pellel_connect/feature/home.dart';
import 'package:pellel_connect/feature/notification.dart';
import 'package:pellel_connect/feature/settings.dart';

class BodyMainLayout extends StatelessWidget {
  final int selectedIndex;

  const BodyMainLayout({
    required this.selectedIndex,
    super.key,
  });

  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Business(),
    NotificationMyApp(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: IndexedStack(
        index: selectedIndex,
        children: _widgetOptions,
      ),
    );
  }
}
