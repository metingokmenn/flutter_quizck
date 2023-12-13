import 'package:flutter/material.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:flutter_quizck/widgets/custom_text_field_readonly.dart';

class QuizEndPage extends StatelessWidget {
  const QuizEndPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {},
              icon: AppIcon(
                size: 36,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TextFieldReadOnly(
              hintText: 'Your Quizzes',
            ),
            const SizedBox(
              height: 30,
            ),
            Column(
              children: [
                TextFieldReadOnly(
                  hintText: '1.Quiz Name 1',
                ),
                TextFieldReadOnly(
                  hintText: '2.Quiz Name 2',
                ),
                TextFieldReadOnly(
                  hintText: '3.Quiz Name 3',
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
