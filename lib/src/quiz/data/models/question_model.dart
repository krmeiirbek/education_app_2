import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/answer.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';

class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.question,
    required super.courseId,
    required super.quizId,
    required super.answers,
    required super.answersSize,
    super.image,
    super.text,
    super.description,
    super.imageIsFile,
  });

  QuestionModel.empty()
      : this(
          id: '_empty.id',
          question: '_empty.question',
          courseId: '_empty.courseId',
          quizId: '_empty.quizId',
          image: '_empty.image',
          text: '_empty.text',
          answers: [],
          answersSize: 0,
          description: '_empty.description',
        );

  QuestionModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          question: map['question'] as String,
          courseId: map['courseId'] as String,
          quizId: map['quizId'] as String,
          answers: [],
          answersSize: map['answersSize'] as int,
          // answers: (map['answers'] as List<DataMap>)
          //     .map(AnswerModel.fromMap)
          //     .toList(),
          image: map['image'] as String?,
          text: map['text'] as String?,
          description: map['description'] as String?,
        );

  QuestionModel copyWith({
    String? id,
    String? question,
    String? courseId,
    String? quizId,
    String? image,
    bool? imageIsFile,
    String? text,
    int? answersSize,
    String? description,
    List<Answer>? answers,
  }) =>
      QuestionModel(
        id: id ?? this.id,
        question: question ?? this.question,
        courseId: courseId ?? this.courseId,
        quizId: quizId ?? this.quizId,
        answers: answers ?? this.answers,
        answersSize: answersSize ?? this.answersSize,
        image: image ?? this.image,
        imageIsFile: imageIsFile ?? this.imageIsFile,
        text: text ?? this.text,
        description: description ?? this.description,
      );

  DataMap toMap() => {
        'id': id,
        'question': question,
        'courseId': courseId,
        'quizId': quizId,
        'image': image,
        'text': text,
        'description': description,
        'answersSize': answersSize,
        // 'answers': (answers as List<AnswerModel>)
        //     .map((answer) => answer.toMap())
        //     .toList(),
      };
}
