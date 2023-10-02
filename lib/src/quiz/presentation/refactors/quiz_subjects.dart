import 'package:education_app/core/utils/constants.dart';
import 'package:education_app/src/course/domain/entities/course.dart';
import 'package:education_app/src/quiz/presentation/views/quiz_variants_screen.dart';
import 'package:flutter/material.dart';

class QuizSubjects extends StatelessWidget {
  const QuizSubjects({required this.courses, super.key});

  final List<Course> courses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: ListView.separated(
          itemBuilder: (context, index) => GestureDetector(
            onTap: () => Navigator.of(context).pushNamed(
              QuizVariantsScreen.routeName,
              arguments: courses[index],
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: NetworkImage(
                          courses[index].image ?? kDefaultAvatar,
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      courses[index].title,
                      style: TextStyle(
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.onSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(),
          itemCount: courses.length,
        ),
      ),
    );
  }
}
