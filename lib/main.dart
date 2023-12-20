import 'package:flutter/material.dart';
import 'package:flutter_quizck/data/hive_storage.dart';
import 'package:flutter_quizck/model/question_model.dart';
import 'package:flutter_quizck/model/quiz_model.dart';

import 'package:flutter_quizck/screens/home_page.dart';

import 'package:get_it/get_it.dart';
import 'package:hive_flutter/adapters.dart';

final locator = GetIt.instance;

void setup() {
  locator.registerSingleton<HiveLocalStorage>(HiveLocalStorage());
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(QuizAdapter());
  Hive.registerAdapter(QuestionAdapter());
  var quizBox = await Hive.openBox<Quiz>('quizzes');
  var userCountBox = await Hive.openBox<int>('quizID');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupHive();
  setup();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quizck',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
