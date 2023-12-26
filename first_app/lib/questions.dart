import 'package:first_app/answer_button.dart';
import 'package:first_app/data/questions.dart';
import 'package:flutter/material.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _QuestionsScreenState();
  }
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[0];

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(currentQuestion.text,
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 30),
          ...currentQuestion.answers.map((item) {
            return AnswerButton(answerText: item, onTap: () {});
          })
        ],
      ),
    );
  }
}
