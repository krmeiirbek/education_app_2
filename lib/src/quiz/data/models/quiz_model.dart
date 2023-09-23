import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_app/core/utils/typedefs.dart';
import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';

class QuizModel extends Quiz {
  const QuizModel({
    required super.id,
    required super.title,
    required super.courseId,
    required super.questions,
    required super.createdAt,
    required super.updatedAt,
    required super.questionSize,
    super.description,
  });

  QuizModel.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          courseId: '_empty.courseId',
          description: '_empty.description',
          questions: [],
          questionSize: 0,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );

  QuizModel.fromMap(DataMap map)
      : super(
          id: map['id'] as String,
          title: map['title'] as String,
          courseId: map['courseId'] as String,
          questionSize: map['questionSize'] as int,
          // questions: (map['questions'] as List<DataMap>)
          //     .map(QuestionModel.fromMap)
          //     .toList(),
          questions: [],
          createdAt: (map['createdAt'] as Timestamp).toDate(),
          updatedAt: (map['updatedAt'] as Timestamp).toDate(),
          description: map['description'] as String?,
        );

  QuizModel copyWith({
    String? id,
    String? title,
    String? courseId,
    List<Question>? questions,
    int? questionSize,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
  }) =>
      QuizModel(
        id: id ?? this.id,
        title: title ?? this.title,
        courseId: courseId ?? this.courseId,
        questions: questions ?? this.questions,
        questionSize: questionSize ?? this.questionSize,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        description: description ?? this.description,
      );

  DataMap toMap() => {
        'id': id,
        'title': title,
        'courseId': courseId,
        // 'questions': (questions as List<QuestionModel>)
        //     .map((answer) => answer.toMap())
        //     .toList(),
    'questionSize':questionSize,
        'createdAt': FieldValue.serverTimestamp(),
        'updatedAt': FieldValue.serverTimestamp(),
        'description': description,
      };
}
