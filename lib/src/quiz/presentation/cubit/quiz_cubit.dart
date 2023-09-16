import 'package:bloc/bloc.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:equatable/equatable.dart';


part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  //final QuizRepository _repository = QuizRepository();

  QuizCubit() : super(QuizInitial());

  // Add your Cubit methods to create, update, and delete variants, questions, and answers.
  // You can call these methods and emit the respective states.
  // Example:

  // Future<void> createVariant(Map<String, dynamic> variantData) async {
  //   try {
  //     emit(QuizAddingVariant());
  //     final variantId = await _repository.createVariant(variantData);
  //     emit(QuizAddedVariant(variantId));
  //   } catch (e) {
  //     emit(QuizError(e.toString()));
  //   }
  // }

// Similar methods for updating and deleting variants, questions, and answers.
}
