import 'package:flutter/material.dart';
import 'package:flutter_quizck/screens/admin_wait.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/screens/user_join_page.dart';
import 'package:flutter_quizck/screens/user_wait.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
