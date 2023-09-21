import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class DeleteAnswer extends FutureUsecaseWithParams<void, DeleteAnswerParams> {
  DeleteAnswer(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(DeleteAnswerParams params) async =>
      _repo.deleteAnswer(
        params.courseId,
        params.quizId,
        params.questionId,
        params.answerId,
      );
}

class DeleteAnswerParams extends Equatable {
  const DeleteAnswerParams({
    required this.courseId,
    required this.quizId,
    required this.questionId,
    required this.answerId,
  });

  const DeleteAnswerParams.empty()
      : this(
          courseId: '',
          quizId: '',
          questionId: '',
          answerId: '',
        );

  final String courseId;
  final String quizId;
  final String questionId;
  final String answerId;

  @override
  List<dynamic> get props => [
        courseId,
        quizId,
        questionId,
        answerId,
      ];
}
