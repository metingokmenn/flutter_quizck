import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/data/hive_storage.dart';
import 'package:flutter_quizck/main.dart';
import 'package:flutter_quizck/model/quiz_model.dart';
import 'package:flutter_quizck/screens/admin_quiz_page.dart';
import 'package:flutter_quizck/screens/admin_result_page.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:flutter_quizck/widgets/custom_text_field_readonly.dart';

class AdminWaitScreen extends StatefulWidget {
  const AdminWaitScreen(
      {super.key, required this.serverData, required this.currentQuiz});

  final Map serverData;

  final Quiz currentQuiz;

  @override
  State<AdminWaitScreen> createState() => _AdminWaitScreenState();
}

class _AdminWaitScreenState extends State<AdminWaitScreen> {
  late Future<int> quizIDFuture;
  late HiveLocalStorage _hiveLocalStorage;

  void getQuizID() async {
    await _hiveLocalStorage.addQuizID(quizID: widget.serverData["payload"]);
  }

  @override
  void initState() {
    _hiveLocalStorage = locator<HiveLocalStorage>();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int participantCount = 0;

    int quizID = 0;

    if (widget.serverData["message"] == 'participant.count') {
      participantCount = widget.serverData["payload"];
    }
    if (widget.serverData["message"] == 'shared.quiz.id') {
      getQuizID();
    }

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
        body: Column(
          children: [
            Column(
              children: [
                const Text(
                  'SHARE LINK HERE',
                ),
                FutureBuilder(
                  future: _hiveLocalStorage.getQuizID(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      quizID = snapshot.data!;
                      return TextFieldReadOnly(
                        hintText: snapshot.data.toString(),
                        suffixIcon: const Icon(
                          Icons.copy,
                          color: Colors.grey,
                        ),
                      );
                    } else {
                      return const Text('Error');
                    }
                  },
                )
              ],
            ),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 10,
                    top: 150,
                    child: SizedBox(
                        height: MediaQuery.of(context).size.height - 300,
                        child: const VerticalDivider(
                          thickness: 0.6,
                          color: Colors.black,
                        )),
                  ),
                  const Positioned(
                    top: 50,
                    right: 100,
                    child: Text(
                      'Please wait until quiz starts...',
                    ),
                  ),
                  Positioned(
                    top: 150,
                    right: 100,
                    child: Text(
                      'NUMBER OF PARTICIPANTS: $participantCount',
                    ),
                  )
                ],
              ),
            ),
            TextButton(
                onPressed: () async {
                  Socket socket = await Socket.connect('10.0.2.2', 3131);
                  int quizID = await _hiveLocalStorage.getQuizID();
                  socket.writeln(
                      '{"message":"start.quiz","objectType":"Integer","payload":$quizID}');

                  debugPrint(widget.serverData.toString());
                  
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => AdminQuizPage(
                          currentQuiz: widget.currentQuiz, quizID: quizID),
                    ),
                  );
                },
                child: const Text('START QUIZ'))
          ],
        ),
      ),
    );
  }
}
