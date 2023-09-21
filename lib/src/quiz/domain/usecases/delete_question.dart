import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class DeleteQuestion extends FutureUsecaseWithParams<void, DeleteQuestionParams> {
  DeleteQuestion(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(DeleteQuestionParams params) async =>
      _repo.deleteQuestion(
        params.courseId,
        params.quizId,
        params.questionId,
      );
}

class DeleteQuestionParams extends Equatable {
  const DeleteQuestionParams({
    required this.courseId,
    required this.quizId,
    required this.questionId,
  });

  const DeleteQuestionParams.empty()
      : this(
          courseId: '',
          quizId: '',
          questionId: '',
        );

  final String courseId;
  final String quizId;
  final String questionId;

  @override
  List<dynamic> get props => [
        courseId,
        quizId,
        questionId,
      ];
}
