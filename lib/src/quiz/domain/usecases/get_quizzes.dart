import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class GetQuizzes extends FutureUsecaseWithParams<List<Quiz>, GetQuizzesParams> {
  GetQuizzes(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<List<Quiz>> call(GetQuizzesParams params) async =>
      _repo.getQuizzes(params.courseId);
}

class GetQuizzesParams extends Equatable {
  const GetQuizzesParams(this.courseId);

  final String courseId;

  @override
  List<Object?> get props => [courseId];
}
