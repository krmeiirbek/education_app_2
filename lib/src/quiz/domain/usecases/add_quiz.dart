import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';

class AddQuiz extends UsecaseWithParams<void, Quiz> {
  AddQuiz(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(Quiz params) async => _repo.addQuiz(params);
}
