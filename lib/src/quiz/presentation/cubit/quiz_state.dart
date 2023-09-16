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

class QuizError extends QuizState {
  const QuizError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

// Add similar state classes for questions and answers.
