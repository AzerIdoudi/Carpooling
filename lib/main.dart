import 'package:flutter/material.dart';
import 'Pages/createCar.dart';
import 'Pages/homePage.dart';
import 'Pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CARPOOLING BY EZ',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const login(),
    );
  }
}
