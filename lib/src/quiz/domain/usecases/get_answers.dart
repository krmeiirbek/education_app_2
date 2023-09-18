import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class GetAnswers extends UsecaseWithParams<List<Answer>, GetAnswersParams> {
  GetAnswers(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<List<Answer>> call(GetAnswersParams params) async =>
      _repo.getAnswers(
        params.courseId,
        params.quizId,
        params.questionId,
      );
}

class GetAnswersParams extends Equatable {
  const GetAnswersParams(
    this.courseId,
    this.quizId,
    this.questionId,
  );

  final String courseId;
  final String quizId;
  final String questionId;

  @override
  List<Object?> get props => [
        courseId,
        quizId,
        questionId,
      ];
}
