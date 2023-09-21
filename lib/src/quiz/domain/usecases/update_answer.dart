import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateAnswer extends FutureUsecaseWithParams<void, UpdateAnswerParams> {
  UpdateAnswer(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(UpdateAnswerParams params) async =>
      _repo.updateAnswer(
        action: params.action,
        answerData: params.answerData,
        courseId: params.courseId,
        quizId: params.quizId,
        questionId: params.questionId,
        answerId: params.answerId,
      );
}

class UpdateAnswerParams extends Equatable {
  const UpdateAnswerParams({
    required this.action,
    required this.answerData,
    required this.courseId,
    required this.quizId,
    required this.questionId,
    required this.answerId,
  });

  const UpdateAnswerParams.empty()
      : this(
          action: UpdateAnswerAction.answer,
          answerData: '',
          courseId: '',
          quizId: '',
          questionId: '',
          answerId: '',
        );

  final UpdateAnswerAction action;
  final dynamic answerData;
  final String courseId;
  final String quizId;
  final String questionId;
  final String answerId;

  @override
  List<dynamic> get props => [action, answerData];
}
