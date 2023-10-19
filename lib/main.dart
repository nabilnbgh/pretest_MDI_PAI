import 'package:flutter/material.dart';
import 'package:pandawatest/screens/entrypage/loginpage.dart';
import 'package:pandawatest/screens/entrypage/registerpage.dart';
import 'package:pandawatest/screens/homepage/homepage.dart';

void main() {
  runApp(const PAIApp());
}

class PAIApp extends StatelessWidget {
  const PAIApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PAI App',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00AA13)),
        primaryColor: Colors.green,
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage()
      },
    );
  }
}
