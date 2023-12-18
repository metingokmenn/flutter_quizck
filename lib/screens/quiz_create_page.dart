import 'package:flutter/material.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';

class QuizCreatePage extends StatefulWidget {
  QuizCreatePage({super.key, required this.quizName});

  String quizName;

  @override
  State<QuizCreatePage> createState() => _QuizCreatePageState();
}

class _QuizCreatePageState extends State<QuizCreatePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quiz name: ${widget.quizName.toString()}'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (predicate) {
                  return false;
                });
              },
              icon: AppIcon(
                size: 36,
              ))
        ],
      ),
    );
  }
}
