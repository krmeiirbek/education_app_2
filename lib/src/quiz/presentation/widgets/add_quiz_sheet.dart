import 'package:education_app/core/common/values/custom_text_styles.dart';
import 'package:education_app/core/common/views/loading_view.dart';
import 'package:education_app/core/common/widgets/not_found_text.dart';
import 'package:education_app/core/common/widgets/titled_input_field.dart';
import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/core/utils/core_utils.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/course/presentation/cubit/course_cubit.dart';
import 'package:education_app/src/quiz/data/models/quiz_model.dart';
import 'package:education_app/src/quiz/presentation/cubit/quiz_cubit.dart';
import 'package:education_app/src/quiz/presentation/widgets/add_questions_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddQuizSheet extends StatefulWidget {
  const AddQuizSheet({super.key});

  @override
  State<AddQuizSheet> createState() => _AddQuizSheetState();
}

class _AddQuizSheetState extends State<AddQuizSheet> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  List<Course> courses = [];
  Course? subject;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    getCourses();
    super.initState();
  }

  void getCourses() {
    context.read<CourseCubit>().getCourses();
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QuizCubit, QuizState>(
      listener: (_, state) {
        if (state is QuizError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is AddingQuiz) {
          CoreUtils.showLoadingDialog(context);
        } else if (state is QuizAdded) {
          CoreUtils.showSnackBar(context, 'Quiz added successfully');
        }
      },
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: context.theme.colorScheme.secondary,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Form(
            key: formKey,
            child: ListView(
              shrinkWrap: true,
              children: [
                const Text(
                  'Add Quiz',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 15),
                BlocConsumer<CourseCubit, CourseState>(
                  listener: (_, state) {
                    if (state is CourseError) {
                      CoreUtils.showSnackBar(context, state.message);
                    }
                  },
                  builder: (context, state) {
                    if (state is LoadingCourses) {
                      return const LoadingView();
                    } else if (state is CoursesLoaded &&
                            state.courses.isEmpty ||
                        state is CourseError) {
                      return const NotFoundText(
                        'No courses found\nPlease contact '
                        'admin or if you are admin, '
                        'add courses',
                      );
                    } else if (state is CoursesLoaded) {
                      courses = state.courses;
                      return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: context.theme.colorScheme.background,
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              offset: const Offset(0.5, 1.5),
                              blurRadius: 2,
                              spreadRadius: 0.5,
                            ),
                          ],
                        ),
                        child: DropdownButton<Course>(
                          value: subject,
                          hint: const Text('---'),
                          underline: const SizedBox(),
                          borderRadius: BorderRadius.circular(10),
                          icon: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Өзгерту',
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Icon(
                                Icons.arrow_forward_ios_rounded,
                                color: context.theme.colorScheme.primary,
                                size: 13,
                              ),
                            ],
                          ),
                          items: courses.map(
                            (subject) {
                              return DropdownMenuItem(
                                value: subject,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 25,
                                      height: 25,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            subject.image ?? kDefaultAvatar,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      subject.title,
                                      style: labelLarge.copyWith(
                                        color: context
                                            .theme.colorScheme.onSecondary,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ).toList(),
                          onChanged: (newItem) {
                            setState(() {
                              subject = newItem;
                            });
                          },
                          isExpanded: true,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                const SizedBox(height: 20),
                TitledInputField(
                  controller: titleController,
                  title: 'Quiz Title',
                ),
                const SizedBox(height: 20),
                TitledInputField(
                  controller: descriptionController,
                  title: 'Description',
                  required: false,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              subject != null) {
                            final now = DateTime.now();
                            final quiz = QuizModel.empty().copyWith(
                              courseId: subject!.id,
                              questionSize: 10,
                              title: titleController.text.trim(),
                              description: descriptionController.text.trim(),
                              createdAt: now,
                              updatedAt: now,
                            );
                            Navigator.pop(context);
                            Navigator.of(context).pushNamed(
                              AddQuestionsSheet.routeName,
                              arguments: quiz,
                            );
                          }
                        },
                        child: const Text('Add Questions'),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancel'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
