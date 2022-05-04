import 'package:client/providers/book_provider.dart';
import 'package:client/providers/lists_provider.dart';
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
        ChangeNotifierProvider(
          create: (context) => BookProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ListProvider(),
        ),
      ],
      child: MaterialApp(
      title: 'Flutter Travel UI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 255, 255, 255),
        secondaryHeaderColor: const Color.fromARGB(255, 77, 77, 77),
        scaffoldBackgroundColor: Color.fromARGB(255, 0, 0, 0),
        primarySwatch: Colors.orange,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Color.fromRGBO(44, 44, 44, 1), 
                                                               unselectedItemColor: Color.fromARGB(255, 77, 77, 77),
                                                               selectedItemColor: Color.fromARGB(255, 255, 255, 255)),
        textTheme: Theme.of(context).textTheme.apply(      bodyColor: Colors.white,      displayColor: Colors.white,   )
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