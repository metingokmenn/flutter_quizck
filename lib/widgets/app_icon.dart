import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  AppIcon({super.key, required this.size});

  double size;

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.question_answer_outlined,
        size: size, color: const Color.fromARGB(255, 104, 47, 6));
  }
}
