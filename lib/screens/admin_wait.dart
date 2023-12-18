import 'package:flutter/material.dart';
import 'package:flutter_quizck/screens/quiz_end_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:flutter_quizck/widgets/custom_text_field_readonly.dart';

class AdminWaitScreen extends StatelessWidget {
  const AdminWaitScreen({super.key});

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
      body: Column(
        children: [
          Column(
            children: [
              const Text(
                'SHARE LINK HERE',
              ),
              TextFieldReadOnly(
                hintText: '<link_for_participants>',
                suffixIcon: const Icon(
                  Icons.copy,
                  color: Colors.grey,
                ),
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
                const Positioned(
                  top: 150,
                  right: 100,
                  child: Text(
                    'NUMBER OF PARTICIPANTS: 4',
                  ),
                )
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const QuizEndPage()));
              },
              child: const Text('QUIZ END PAGE'))
        ],
      ),
    );
  }
}
