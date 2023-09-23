import 'package:education_app/src/quiz/domain/entities/question.dart';
import 'package:equatable/equatable.dart';

class Quiz extends Equatable {
  const Quiz({
    required this.id,
    required this.title,
    required this.courseId,
    required this.questions,
    required this.createdAt,
    required this.updatedAt,
    required this.questionSize,
    this.description,
  });

  Quiz.empty()
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

  final String id;
  final String title;
  final String courseId;
  final String? description;
  final List<Question> questions;
  final int questionSize;
  final DateTime createdAt;
  final DateTime updatedAt;

  @override
  List<Object?> get props => [
        id,
        title,
        courseId,
        description,
        questions.length,
        createdAt,
        updatedAt,
      ];
}
