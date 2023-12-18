import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/screens/user_wait.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:flutter_quizck/widgets/custom_text_field_readonly.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class UserJoinPage extends StatelessWidget {
  const UserJoinPage({super.key, required this.quizID});

  final int quizID;

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
                  final socket = await Socket.connect('10.0.2.2', 3131);
                  Map serverData = {};
                  if (controller.text.isNotEmpty) {
                    socket.writeln(
                        '{"message":"join.quiz","objectType":"JoinQuizRequest","payload":{"quizId":$quizID,"username":"${controller.text}"}}');

                    socket.listen(onDone: () {}, (data) {
                      serverData = json.decode(utf8.decode(data)) as Map;
                      debugPrint(serverData.toString());
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              UserWaitScreen(socket: socket)));
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