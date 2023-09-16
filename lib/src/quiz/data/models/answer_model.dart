import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';

class AnswerModel extends Answer {
  const AnswerModel({
    required super.uid,
    required super.answer,
    required super.questionId,
    required super.correct,
    super.image,
  });

  const AnswerModel.empty()
      : this(
          uid: '_empty.uid',
          answer: '_empty.answer',
          questionId: '_empty.questionId',
          image: '_empty.image',
          correct: false,
        );

  AnswerModel.fromMap(DataMap map)
      : super(
          uid: map['uid'] as String,
          answer: map['answer'] as String,
          questionId: map['questionId'] as String,
          image: map['image'] as String?,
          correct: map['correct'] as bool,
        );

  AnswerModel copyWith({
    String? uid,
    String? answer,
    String? questionId,
    String? image,
    bool? correct,
  }) =>
      AnswerModel(
        uid: uid ?? this.uid,
        answer: answer ?? this.answer,
        questionId: questionId ?? this.questionId,
        correct: correct ?? this.correct,
        image: image ?? this.image,
      );

  DataMap toMap() => {
        'uid': uid,
        'answer': answer,
        'questionId': questionId,
        'image': image,
        'correct': correct,
      };
}
