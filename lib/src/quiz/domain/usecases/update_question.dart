import 'package:education_app/core/enums/update_question.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateQuestion extends FutureUsecaseWithParams<void, UpdateQuestionParams> {
  UpdateQuestion(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(UpdateQuestionParams params) async =>
      _repo.updateQuestion(
        action: params.action,
        questionData: params.questionData,
        courseId: params.courseId,
        quizId: params.quizId,
        questionId: params.questionId,
      );
}

class UpdateQuestionParams extends Equatable {
  const UpdateQuestionParams({
    required this.action,
    required this.questionData,
    required this.courseId,
    required this.quizId,
    required this.questionId,
  });

  const UpdateQuestionParams.empty()
      : this(
          action: UpdateQuestionAction.question,
          questionData: '',
          courseId: '',
          quizId: '',
          questionId: '',
        );

  final UpdateQuestionAction action;
  final dynamic questionData;
  final String courseId;
  final String quizId;
  final String questionId;

  @override
  List<dynamic> get props => [action, questionData];
}
