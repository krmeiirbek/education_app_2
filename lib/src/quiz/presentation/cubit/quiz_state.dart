part of 'quiz_cubit.dart';

abstract class QuizState extends Equatable{
  const QuizState();

  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class AddingQuiz extends QuizState {
  const AddingQuiz();
}

class QuizAdded extends QuizState {
  const QuizAdded();
}

class LoadingQuiz extends QuizState {
  const LoadingQuiz();
}

class QuizLoaded extends QuizState {
  const QuizLoaded(this.quizzes);

  final List<Quiz> quizzes;

  @override
  List<Object> get props => [quizzes];
}

class UpdatingQuiz extends QuizState {
  const UpdatingQuiz();
}

class QuizUpdated extends QuizState {
  const QuizUpdated();
}

class DeletingQuiz extends QuizState {
  const DeletingQuiz();
}

class QuizDeleted extends QuizState {
  const QuizDeleted();
}

class AddingQuestion extends QuizState {
  const AddingQuestion();
}

class QuestionAdded extends QuizState {
  const QuestionAdded();
}

class LoadingQuestion extends QuizState {
  const LoadingQuestion();
}

class QuestionLoaded extends QuizState {
  const QuestionLoaded(this.questions);

  final List<Question> questions;

  @override
  List<Object> get props => [questions];
}

class UpdatingQuestion extends QuizState {
  const UpdatingQuestion();
}

class QuestionUpdated extends QuizState {
  const QuestionUpdated();
}

class DeletingQuestion extends QuizState {
  const DeletingQuestion();
}

class QuestionDeleted extends QuizState {
  const QuestionDeleted();
}

class AddingAnswer extends QuizState {
  const AddingAnswer();
}

class AnswerAdded extends QuizState {
  const AnswerAdded();
}

class LoadingAnswer extends QuizState {
  const LoadingAnswer();
}

class AnswerLoaded extends QuizState {
  const AnswerLoaded(this.answers);

  final List<Answer> answers;

  @override
  List<Object> get props => [answers];
}

class UpdatingAnswer extends QuizState {
  const UpdatingAnswer();
}

class AnswerUpdated extends QuizState {
  const AnswerUpdated();
}

class DeletingAnswer extends QuizState {
  const DeletingAnswer();
}

class AnswerDeleted extends QuizState {
  const AnswerDeleted();
}

class QuizError extends QuizState {
  const QuizError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}
