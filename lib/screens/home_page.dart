import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:flutter_quizck/widgets/custom_text_field.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<String> streamController = StreamController<String>();
  Stream get messagesStream => streamController.stream;

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
                    hintText: 'Start A Saved Quiz',
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
