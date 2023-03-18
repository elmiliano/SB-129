import 'package:flutter/material.dart';

class NavbarScreen extends StatelessWidget {
  NavbarScreen({super.key});

  List<Widget> screens = [];
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Navbar Screen')),
      body: Column(),
      bottomNavigationBar: NavigationBar(
        destinations: screens,
        selectedIndex: index,
      ),
    );
  }
}
