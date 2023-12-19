import 'package:flutter_quizck/model/quiz_model.dart';
import 'package:hive/hive.dart';

abstract class LocalStorage {
  Future<void> addQuiz({required Quiz quiz});
  Future<Quiz?> getQuiz({required String quizName});
  Future<List<Quiz>> getAllQuizzes();
}

class HiveLocalStorage extends LocalStorage {
  late Box<Quiz> _quizBox;

  HiveLocalStorage() {
    _quizBox = Hive.box<Quiz>('quizzes');
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
}
