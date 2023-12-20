import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quizck/data/hive_storage.dart';
import 'package:flutter_quizck/main.dart';
import 'package:flutter_quizck/model/quiz_model.dart';
import 'package:flutter_quizck/screens/admin_result_page.dart';
import 'package:flutter_quizck/screens/admin_wait.dart';
import 'package:flutter_quizck/screens/home_page.dart';
import 'package:flutter_quizck/widgets/app_icon.dart';

class SavedQuizPage extends StatefulWidget {
  const SavedQuizPage({super.key});

  @override
  State<SavedQuizPage> createState() => _SavedQuizPageState();
}

class _SavedQuizPageState extends State<SavedQuizPage> {
  late Future<List<Quiz>> allQuizzesFuture;
  late HiveLocalStorage _hiveLocalStorage;

  @override
  void initState() {
    _hiveLocalStorage = locator<HiveLocalStorage>();
    allQuizzesFuture = _hiveLocalStorage.getAllQuizzes();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Saved Quizes'),
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
      body: FutureBuilder<List<Quiz>>(
          future: allQuizzesFuture,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Map serverData = {};
                    List<Quiz> data = snapshot.data!;
                    return ListTile(
                      onTap: () async {
                        Socket socket = await Socket.connect('10.0.2.2', 3131);
                        socket.writeln(
                            '{"message":"create.quiz","objectType":"CreateQuizRequest","payload":${data[index].toJson()}}');

                        debugPrint(data[index].toJson());

                        socket.listen((event) {
                          serverData = json.decode(utf8.decode(event));
                          debugPrint(serverData.toString());
                          if (serverData['message'] == "stats") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    AdminResultPage(serverData: serverData)));
                          }
                          if (serverData["message"] == "shared.quiz.id") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AdminWaitScreen(
                                    serverData: serverData,
                                    currentQuiz: data[index])));
                          }
                          if (serverData["message"] == "participant.count") {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => AdminWaitScreen(
                                    serverData: serverData,
                                    currentQuiz: data[index])));
                          }
                        });
                      },
                      title: Text(data[index].quizName),
                    );
                  });
            } else {
              return const Center(
                child: Text('Error'),
              );
            }
          }),
    );
  }
}
