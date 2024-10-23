import 'package:flutter/material.dart';
import 'package:pellel_connect/layout/bottom_navigation.dart';
import 'package:pellel_connect/layout/body_main_layout.dart';
import 'header.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _selectedIndex = 0;
  String _appBarTitle = 'Accueil';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _appBarTitle = 'Accueil';
          break;
        case 1:
          _appBarTitle = 'Business';
          break;
        case 2:
          _appBarTitle = 'Notifications';
          break;
        case 3:
          _appBarTitle = 'Settings';
          break;
        default:
          _appBarTitle = 'Home';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(title: _appBarTitle),
      body: BodyMainLayout(selectedIndex: _selectedIndex),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: _selectedIndex,
        onItemTapped: _onItemTapped,
      ),
    );
  }
}
