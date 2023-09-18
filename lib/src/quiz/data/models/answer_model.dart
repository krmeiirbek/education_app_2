import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';

class AnswerModel extends Answer {
  const AnswerModel({
    required super.uid,
    required super.answer,
    required super.questionId,
    required super.courseId,
    required super.quizId,
    required super.correct,
    super.image,
    super.imageIsFile,
  });

  const AnswerModel.empty()
      : this(
          uid: '_empty.uid',
          answer: '_empty.answer',
          questionId: '_empty.questionId',
          quizId: '_empty.quizId',
          courseId: '_empty.courseId',
          image: '_empty.image',
          correct: false,
        );

  AnswerModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          answer: map['answer'] as String,
          quizId: map['quizId'] as String,
          courseId: map['courseId'] as String,
          questionId: map['questionId'] as String,
          image: map['image'] as String?,
          correct: map['correct'] as bool,
        );

  AnswerModel copyWith({
    String? uid,
    String? answer,
    String? quizId,
    String? courseId,
    String? questionId,
    String? image,
    bool? imageIsFile,
    bool? correct,
  }) =>
      AnswerModel(
        uid: uid ?? this.uid,
        answer: answer ?? this.answer,
        quizId: quizId ?? this.quizId,
        courseId: courseId ?? this.courseId,
        questionId: questionId ?? this.questionId,
        correct: correct ?? this.correct,
        image: image ?? this.image,
        imageIsFile: imageIsFile ?? this.imageIsFile,
      );

  DataMap toMap() => {
        'uid': uid,
        'answer': answer,
        'quizId': quizId,
        'courseId': courseId,
        'questionId': questionId,
        'image': image,
        'correct': correct,
      };
}
