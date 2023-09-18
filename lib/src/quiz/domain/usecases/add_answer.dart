import 'package:education_app/core/usecases/usecases.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/repos/quiz_repo.dart';

class AddAnswer extends UsecaseWithParams<void, Answer> {
  AddAnswer(this._repo);

  final QuizRepo _repo;

  @override
  ResultFuture<void> call(Answer params) async => _repo.addAnswer(params);
}
