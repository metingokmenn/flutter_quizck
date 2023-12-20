import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/screens/quiz_create_page.dart';
import 'package:flutter_quizck/screens/saved_quiz_page.dart';
import 'package:flutter_quizck/screens/user_join_page.dart';
import 'package:flutter_quizck/screens/user_wait.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class TextFieldWithIconButton extends StatelessWidget {
  TextFieldWithIconButton(
      {super.key,
      this.labelText,
      this.hintText,
      required this.isBold,
      required this.type,
      this.readOnly,
      this.decoration,
      this.inputController,
      this.onPressed});

  String? labelText;

  String? hintText;

  bool? readOnly;

  bool isBold;

  TextEditingController? inputController;

  InputDecoration? decoration;

  void Function()? onPressed;

  String? type;
  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            labelText ?? '',
          ),
          TextFormField(
            controller: inputController ?? controller,
            readOnly: readOnly ?? false,
            decoration: decoration ??
                InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown.shade300),
                      borderRadius: BorderRadius.circular(24)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24)),
                  alignLabelWithHint: false,
                  hintText: hintText,
                  hintStyle: isBold
                      ? const TextStyle(
                          fontWeight: FontWeight.w500, color: Colors.black)
                      : const TextStyle(),
                  suffixIcon: Container(
                    width: 80,
                    height: 70,
                    decoration: BoxDecoration(
                      border: const Border(
                        right: BorderSide(color: Colors.black26, width: 1),
                        left: BorderSide(color: Colors.black26, width: 1),
                        top: BorderSide(color: Colors.black26, width: 1),
                        bottom: BorderSide(color: Colors.black26, width: 1),
                      ),
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(24),
                          bottomRight: Radius.circular(24)),
                      gradient: LinearGradient(
                        colors: [
                          Colors.brown.shade400,
                          Colors.brown.shade300,
                          Colors.brown.shade200,
                          Colors.brown.shade100,
                          Colors.white,
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: IconButton(
                        onPressed: onPressed ??
                            () {
                              if (type == 'JOIN') {
                                if (controller.text.isNotEmpty &&
                                    controller.text.length == 4) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => UserJoinPage(
                                      quizID: int.parse(controller.text),
                                    ),
                                  ));
                                }
                              } else if (type == 'CREATE') {
                                if (controller.text.isNotEmpty) {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => QuizCreatePage(
                                          quizName: controller.text)));
                                }
                              } else if (type == 'START') {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        const SavedQuizPage()));
                              }
                            },
                        icon: const Icon(
                          Icons.arrow_forward,
                        )),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Color hexToColor(String hexColor) {
    // Remove the leading # if it exists
    hexColor = hexColor.replaceAll("#", "");

    // Parse the hex color code
    int parsedColor = int.parse(hexColor, radix: 16);

    // Return the Color object
    return Color(parsedColor);
  }
}
