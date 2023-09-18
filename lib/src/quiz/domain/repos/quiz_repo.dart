import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/enums/update_question.dart';
import 'package:education_app/core/enums/update_quiz.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';

abstract class QuizRepo {
  const QuizRepo();

  ResultFuture<List<Quiz>> getQuizzes(String courseId);

  ResultFuture<void> addQuiz(Quiz quiz);

  ResultFuture<void> updateQuiz({
    required UpdateQuizAction action,
    required dynamic quizData,
    required String courseId,
    required String quizId,
  });

  ResultFuture<void> deleteQuiz(
    String courseId,
    String quizId,
  );

  ResultFuture<List<Question>> getQuestions(
    String courseId,
    String quizId,
  );

  ResultFuture<void> addQuestion(Question question);

  ResultFuture<void> updateQuestion({
    required UpdateQuestionAction action,
    required dynamic questionData,
    required String courseId,
    required String quizId,
    required String questionId,
  });

  ResultFuture<void> deleteQuestion(
    String courseId,
    String quizId,
    String questionId,
  );

  ResultFuture<List<Answer>> getAnswers(
    String courseId,
    String quizId,
    String questionId,
  );

  ResultFuture<void> addAnswer(Answer answer);

  ResultFuture<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
    required String courseId,
    required String quizId,
    required String questionId,
    required String answerId,
  });

  ResultFuture<void> deleteAnswer(
    String courseId,
    String quizId,
    String questionId,
    String answerId,
  );
}
