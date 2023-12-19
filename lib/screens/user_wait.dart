import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/screens/admin_wait.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:flutter_quizck/widgets/custom_text_field_readonly.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;

class UserWaitScreen extends StatefulWidget {
  UserWaitScreen(
      {super.key,
      required this.serverData,
      required this.quizID,
      required this.username,
      required this.questionIndex});

  int quizID;

  Map serverData;

  int questionIndex;

  String username;
  @override
  State<UserWaitScreen> createState() => _UserWaitScreenState();
}

class _UserWaitScreenState extends State<UserWaitScreen> {
  List<Color> fillColors = [];

  int? selectedAnswer;

  @override
  Widget build(BuildContext context) {
    if (widget.serverData["message"] == "participant.count") {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          didPop = false;
        },
        child: Scaffold(
          appBar: AppBar(
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
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
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
                          "Participant count: ${widget.serverData["payload"]}"),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else if (widget.serverData["message"] == "question") {
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
                ),
              )
            ],
          ),
          body: Column(children: [
            TextFieldReadOnly(
              hintText: widget.serverData["payload"]["question"].toString(),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: widget.serverData["payload"]["options"].length,
                  itemBuilder: (context, index) {
                    for (int i = 0;
                        i < widget.serverData["payload"]["options"].length;
                        i++) {
                      fillColors.add(Colors.white);
                    }
                    String option =
                        String.fromCharCode('A'.codeUnitAt(0) + index);

                    return TextFieldReadOnly(
                      fillColor: fillColors[index],
                      onTap: () async {
                        if (selectedAnswer == null) {
                          setState(() {
                            selectedAnswer = index;
                          });
                        }

                        if (selectedAnswer ==
                            widget.serverData["payload"]
                                ["correctAnswerIndex"]) {
                          debugPrint(
                              "Correct answer: ${widget.serverData["payload"]["correctAnswerIndex"]}");
                          debugPrint("Selected answer: $selectedAnswer");

                          setState(() {
                            fillColors[selectedAnswer!] = Colors.green;
                          });
                        } else if (selectedAnswer !=
                            widget.serverData["payload"]
                                ["correctAnswerIndex"]) {
                          setState(() {
                            for (var i = 0; i < fillColors.length; i++) {
                              if (i ==
                                  widget.serverData["payload"]
                                      ["correctAnswerIndex"]) {
                                continue;
                              } else {
                                setState(() {
                                  fillColors[i] = Colors.red;
                                });
                              }
                            }
                          });
                        }
                        debugPrint(selectedAnswer.toString());
                        Socket socket = await Socket.connect('10.0.2.2', 3131);

                        socket.writeln(
                            '{"message":"answer.question","objectType":"Answer","payload":{"quizId":${widget.quizID},"username":"${widget.username}","questionIndex":${widget.questionIndex - 1},"optionIndex":$selectedAnswer}}');

                        debugPrint(
                            "question index: ${widget.questionIndex - 1}");
                      },
                      hintText:
                          "$option ${widget.serverData["payload"]["options"][index]}",
                    );
                  }),
            )
          ]),
        ),
      );
    } else if (widget.serverData["message"] == "stats") {
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
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: widget.serverData["payload"]["scores"].length,
                    itemBuilder: (context, index) {
                      return Center(
                        child: Text(widget.serverData["payload"]["scores"]
                                [index]
                            .toString()
                            .replaceAll('[', '')
                            .replaceAll(']', '')),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
