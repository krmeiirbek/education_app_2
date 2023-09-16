import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/enums/update_question.dart';
import 'package:education_app/core/enums/update_quiz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/src/quiz/data/models/answer_model.dart';
import 'package:education_app/src/quiz/data/models/question_model.dart';
import 'package:education_app/src/quiz/data/models/quiz_model.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class QuizRemoteDataSrc {
  Future<List<QuizModel>> getQuizzes();

  Future<void> addQuiz(Quiz quiz);

  Future<void> updateQuiz({
    required UpdateQuizAction action,
    dynamic quizData,
  });

  Future<void> deleteQuiz(String quizId);

  Future<List<QuestionModel>> getQuestions();

  Future<void> addQuestion(Question question);

  Future<void> updateQuestion({
    required UpdateQuestionAction action,
    required dynamic questionData,
  });

  Future<void> deleteQuestion(String questionId);

  Future<List<AnswerModel>> getAnswers();

  Future<void> addAnswer(Answer answer);

  Future<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
  });

  Future<void> deleteAnswer(String answerId);
}

class QuizRemoteDataSrcImpl implements QuizRemoteDataSrc {
  const QuizRemoteDataSrcImpl({
    required FirebaseFirestore firebaseFirestore,
    required FirebaseStorage firebaseStorage,
    required FirebaseAuth firebaseAuth,
  })  : _firebaseFirestore = firebaseFirestore,
        _firebaseStorage = firebaseStorage,
        _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage;
  final FirebaseAuth _firebaseAuth;

  @override
  Future<List<AnswerModel>> getAnswers() {
    // TODO: implement getAnswers
    throw UnimplementedError();
  }

  @override
  Future<List<QuestionModel>> getQuestions() {
    // TODO: implement getQuestions
    throw UnimplementedError();
  }

  @override
  Future<List<QuizModel>> getQuizzes() {
    // TODO: implement getQuizzes
    throw UnimplementedError();
  }

  @override
  Future<void> addAnswer(Answer answer) {
    // TODO: implement addAnswer
    throw UnimplementedError();
  }

  @override
  Future<void> addQuestion(Question question) {
    // TODO: implement addQuestion
    throw UnimplementedError();
  }

  @override
  Future<void> addQuiz(Quiz quiz) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      final quizRef = _firebaseFirestore
          .collection('courses')
          .doc(quiz.courseId)
          .collection('quizzes')
          .doc();

      final quizModel = (quiz as QuizModel).copyWith(id: quizRef.id);

      // Save the quiz to Firestore.
      await quizRef.set(quizModel.toMap());
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      // It can escape the catch block.
      rethrow;
    } catch (e) {
      // Else if it actually comes to the general catch block.
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> deleteAnswer(String answerId) {
    // TODO: implement deleteAnswer
    throw UnimplementedError();
  }

  @override
  Future<void> deleteQuestion(String questionId) {
    // TODO: implement deleteQuestion
    throw UnimplementedError();
  }

  @override
  Future<void> deleteQuiz(String quizId) {
    // TODO: implement deleteQuiz
    throw UnimplementedError();
  }

  @override
  Future<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
  }) {
    // TODO: implement updateAnswer
    throw UnimplementedError();
  }

  @override
  Future<void> updateQuestion({
    required UpdateQuestionAction action,
    required dynamic questionData,
  }) {
    // TODO: implement updateQuestion
    throw UnimplementedError();
  }

  @override
  Future<void> updateQuiz({required UpdateQuizAction action, quizData}) {
    // TODO: implement updateQuiz
    throw UnimplementedError();
  }
}
