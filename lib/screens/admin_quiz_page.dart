import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/model/quiz_model.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';

class AdminQuizPage extends StatefulWidget {
  AdminQuizPage({super.key, required this.currentQuiz, required this.quizID});

  Quiz currentQuiz;

  int quizID;

  @override
  State<AdminQuizPage> createState() => _AdminQuizPageState();
}

class _AdminQuizPageState extends State<AdminQuizPage> {
  final PageController controller = PageController();

  String buttonText = 'Next Question';

  bool isLast = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(widget.currentQuiz.quizName),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(
                            builder: (context) => const HomePage()),
                        (predicate) {
                      return false;
                    });
                  },
                  icon: AppIcon(
                    size: 36,
                  ))
            ],
          ),
          body: PageView.builder(
              controller: controller,
              itemCount: widget.currentQuiz.questions.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, questionIndex) {
                debugPrint(widget.currentQuiz.questions[questionIndex].options
                    .toString());
                if (questionIndex == widget.currentQuiz.questions.length - 1) {
                  isLast = true;
                }
                return Column(
                  children: [
                    Text(widget.currentQuiz.questions[questionIndex].question),
                    Expanded(
                      child: ListView.builder(
                          itemCount: widget.currentQuiz.questions[questionIndex]
                              .options.length,
                          itemBuilder: (context, index) {
                            String option =
                                String.fromCharCode('A'.codeUnitAt(0) + index);
                            return ListTile(
                              title: Text(
                                  '$option     ${widget.currentQuiz.questions[questionIndex].options[index]}'),
                            );
                          }),
                    ),
                    TextButton(
                        onPressed: () async {
                          Socket socket =
                              await Socket.connect('54.86.210.128', 3131);
                          if (isLast) {
                            socket.writeln(
                                '{"message":"end.quiz","objectType":"Integer","payload":${widget.quizID}}');
                          } else {
                            controller.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.bounceOut);

                            socket.writeln(
                                '{"message":"next.question","objectType":"Integer","payload":${widget.quizID}}');
                          }
                        },
                        child: Text(isLast ? 'End Quiz' : 'Next Question'))
                  ],
                );
              })),
    );
  }
}
