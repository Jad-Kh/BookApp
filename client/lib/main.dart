import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        secondaryHeaderColor: const Color.fromARGB(255, 77, 77, 77),
        accentColor: const Color.fromARGB(255, 238, 154, 76),
        scaffoldBackgroundColor: const Color.fromARGB(0, 44, 44, 44),
      ),
      home: HomeScreen(),
    );
  }
}