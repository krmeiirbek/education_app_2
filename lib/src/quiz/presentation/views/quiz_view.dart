import 'package:education_app/src/quiz/presentation/refactors/quiz_body.dart';
import 'package:education_app/src/quiz/presentation/widgets/quiz_app_bar.dart';
import 'package:flutter/material.dart';

class QuizView extends StatelessWidget {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: QuizAppBar(),
      body: QuizBody(),
    );
  }
}
