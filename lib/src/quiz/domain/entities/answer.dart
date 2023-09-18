import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  const Answer({
    required this.uid,
    required this.answer,
    required this.courseId,
    required this.questionId,
    required this.quizId,
    required this.correct,
    this.image,
    this.imageIsFile = false,
  });

  const Answer.empty()
      : this(
          uid: '_empty.uid',
          answer: '_empty.answer',
          questionId: '_empty.questionId',
          quizId: '_empty.quizId',
          courseId: '_empty.courseId',
          image: '_empty.image',
          correct: false,
        );

  final String uid;
  final String answer;
  final String questionId;
  final String quizId;
  final String courseId;
  final String? image;
  final bool imageIsFile;
  final bool correct;

  @override
  List<Object?> get props => [
        uid,
        answer,
        questionId,
        quizId,
        courseId,
        image,
        imageIsFile,
        correct,
      ];
}
