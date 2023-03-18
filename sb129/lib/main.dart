import 'package:flutter/material.dart';
import 'package:sb129/screens/screens.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SB-129',
        home: NavbarScreen());
  }
}
