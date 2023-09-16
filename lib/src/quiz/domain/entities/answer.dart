import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  const Answer({
    required this.uid,
    required this.answer,
    required this.questionId,
    required this.correct,
    this.image,
  });

  const Answer.empty()
      : this(
          uid: '_empty.uid',
          answer: '_empty.answer',
          questionId: '_empty.questionId',
          image: '_empty.image',
          correct: false,
        );

  final String uid;
  final String answer;
  final String questionId;
  final String? image;
  final bool correct;

  @override
  List<Object?> get props => [uid, answer, questionId, image, correct];
}
