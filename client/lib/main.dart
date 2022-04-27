import 'package:provider/provider.dart';
import 'package:client/providers/auth_provider.dart';
import 'package:client/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthProvider(),
        ),
      ],
      child: MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        secondaryHeaderColor: const Color.fromARGB(255, 77, 77, 77),
        accentColor: const Color.fromARGB(255, 238, 154, 76),
        scaffoldBackgroundColor: const Color.fromARGB(0, 44, 44, 44),
      ),
      routes: {
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
      },
      home: LoginScreen(),
    ),
    );
  }
}