import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/enums/update_question.dart';
import 'package:education_app/core/enums/update_quiz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/data/datasources/quiz_remote_data_src.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';

class QuizRepoImpl implements QuizRepo {
  const QuizRepoImpl(this._remoteDataSrc);

  final QuizRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> addQuiz(Quiz quiz) async {
    try {
      await _remoteDataSrc.addQuiz(quiz);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Quiz>> getQuizzes(String courseId) async {
    try {
      final quizzes = await _remoteDataSrc.getQuizzes(courseId);
      return Right(quizzes);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
    required String courseId,
    required String quizId,
    required String questionId,
    required String answerId,
  }) async {
    try {
      await _remoteDataSrc.updateAnswer(
        action: action,
        answerData: answerData,
        courseId: courseId,
        quizId: quizId,
        questionId: questionId,
        answerId: answerId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateQuestion({
    required UpdateQuestionAction action,
    required dynamic questionData,
    required String courseId,
    required String quizId,
    required String questionId,
  }) async {
    try {
      await _remoteDataSrc.updateQuestion(
        action: action,
        questionData: questionData,
        courseId: courseId,
        quizId: quizId,
        questionId: questionId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateQuiz({
    required UpdateQuizAction action,
    required dynamic quizData,
    required String courseId,
    required String quizId,
  }) async {
    try {
      await _remoteDataSrc.updateQuiz(
        action: action,
        quizData: quizData,
        courseId: courseId,
        quizId: quizId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> addAnswer(Answer answer) async {
    try {
      await _remoteDataSrc.addAnswer(answer);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> addQuestion(Question question) async {
    try {
      await _remoteDataSrc.addQuestion(question);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> deleteAnswer(
    String courseId,
    String quizId,
    String questionId,
    String answerId,
  ) async {
    try {
      await _remoteDataSrc.deleteAnswer(
        courseId,
        quizId,
        questionId,
        answerId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> deleteQuestion(
    String courseId,
    String quizId,
    String questionId,
  ) async {
    try {
      await _remoteDataSrc.deleteQuestion(courseId, quizId, questionId);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> deleteQuiz(
    String courseId,
    String quizId,
  ) async {
    try {
      await _remoteDataSrc.deleteQuiz(
        courseId,
        quizId,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Answer>> getAnswers(
    String courseId,
    String quizId,
    String questionId,
  ) async {
    try {
      final answers = await _remoteDataSrc.getAnswers(
        courseId,
        quizId,
        questionId,
      );
      return Right(answers);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<List<Question>> getQuestions(
    String courseId,
    String quizId,
  ) async {
    try {
      final questions = await _remoteDataSrc.getQuestions(
        courseId,
        quizId,
      );
      return Right(questions);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
