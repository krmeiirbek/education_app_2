import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/enums/update_question.dart';
import 'package:education_app/core/enums/update_quiz.dart';
import 'package:education_app/core/errors/exceptions.dart';
import 'package:education_app/core/utils/datasource_utils.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/data/models/answer_model.dart';
import 'package:education_app/src/quiz/data/models/question_model.dart';
import 'package:education_app/src/quiz/data/models/quiz_model.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class QuizRemoteDataSrc {
  Future<List<QuizModel>> getQuizzes(String courseId);

  Future<void> addQuiz(Quiz quiz);

  Future<void> updateQuiz({
    required UpdateQuizAction action,
    required dynamic quizData,
    required String courseId,
    required String quizId,
  });

  Future<void> deleteQuiz(
    String courseId,
    String quizId,
  );

  Future<List<QuestionModel>> getQuestions(
    String courseId,
    String quizId,
  );

  Future<void> addQuestion(Question question);

  Future<void> updateQuestion({
    required UpdateQuestionAction action,
    required dynamic questionData,
    required String courseId,
    required String quizId,
    required String questionId,
  });

  Future<void> deleteQuestion(
    String courseId,
    String quizId,
    String questionId,
  );

  Future<List<AnswerModel>> getAnswers(
    String courseId,
    String quizId,
    String questionId,
  );

  Future<void> addAnswer(Answer answer);

  Future<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
    required String courseId,
    required String quizId,
    required String questionId,
    required String answerId,
  });

  Future<void> deleteAnswer(
    String courseId,
    String quizId,
    String questionId,
    String answerId,
  );
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
  Future<List<AnswerModel>> getAnswers(
    String courseId,
    String quizId,
    String questionId,
  ) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      return _firebaseFirestore
          .collection('courses')
          .doc(courseId)
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .doc(questionId)
          .collection('answers')
          .get()
          .then(
            (value) => value.docs
                .map((doc) => AnswerModel.fromMap(doc.data()))
                .toList(),
          );
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
  Future<List<QuestionModel>> getQuestions(
    String courseId,
    String quizId,
  ) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      return _firebaseFirestore
          .collection('courses')
          .doc(courseId)
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .get()
          .then(
            (value) => value.docs
                .map((doc) => QuestionModel.fromMap(doc.data()))
                .toList(),
          );
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
  Future<List<QuizModel>> getQuizzes(String courseId) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      return _firebaseFirestore
          .collection('courses')
          .doc(courseId)
          .collection('quizzes')
          .get()
          .then(
            (value) =>
                value.docs.map((doc) => QuizModel.fromMap(doc.data())).toList(),
          );
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
  Future<void> addAnswer(Answer answer) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      final answerRef = _firebaseFirestore
          .collection('courses')
          .doc(answer.courseId)
          .collection('quizzes')
          .doc(answer.quizId)
          .collection('questions')
          .doc(answer.questionId)
          .collection('answers')
          .doc();

      var answerModel = answer as AnswerModel;

      if (answerModel.imageIsFile) {
        final imageRef = _firebaseStorage.ref().child(
          'quiz_pics/${answerModel.courseId}/${answerModel.quizId}/${answerModel.questionId}/${answerModel.uid}--pfp',
        );
        await imageRef.putFile(File(answerModel.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          answerModel = answerModel.copyWith(image: url);
        });
      }

      // Save the quiz to Firestore.
      await answerRef.set(answerModel.toMap());
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
  Future<void> addQuestion(Question question) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      final questionRef = _firebaseFirestore
          .collection('courses')
          .doc(question.courseId)
          .collection('quizzes')
          .doc(question.quizId)
          .collection('questions')
          .doc();

      var questionModel =
          (question as QuestionModel).copyWith(id: questionRef.id);

      if (questionModel.imageIsFile) {
        final imageRef = _firebaseStorage.ref().child(
          'quiz_pics/${questionModel.courseId}/${questionModel.quizId}/${questionModel.id}--pfp',
        );
        await imageRef.putFile(File(questionModel.image!)).then((value) async {
          final url = await value.ref.getDownloadURL();
          questionModel = questionModel.copyWith(image: url);
        });
      }

      // Save the quiz to Firestore.
      await questionRef.set(questionModel.toMap());
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
  Future<void> deleteAnswer(
    String courseId,
    String quizId,
    String questionId,
    String answerId,
  ) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      await _firebaseFirestore
          .collection('courses')
          .doc(courseId)
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .doc(questionId)
          .collection('answers')
          .doc(answerId)
          .delete();
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
  Future<void> deleteQuestion(
    String courseId,
    String quizId,
    String questionId,
  ) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      await _firebaseFirestore
          .collection('courses')
          .doc(courseId)
          .collection('quizzes')
          .doc(quizId)
          .collection('questions')
          .doc(questionId)
          .delete();
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
  Future<void> deleteQuiz(
    String courseId,
    String quizId,
  ) async {
    try {
      // Authorize the user using FirebaseAuth.
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      await _firebaseFirestore
          .collection('courses')
          .doc(courseId)
          .collection('quizzes')
          .doc(quizId)
          .delete();
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
  Future<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
    required String courseId,
    required String quizId,
    required String questionId,
    required String answerId,
  }) async {
    try {
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      switch (action) {
        case UpdateAnswerAction.answer:
          await _updateAnswerData(
            courseId,
            quizId,
            questionId,
            answerId,
            {'answer': answerData},
          );

        case UpdateAnswerAction.image:
          final ref = _firebaseStorage
              .ref()
              .child('quiz_pics/$courseId/$quizId/$questionId/$answerId');

          await ref.putFile(answerData as File);

          final url = await ref.getDownloadURL();
          await _updateAnswerData(
            courseId,
            quizId,
            questionId,
            answerId,
            {'image': url},
          );
        case UpdateAnswerAction.correct:
          await _updateAnswerData(
            courseId,
            quizId,
            questionId,
            answerId,
            {'correct': answerData},
          );
        case UpdateAnswerAction.uid:
          await _updateAnswerData(
            courseId,
            quizId,
            questionId,
            answerId,
            {'uid': answerData},
          );
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateQuestion({
    required UpdateQuestionAction action,
    required dynamic questionData,
    required String courseId,
    required String quizId,
    required String questionId,
  }) async {
    try {
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      switch (action) {
        case UpdateQuestionAction.question:
          await _updateQuestionData(
            courseId,
            quizId,
            questionId,
            {'question': questionData},
          );
        case UpdateQuestionAction.description:
          await _updateQuestionData(
            courseId,
            quizId,
            questionId,
            {'description': questionData},
          );
        case UpdateQuestionAction.image:
          final ref = _firebaseStorage
              .ref()
              .child('quiz_pics/$courseId/$quizId/$questionId');

          await ref.putFile(questionData as File);

          final url = await ref.getDownloadURL();
          await _updateQuestionData(
            courseId,
            quizId,
            questionId,
            {'image': url},
          );
        case UpdateQuestionAction.text:
          await _updateQuestionData(
            courseId,
            quizId,
            questionId,
            {'text': questionData},
          );
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  @override
  Future<void> updateQuiz({
    required UpdateQuizAction action,
    required dynamic quizData,
    required String courseId,
    required String quizId,
  }) async {
    try {
      await DataSourceUtils.authorizeUser(_firebaseAuth);

      switch (action) {
        case UpdateQuizAction.title:
          await _updateQuizData(courseId, quizId, {'title': quizData});
        case UpdateQuizAction.description:
          await _updateQuizData(courseId, quizId, {'description': quizData});
      }
    } on FirebaseException catch (e) {
      throw ServerException(
        message: e.message ?? 'Unknown error occurred',
        statusCode: e.code,
      );
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(message: e.toString(), statusCode: '505');
    }
  }

  Future<void> _updateQuizData(
    String courseId,
    String quizId,
    DataMap data,
  ) async {
    await _firebaseFirestore
        .collection('courses')
        .doc(courseId)
        .collection('quizzes')
        .doc(quizId)
        .update(data);
  }

  Future<void> _updateQuestionData(
    String courseId,
    String quizId,
    String questionId,
    DataMap data,
  ) async {
    await _firebaseFirestore
        .collection('courses')
        .doc(courseId)
        .collection('quizzes')
        .doc(quizId)
        .collection('questions')
        .doc(questionId)
        .update(data);
  }

  Future<void> _updateAnswerData(
    String courseId,
    String quizId,
    String questionId,
    String answerId,
    DataMap data,
  ) async {
    await _firebaseFirestore
        .collection('courses')
        .doc(courseId)
        .collection('quizzes')
        .doc(quizId)
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(answerId)
        .update(data);
  }
}
