import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/core/res/media_res.dart';
import 'package:education_app/src/quiz/data/models/quiz_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TestResultScreen extends StatefulWidget {
  const TestResultScreen({
    required this.userAnswers,
    required this.quiz,
    super.key,
  });

  final QuizModel quiz;
  final List<List<String>> userAnswers;

  static const routeName = '/test-result-screen';

  @override
  State<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  late int result;
  late int maybeResult;

  @override
  void initState() {
    super.initState();
    getResult();
  }

  void getResult() {
    result = 0;
    maybeResult = 0;
    for (var i = 0; i < widget.quiz.questions.length; i++) {
      var correctAnswerSize = 0;
      final correctAnswers = <String>[];
      var userAnswers = 0;
      for (final answer in widget.quiz.questions[i].answers) {
        if (answer.correct) {
          correctAnswerSize++;
          correctAnswers.add(answer.uid);
        }
      }
      for (final answer in widget.userAnswers[i]) {
        if (correctAnswers.contains(answer)) {
          userAnswers++;
        } else {
          userAnswers--;
        }
      }
      if (correctAnswerSize == 0) {
        maybeResult++;
        continue;
      } else if (correctAnswerSize > 1) {
        maybeResult += 2;
        if (userAnswers / correctAnswerSize == 1) {
          result += 2;
        } else if (userAnswers / correctAnswerSize > 0.5) {
          result++;
        }
      } else if (correctAnswerSize == 1) {
        maybeResult++;
        if (userAnswers == 1) {
          result++;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const failString =
        'Сізде дұрыс жауаптардың саны 50% - дан төмен. Сіз қайтадан тест тапсыруыңыз керек.';
    const successString =
        'Сізде дұрыс жауаптардың саны 50% - дан жоғары. Керемет!!!';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Тестті аяқтау'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              child: Stack(
                children: [
                  Lottie.asset(MediaRes.cheers,repeat: false),
                  Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '$result / $maybeResult',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        result / maybeResult >= 0.5 ? successString : failString,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
                ]
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: context.theme.primaryColor,
              ),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: const Center(
                child: Text(
                  'Нәтижелер',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Center(
                child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Text(
                    'Нұсқаларға өту',
                    style: TextStyle(
                      color: context.theme.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
