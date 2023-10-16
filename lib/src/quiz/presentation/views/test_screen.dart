import 'dart:math';

import 'package:education_app/core/common/values/custom_text_styles.dart';
import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/quiz/data/models/quiz_model.dart';
import 'package:education_app/src/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:education_app/src/quiz/presentation/views/test_result_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatefulWidget {
  const TestScreen(this.quiz, {super.key});

  final QuizModel quiz;

  static const routeName = '/test-screen';

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  int questionId = 0;
  late List<List<String>> questionsAnswers;

  void getQuestions(String quizId, String courseId) {
    context.read<QuizCubit>().getQuestions(quizId: quizId, courseId: courseId);
  }

  void changeQuestion(int index) {
    setState(() {
      questionId = index;
    });
  }

  @override
  void initState() {
    super.initState();
    questionsAnswers = List.generate(
      widget.quiz.questionSize,
      (_) => <String>[],
    );
    getQuestions(widget.quiz.id, widget.quiz.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
      builder: (context, state) {
        if (state is LoadingQuestion) {
          return const LoadingView();
        } else if (state is QuizLoaded && state.quizzes.isEmpty ||
            state is QuizError) {
          return const NotFoundText(
            'No questions found\nPlease contact admin or if you are admin, '
            'add questions',
          );
        } else if (state is QuestionLoaded) {
          final questions = state.questions;
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Text(widget.quiz.title),
              actions: [
                TextButton(
                  onPressed: () {
                    final a = Random().nextInt(5);
                    final b = Random().nextInt(5);
                    var result = 0;
                    showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(
                            'Тестті аяқтау үшін амалды орыңдаңыз?',
                          ),
                          content: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text('${a + 1} + ${b + 1} = '),
                              SizedBox(
                                width: 20,
                                child: TextField(
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    result = int.tryParse(value) ?? -1;
                                  },
                                ),
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(result == a + b + 2);
                              },
                              child: const Text(
                                'Аяқтау',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        );
                      },
                    ).then((value) {
                      if (value == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Incorrect Answer!'),
                          ),
                        );
                      } else if (value == true) {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushNamed(
                          TestResultScreen.routeName,
                          arguments: {
                            'quiz': widget.quiz.copyWith(questions: questions),
                            'userAnswers': questionsAnswers,
                          },
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Incorrect Answer!'),
                          ),
                        );
                      }
                    });
                  },
                  child: Text(
                    'Тестті аяқтау',
                    style: labelMedium.copyWith(
                      color: Theme.of(context).colorScheme.error,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            body: Column(
              children: [
                const SizedBox(height: 20),
                SizedBox(
                  height: 30,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        changeQuestion(index);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: questionId == index
                              ? context.theme.colorScheme.primary
                              : questionsAnswers[index].isNotEmpty
                                  ? context.theme.colorScheme.surface
                                  : Colors.transparent,
                          border: questionId == index
                              ? null
                              : questionsAnswers[index].isNotEmpty
                                  ? Border.all(
                                      color: context.theme.colorScheme.surface,
                                    )
                                  : Border.all(
                                      color:
                                          context.theme.unselectedWidgetColor,
                                    ),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: questionId == index
                                ? const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  )
                                : questionsAnswers[index].isNotEmpty
                                    ? TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .unselectedWidgetColor,
                                      )
                                    : TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                        color: Theme.of(context)
                                            .unselectedWidgetColor,
                                      ),
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 10),
                    itemCount: widget.quiz.questionSize,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${questionId + 1}. ${questions[questionId].question}',
                          style: bodyMedium.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.start,
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: questions[questionId].answersSize,
                            itemBuilder: (context, index) => InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                setState(() {
                                  if (questionsAnswers[questionId].contains(
                                    questions[questionId].answers[index].uid,
                                  )) {
                                    questionsAnswers[questionId].remove(
                                      questions[questionId].answers[index].uid,
                                    );
                                  } else {
                                    questionsAnswers[questionId].add(
                                      questions[questionId].answers[index].uid,
                                    );
                                  }
                                });
                              },
                              child: Container(
                                width: double.infinity,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 8,
                                  horizontal: 10,
                                ),
                                margin: const EdgeInsets.only(top: 10),
                                decoration: BoxDecoration(
                                  color: questionsAnswers[questionId].contains(
                                    questions[questionId].answers[index].uid,
                                  )
                                      ? Theme.of(context).colorScheme.primary
                                      : null,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                ),
                                child: Text(
                                  '${questions[questionId].answers[index].uid}. ${questions[questionId].answers[index].answer}',
                                  style: titleSmall.copyWith(
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox.shrink();
      },
      listener: (_, state) {
        if (state is QuizError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
    );
  }
}
