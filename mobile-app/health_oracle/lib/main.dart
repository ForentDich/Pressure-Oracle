import 'package:flutter/material.dart';
import 'features/home/presentation/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Oracle',
      theme: ThemeData(
        fontFamily: 'Manrope',
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}