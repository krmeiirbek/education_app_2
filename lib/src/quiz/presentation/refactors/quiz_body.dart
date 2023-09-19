import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/src/quiz/presentation/refactors/quiz_subjects.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuizBody extends StatefulWidget {
  const QuizBody({super.key});

  @override
  State<QuizBody> createState() => _QuizBodyState();
}

class _QuizBodyState extends State<QuizBody> {
  void getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  void initState() {
    super.initState();
    getCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CourseCubit, CourseState>(
      listener: (_, state) {
        if (state is CourseError) {
          CoreUtils.showSnackBar(context, state.message);
        }
      },
      builder: (context, state) {
        if (state is LoadingCourses) {
          return const LoadingView();
        } else if (state is CoursesLoaded && state.courses.isEmpty ||
            state is CourseError) {
          return const NotFoundText(
            'No courses found\nPlease contact admin or if you are admin, '
            'add courses',
          );
        } else if (state is CoursesLoaded) {
          final courses = state.courses
            ..sort(
              (a, b) => b.updatedAt.compareTo(a.updatedAt),
            );
          return Column(
            children: [
              QuizSubjects(courses: courses),
            ],
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
