import 'package:flutter/material.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:flutter_quizck/widgets/custom_text_field.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'QUIZCK',
                      style:
                          TextStyle(fontSize: 64, fontWeight: FontWeight.w400),
                    ),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppIcon(
                          size: 70,
                        ))
                  ],
                ),
              ),
              Column(
                children: [
                  TextFieldWithIconButton(
                    labelText: 'JOIN TO A QUIZ',
                    hintText: '<share_link_received>',
                    type: 'JOIN',
                    isBold: false,
                  ),
                  TextFieldWithIconButton(
                    labelText: 'CREATE A QUIZ',
                    hintText: '<name_for_quiz>',
                    type: 'CREATE',
                    isBold: false,
                  ),
                  TextFieldWithIconButton(
                    hintText: 'Start A Solved Quiz',
                    isBold: true,
                    readOnly: true,
                    type: 'START',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
