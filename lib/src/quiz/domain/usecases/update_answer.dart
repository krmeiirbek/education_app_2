import 'package:education_app/core/enums/update_answer.dart';
import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class UpdateAnswer extends UsecaseWithParams<void, UpdateAnswerParams> {
  UpdateAnswer(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(UpdateAnswerParams params) async =>
      _repo.updateAnswer(action: params.action, answerData: params.answerData);
}

class UpdateAnswerParams extends Equatable {
  const UpdateAnswerParams({required this.action, required this.answerData});

  const UpdateAnswerParams.empty()
      : this(action: UpdateAnswerAction.answer, answerData: '');

  final UpdateAnswerAction action;
  final dynamic answerData;

  @override
  List<dynamic> get props => [action, answerData];
}
