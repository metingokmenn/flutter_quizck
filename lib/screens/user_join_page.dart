import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/screens/user_wait.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:flutter_quizck/widgets/custom_text_field_readonly.dart';

class UserJoinPage extends StatefulWidget {
  const UserJoinPage({
    super.key,
    required this.quizID,
  });

  final int quizID;

  @override
  State<UserJoinPage> createState() => _UserJoinPageState();
}

class _UserJoinPageState extends State<UserJoinPage> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

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
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Username',
              ),
              TextFieldReadOnly(
                controller: controller,
                hintText: '<username_for_quiz>',
                readOnly: false,
              ),
              const SizedBox(
                height: 30,
              ),
              TextButton(
                onPressed: () async {
                  Socket socket = await Socket.connect('54.86.210.128', 3131);
                  int questionIndex = 0;
                  Map serverData = {};
                  if (controller.text.isNotEmpty) {
                    socket.writeln(
                        '{"message":"join.quiz","objectType":"JoinQuizRequest","payload":{"quizId":${widget.quizID},"username":"${controller.text}"}}');

                    socket.listen((event) {
                      serverData = json.decode(utf8.decode(event));
                      if (serverData["message"] == "question") {
                        questionIndex++;
                      }
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => UserWaitScreen(
                            serverData: serverData,
                            questionIndex: questionIndex,
                            quizID: widget.quizID,
                            username: controller.text),
                      ));
                    });
                  }
                },
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green.shade700),
                    fixedSize: MaterialStateProperty.all(const Size(250, 50))),
                child: const Text(
                  'JOIN',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
