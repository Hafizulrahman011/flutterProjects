import 'package:flutter/material.dart';
import 'home_page.dart'; // Import your HomePage file

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key); // Add Key to your constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
