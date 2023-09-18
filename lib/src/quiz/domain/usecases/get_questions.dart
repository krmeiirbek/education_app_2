import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';
import 'package:equatable/equatable.dart';

class GetQuestions
    extends UsecaseWithParams<List<Question>, GetQuestionsParams> {
  GetQuestions(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<List<Question>> call(GetQuestionsParams params) async =>
      _repo.getQuestions(
        params.courseId,
        params.quizId,
      );
}

class GetQuestionsParams extends Equatable {
  const GetQuestionsParams(
    this.courseId,
    this.quizId,
  );

  final String courseId;
  final String quizId;

  @override
  List<Object?> get props => [
        courseId,
        quizId,
      ];
}
