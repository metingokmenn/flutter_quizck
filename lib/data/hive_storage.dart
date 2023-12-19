import 'package:flutter_quizck/model/quiz_model.dart';
import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future<void> addQuiz({required Quiz quiz});
  Future<Quiz?> getQuiz({required String quizName});
  Future<List<Quiz>> getAllQuizzes();
  Future<int> getQuizID();
  Future<void> addQuizID({required int quizID});
}

class HiveLocalStorage extends LocalStorage {
  late Box<Quiz> _quizBox;
  late Box<int> _quizIDBox;

  HiveLocalStorage() {
    _quizBox = Hive.box<Quiz>('quizzes');
    _quizIDBox = Hive.box<int>('quizID');
  }

  @override
  Future<void> addQuiz({required Quiz quiz}) async {
    await _quizBox.put(quiz.quizName, quiz);
  }

  @override
  Future<List<Quiz>> getAllQuizzes() async {
    List<Quiz> allQuizzes = <Quiz>[];

    allQuizzes = _quizBox.values.toList();

    if (allQuizzes.isNotEmpty) {
      allQuizzes.sort((Quiz a, Quiz b) => b.quizName.compareTo(a.quizName));
    }

    return allQuizzes;
  }

  @override
  Future<Quiz?> getQuiz({required String quizName}) async {
    if (_quizBox.containsKey(quizName)) {
      return _quizBox.get(quizName);
    } else {
      return null;
    }
  }

  @override
  Future<int> getQuizID() async {
    int quizID = 0;

    quizID = _quizIDBox.values.first;

    return quizID;
  }

  @override
  Future<void> addQuizID({required int quizID}) async {
    await _quizIDBox.put('quizID', quizID);
  }
}
