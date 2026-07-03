import 'package:flutter/material.dart';
import 'screens/home_page.dart';

void main() {
  runApp(const GasExamApp());
}

class GasExamApp extends StatelessWidget {
  const GasExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AW高圧ガス勉強会',
      theme: ThemeData(
        colorSchemeSeed: Colors.blue,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}