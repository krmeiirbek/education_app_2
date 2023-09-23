import 'package:education_app/core/extensions/context_extension.dart';
import 'package:education_app/src/quiz/data/models/answer_model.dart';
import 'package:education_app/src/quiz/data/models/question_model.dart';
import 'package:education_app/src/quiz/domain/entities/quiz.dart';
import 'package:flutter/material.dart';

class AddQuestionsSheet extends StatefulWidget {
  const AddQuestionsSheet({
    required this.quiz,
    super.key,
  });

  static const routeName = 'add-questions-sheet';
  final Quiz quiz;

  @override
  State<AddQuestionsSheet> createState() => _AddQuestionsSheetState();
}

class _AddQuestionsSheetState extends State<AddQuestionsSheet> {
  int questionId = 0;
  int answerSize = 1;
  final questionController = TextEditingController();
  final List<TextEditingController> answerControllers = List.generate(
    6, // Set the maximum number of answers you want to support
    (_) => TextEditingController(),
  );
  List<int> correctAnswers = []; // Initialize an empty list

  late List<bool> questionIsSET;
  late List<QuestionModel> questions;

  String intToAlphabetic(int number) {
    final offset = 'A'.codeUnitAt(0); // ASCII code for 'A'
    final letterIndex = number % 26; // 26 letters in the alphabet

    final letter = String.fromCharCode(offset + letterIndex);
    return letter;
  }

  void updateCorrectAnswers(int index, {required bool isCorrect}) {
    if (isCorrect) {
      if (!correctAnswers.contains(index)) {
        correctAnswers.add(index);
      }
    } else {
      correctAnswers.remove(index);
    }
    setState(() {});
  }

  void changeQuestion(int index) {
    if (questionController.text.trim() != '' &&
        answerControllers[0].text.trim() != '') {
      questions[questionId] = questions[questionId].copyWith(
        id: questionId.toString(),
        // Set the question ID as a numeric value
        quizId: widget.quiz.id,
        courseId: widget.quiz.courseId,
        question: questionController.text.trim(),
        answersSize: answerSize,
        answers: List.generate(answerSize, (index) {
          final alphabeticId =
              intToAlphabetic(index); // Generate an alphabetic ID
          final isCorrect =
              correctAnswers.contains(index); // Check if the answer is correct
          return const AnswerModel.empty().copyWith(
            uid: alphabeticId,
            // Set the uid to the alphabetic ID
            answer: answerControllers[index].text,
            questionId: index.toString(),
            // Set the question ID as a numeric value
            quizId: widget.quiz.id,
            courseId: widget.quiz.courseId,
            correct: isCorrect, // Set the correct value based on your logic
          );
        }),
      );
      questionIsSET[questionId] = true;
    }

    if (questionIsSET[index]) {
      questionController.text = questions[index].question;

      answerSize = questions[index].answersSize;
      for (var i = 0; i < answerSize; i++) {
        answerControllers[i].text = questions[index].answers[i].answer;
        updateCorrectAnswers(i, isCorrect: questions[index].answers[i].correct);
      }
    } else {
      questionController.text = '';
      for (var i = 0; i < answerSize; i++) {
        answerControllers[i].text = '';
      }
      answerSize = 1;
      correctAnswers.clear();
    }

    setState(() {
      questionId = index;
    });
  }

  @override
  void initState() {
    questionIsSET = List.filled(widget.quiz.questionSize, false);
    questions = List.filled(widget.quiz.questionSize, QuestionModel.empty());
    super.initState();
  }

  @override
  void dispose() {
    questionController.dispose();
    for (final controller in answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                          : questionIsSET[index]
                              ? context.theme.colorScheme.surface
                              : Colors.transparent,
                      border: questionId == index
                          ? null
                          : questionIsSET[index]
                              ? Border.all(
                                  color: context.theme.colorScheme.surface,
                                )
                              : Border.all(
                                  color: context.theme.unselectedWidgetColor,
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
                            : questionIsSET[index]
                                ? TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).unselectedWidgetColor,
                                  )
                                : TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).unselectedWidgetColor,
                                  ),
                      ),
                    ),
                  ),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 10),
                itemCount: widget.quiz.questionSize,
                scrollDirection: Axis.horizontal,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text('Surakty engiziniz'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: TextField(
                controller: questionController,
                maxLines: 3,
                // Set to null to allow multiple lines
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top,
                // You can use other values like TextAlignVertical.center
                decoration: const InputDecoration(
                  hintText: 'Enter your question here',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            for (int i = 0; i < answerSize; i++)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        updateCorrectAnswers(
                          i,
                          isCorrect: !correctAnswers.contains(i),
                        );
                      },
                      child: Center(
                        child: Container(
                          height: 10,
                          width: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: correctAnswers.contains(i)
                                ? context.theme.colorScheme.surface
                                : context.theme.colorScheme.error,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        controller: answerControllers[i],
                        decoration: InputDecoration(
                          hintText: 'Enter answer ${i + 1} here',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (answerSize > 1)
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (answerSize > 1) {
                    answerSize--;
                  }
                });
              },
              child: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            )
          else
            const SizedBox.shrink(),
          const SizedBox(
            width: 10,
          ),
          if (answerSize < 6)
            FloatingActionButton(
              onPressed: () {
                setState(() {
                  if (answerSize < 6) {
                    answerSize++;
                  }
                });
              },
              child: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            )
          else
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
