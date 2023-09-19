import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizVariantsScreen extends StatefulWidget {
  const QuizVariantsScreen(
    this.courseId, {
    super.key,
  });

  final String courseId;

  static const routeName = '/quiz-variants';

  @override
  State<QuizVariantsScreen> createState() => _QuizVariantsScreenState();
}

class _QuizVariantsScreenState extends State<QuizVariantsScreen> {
  void getQuizzes(String courseId) {
    context.read<QuizCubit>().getQuizzes(courseId: courseId);
  }

  @override
  void initState() {
    super.initState();
    getQuizzes(widget.courseId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is LoadingQuiz) {
            return const LoadingView();
          } else if (state is QuizLoaded && state.quizzes.isEmpty ||
              state is QuizError) {
            return const NotFoundText(
              'No courses found\nPlease contact admin or if you are admin, '
              'add courses',
            );
          } else if (state is QuizLoaded) {
            final quizzes = state.quizzes;
            return Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (context, index) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 5,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '${index + 1} variant',
                              style: TextStyle(
                                fontSize: 14,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: quizzes.length,
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
        listener: (_, state) {
          if (state is QuizError) {
            CoreUtils.showSnackBar(context, state.message);
          }
        },
      ),
    );
  }
}
