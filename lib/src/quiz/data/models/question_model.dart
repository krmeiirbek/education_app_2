import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/data/models/answer_model.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.question,
    required super.quizId,
    required super.answers,
    super.image,
    super.text,
    super.description,
  });

  QuestionModel.empty()
      : this(
          id: '_empty.id',
          question: '_empty.question',
          quizId: '_empty.quizId',
          image: '_empty.image',
          text: '_empty.text',
          answers: [],
          description: '_empty.description',
        );

  QuestionModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          question: map['question'] as String,
          quizId: map['quizId'] as String,
          answers: (map['answers'] as List<DataMap>)
              .map(AnswerModel.fromMap)
              .toList(),
          image: map['image'] as String?,
          text: map['text'] as String?,
          description: map['description'] as String?,
        );

  QuestionModel copyWith({
    String? id,
    String? question,
    String? quizId,
    String? image,
    String? text,
    String? description,
    List<Answer>? answers,
  }) =>
      QuestionModel(
        id: id ?? this.id,
        question: question ?? this.question,
        quizId: quizId ?? this.quizId,
        answers: answers ?? this.answers,
        image: image ?? this.image,
        text: text ?? this.text,
        description: description ?? this.description,
      );

  DataMap toMap() => {
        'id': id,
        'question': question,
        'quizId': quizId,
        'image': image,
        'text': text,
        'description': description,
        'answers': (answers as List<AnswerModel>)
            .map((answer) => answer.toMap())
            .toList(),
      };
}
