import 'package:flutter/material.dart';
import 'package:flutter_quizck/model/quiz_model.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';

class AdminQuizPage extends StatefulWidget {
  AdminQuizPage({super.key, required this.currentQuiz});

  Quiz currentQuiz;

  @override
  State<AdminQuizPage> createState() => _AdminQuizPageState();
}

class _AdminQuizPageState extends State<AdminQuizPage> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
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
        body: Text(widget.currentQuiz.toString()),
      ),
    );
  }
}
