import 'package:education_app/core/enums/update_quiz.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateQuiz extends FutureUsecaseWithParams<void, UpdateQuizParams> {
  UpdateQuiz(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(UpdateQuizParams params) async => _repo.updateQuiz(
        action: params.action,
        quizData: params.quizData,
        courseId: params.courseId,
        quizId: params.quizId,
      );
}

class UpdateQuizParams extends Equatable {
  const UpdateQuizParams({
    required this.action,
    required this.quizData,
    required this.courseId,
    required this.quizId,
  });

  const UpdateQuizParams.empty()
      : this(
          action: UpdateQuizAction.title,
          quizData: '',
          courseId: '',
          quizId: '',
        );

  final UpdateQuizAction action;
  final dynamic quizData;
  final String courseId;
  final String quizId;

  @override
  List<dynamic> get props => [action, quizData];
}
