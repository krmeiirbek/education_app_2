import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/data/models/course_model.dart';
import 'package:education_app/src/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:education_app/src/quiz/presentation/views/test_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizVariantsScreen extends StatefulWidget {
  const QuizVariantsScreen(
    this.course, {
    super.key,
  });

  final CourseModel course;

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
    getQuizzes(widget.course.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<QuizCubit, QuizState>(
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
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.course.title),
              actions: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image:
                          NetworkImage(widget.course.image ?? kDefaultAvatar),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 20),
              ],
            ),
            body: Column(
              children: [
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                    ),
                    itemCount: quizzes.length,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () => Navigator.of(context).pushNamed(
                          TestScreen.routeName,
                          arguments: quizzes[index],
                        ),
                        child: Card(
                          color: Theme.of(context).colorScheme.onSecondary,
                          child: Center(
                            child: Text(
                              '${index + 1}-Нұсқа',
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.secondary,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
