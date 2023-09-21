import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class DeleteQuiz extends FutureUsecaseWithParams<void, DeleteQuizParams> {
  DeleteQuiz(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(DeleteQuizParams params) async => _repo.deleteQuiz(
        params.courseId,
        params.quizId,
      );
}

class DeleteQuizParams extends Equatable {
  const DeleteQuizParams({
    required this.courseId,
    required this.quizId,
  });

  const DeleteQuizParams.empty()
      : this(
          courseId: '',
          quizId: '',
        );

  final String courseId;
  final String quizId;

  @override
  List<dynamic> get props => [
        courseId,
        quizId,
      ];
}
