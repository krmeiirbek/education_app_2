import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';

class GetQuizzes extends UsecaseWithoutParams<List<Quiz>> {
  GetQuizzes(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<List<Quiz>> call() async => _repo.getQuizzes();
}
