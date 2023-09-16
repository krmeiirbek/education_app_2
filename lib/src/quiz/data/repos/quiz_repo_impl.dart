import 'package:dartz/dartz.dart';
import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/enums/update_question.dart';
import 'package:education_app/core/enums/update_quiz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/errors/failures.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/data/datasources/quiz_remote_data_src.dart';
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
  ResultFuture<List<Quiz>> getQuizzes() async {
    try {
      final quizzes = await _remoteDataSrc.getQuizzes();
      return Right(quizzes);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }

  @override
  ResultFuture<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
  }) async {
    try {
      await _remoteDataSrc.updateAnswer(
        action: action,
        answerData: answerData,
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
  }) async {
    try {
      await _remoteDataSrc.updateQuestion(
        action: action,
        questionData: questionData,
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
  }) async {
    try {
      await _remoteDataSrc.updateQuiz(
        action: action,
        quizData: quizData,
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message, statusCode: e.statusCode));
    }
  }
}
