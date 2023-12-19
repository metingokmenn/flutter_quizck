import 'package:flutter/material.dart';
import 'package:flutter_quizck/model/question.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';
import 'package:fluttertoast/fluttertoast.dart';

class QuizCreatePage extends StatefulWidget {
  QuizCreatePage({super.key, required this.quizName});

  String quizName;

  @override
  State<QuizCreatePage> createState() => _QuizCreatePageState();
}

class _QuizCreatePageState extends State<QuizCreatePage> {
  int questionCount = 1;
  int itemCountList = 6;

  final PageController pageController = PageController();
  List<TextEditingController> controllers = [];

  final TextEditingController questionController = TextEditingController();

  List<Question> questionList = [];
  List<String> options = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Quiz name: ${widget.quizName.toString()}'),
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
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                  itemCount: itemCountList + 1,
                  itemBuilder: (context, index) {
                    while (controllers.length <= index) {
                      controllers.add(TextEditingController());
                    }
                    String option =
                        String.fromCharCode('A'.codeUnitAt(0) + index - 1);
                    if (index == 0) {
                      return TextFormField(
                        controller: questionController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            hintText: 'Write your question statement here',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24))),
                      );
                    }
                    if (index == itemCountList - 1) {
                      return TextButton(
                          onPressed: () {
                            setState(() {
                              itemCountList++;
                            });
                          },
                          child: const Text('Add Option +'));
                    }

                    if (index == itemCountList) {
                      return Column(
                        children: [
                          TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.black)),
                            onPressed: () {
                              debugPrint(itemCountList.toString());
                              for (int i = 0; i < controllers.length; i++) {
                                if (controllers[i].text.isNotEmpty) {
                                  options.add(controllers[i].text);
                                }
                              }
                              if (options.isNotEmpty &&
                                  questionController.text.isNotEmpty) {
                                questionList.add(Question(
                                    question: questionController.text,
                                    options: options,
                                    correctAnswerIndex: 0));
                                debugPrint(questionList.toString());
                                setState(() {
                                  questionCount++;
                                  for (var element in controllers) {
                                    element.clear();
                                  }
                                  questionController.clear();
                                  options = [];
                                });
                              } else {
                                Fluttertoast.showToast(
                                    msg:
                                        'Please provide necessary informations.');
                              }
                            },
                            child: const Text(
                              'SAVE QUESTION',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          Text('Question $questionCount'),
                        ],
                      );
                    }

                    return Dismissible(
                      onDismissed: (direction) {
                        setState(() {
                          itemCountList--;
                        });
                      },
                      key: UniqueKey(),
                      child: TextFormField(
                        controller: controllers[index],
                        decoration: InputDecoration(hintText: option),
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
