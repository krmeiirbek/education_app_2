import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/enums/update_question.dart';
import 'package:education_app/core/enums/update_quiz.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';

abstract class QuizRepo {
  const QuizRepo();

  ResultFuture<List<Quiz>> getQuizzes();

  ResultFuture<void> addQuiz(Quiz quiz);

  ResultFuture<void> updateQuiz({
    required UpdateQuizAction action,
    required dynamic quizData,
  });

  ResultFuture<void> updateQuestion({
    required UpdateQuestionAction action,
    required dynamic questionData,
  });

  ResultFuture<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
  });
}
