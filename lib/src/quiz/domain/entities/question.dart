import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:equatable/equatable.dart';

class Question extends Equatable {
  const Question({
    required this.id,
    required this.question,
    required this.quizId,
    required this.answers,
    this.image,
    this.text,
    this.description,
  });

  Question.empty()
      : this(
          id: '_empty.id',
          question: '_empty.question',
          quizId: '_empty.quizId',
          image: '_empty.image',
          text: '_empty.text',
          answers: [],
          description: '_empty.description',
        );

  final String id;
  final String question;
  final String quizId;
  final String? image;
  final String? text;
  final List<Answer> answers;
  final String? description;

  @override
  List<Object?> get props => [
        id,
        question,
        quizId,
        image,
        text,
        answers.length,
        description,
      ];
}
