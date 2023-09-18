import 'package:bloc/bloc.dart';
import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/enums/update_question.dart';
import 'package:education_app/core/enums/update_quiz.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:education_app/src/quiz/domain/usecases/add_answer.dart';
import 'package:education_app/src/quiz/domain/usecases/add_question.dart';
import 'package:education_app/src/quiz/domain/usecases/add_quiz.dart';
import 'package:education_app/src/quiz/domain/usecases/delete_answer.dart';
import 'package:education_app/src/quiz/domain/usecases/delete_question.dart';
import 'package:education_app/src/quiz/domain/usecases/delete_quiz.dart';
import 'package:education_app/src/quiz/domain/usecases/get_answers.dart';
import 'package:education_app/src/quiz/domain/usecases/get_questions.dart';
import 'package:education_app/src/quiz/domain/usecases/get_quizzes.dart';
import 'package:education_app/src/quiz/domain/usecases/update_answer.dart';
import 'package:education_app/src/quiz/domain/usecases/update_question.dart';
import 'package:education_app/src/quiz/domain/usecases/update_quiz.dart';
import 'package:equatable/equatable.dart';

part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit({
    required AddQuiz addQuiz,
    required GetQuizzes getQuizzes,
    required UpdateQuiz updateQuiz,
    required DeleteQuiz deleteQuiz,
    required AddQuestion addQuestion,
    required GetQuestions getQuestions,
    required UpdateQuestion updateQuestion,
    required DeleteQuestion deleteQuestion,
    required AddAnswer addAnswer,
    required GetAnswers getAnswers,
    required UpdateAnswer updateAnswer,
    required DeleteAnswer deleteAnswer,
  })  : _addQuiz = addQuiz,
        _getQuizzes = getQuizzes,
        _updateQuiz = updateQuiz,
        _deleteQuiz = deleteQuiz,
        _addQuestion = addQuestion,
        _getQuestions = getQuestions,
        _updateQuestion = updateQuestion,
        _deleteQuestion = deleteQuestion,
        _addAnswer = addAnswer,
        _getAnswers = getAnswers,
        _updateAnswer = updateAnswer,
        _deleteAnswer = deleteAnswer,
        super(QuizInitial());

  final AddQuiz _addQuiz;
  final GetQuizzes _getQuizzes;
  final UpdateQuiz _updateQuiz;
  final DeleteQuiz _deleteQuiz;
  final AddQuestion _addQuestion;
  final GetQuestions _getQuestions;
  final UpdateQuestion _updateQuestion;
  final DeleteQuestion _deleteQuestion;
  final AddAnswer _addAnswer;
  final GetAnswers _getAnswers;
  final UpdateAnswer _updateAnswer;
  final DeleteAnswer _deleteAnswer;

  Future<void> addQuiz(Quiz quiz) async {
    emit(const AddingQuiz());
    final result = await _addQuiz(quiz);
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const QuizAdded()),
    );
  }

  Future<void> getQuizzes({required String courseId}) async {
    emit(const LoadingQuiz());
    final result = await _getQuizzes(GetQuizzesParams(courseId));
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (quizzes) => emit(QuizLoaded(quizzes)),
    );
  }

  Future<void> updateQuiz({
    required UpdateQuizAction action,
    required dynamic quizData,
    required String courseId,
    required String quizId,
  }) async {
    emit(const UpdatingQuiz());
    final result = await _updateQuiz(
      UpdateQuizParams(
        action: action,
        quizData: quizData,
        courseId: courseId,
        quizId: quizId,
      ),
    );
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const QuizUpdated()),
    );
  }

  Future<void> deleteQuiz({
    required String courseId,
    required String quizId,
  }) async {
    emit(const DeletingQuiz());
    final result = await _deleteQuiz(
      DeleteQuizParams(
        courseId: courseId,
        quizId: quizId,
      ),
    );
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const QuizDeleted()),
    );
  }

  Future<void> addQuestion(Question question) async {
    emit(const AddingQuestion());
    final result = await _addQuestion(question);
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const QuestionAdded()),
    );
  }

  Future<void> getQuestions({
    required String courseId,
    required String quizId,
  }) async {
    emit(const LoadingQuestion());
    final result = await _getQuestions(GetQuestionsParams(courseId, quizId));
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (questions) => emit(QuestionLoaded(questions)),
    );
  }

  Future<void> updateQuestion({
    required UpdateQuestionAction action,
    required dynamic questionData,
    required String courseId,
    required String quizId,
    required String questionId,
  }) async {
    emit(const UpdatingQuestion());
    final result = await _updateQuestion(
      UpdateQuestionParams(
        action: action,
        questionData: questionData,
        courseId: courseId,
        quizId: quizId,
        questionId: questionId,
      ),
    );
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const QuestionUpdated()),
    );
  }

  Future<void> deleteQuestion({
    required String courseId,
    required String quizId,
    required String questionId,
  }) async {
    emit(const DeletingQuestion());
    final result = await _deleteQuestion(
      DeleteQuestionParams(
        courseId: courseId,
        quizId: quizId,
        questionId: questionId,
      ),
    );
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const QuestionDeleted()),
    );
  }

  Future<void> addAnswer(Answer answer) async {
    emit(const AddingAnswer());
    final result = await _addAnswer(answer);
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const AnswerAdded()),
    );
  }

  Future<void> getAnswers({
    required String courseId,
    required String quizId,
    required String questionId,
  }) async {
    emit(const LoadingAnswer());
    final result = await _getAnswers(
      GetAnswersParams(
        courseId,
        quizId,
        questionId,
      ),
    );
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (answers) => emit(AnswerLoaded(answers)),
    );
  }

  Future<void> updateAnswer({
    required UpdateAnswerAction action,
    required dynamic answerData,
    required String courseId,
    required String quizId,
    required String questionId,
    required String answerId,
  }) async {
    emit(const UpdatingAnswer());
    final result = await _updateAnswer(
      UpdateAnswerParams(
        action: action,
        answerData: answerData,
        courseId: courseId,
        quizId: quizId,
        questionId: questionId,
        answerId: answerId,
      ),
    );
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const AnswerUpdated()),
    );
  }

  Future<void> deleteAnswer({
    required String courseId,
    required String quizId,
    required String questionId,
    required String answerId,
  }) async {
    emit(const DeletingAnswer());
    final result = await _deleteAnswer(
      DeleteAnswerParams(
        courseId: courseId,
        quizId: quizId,
        questionId: questionId,
        answerId: answerId,
      ),
    );
    result.fold(
      (failure) => emit(QuizError(failure.errorMessage)),
      (_) => emit(const AnswerDeleted()),
    );
  }
}
