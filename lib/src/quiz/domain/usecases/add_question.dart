import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';

class AddQuestion extends FutureUsecaseWithParams<void, Question> {
  AddQuestion(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(Question params) async => _repo.addQuestion(params);
}
