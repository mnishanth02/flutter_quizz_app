import 'package:flutter/material.dart';
import 'package:quizz_app/data/questions.dart';
import 'package:quizz_app/questions_summary.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key, required this.chosenAnswers, required this.resetQuizz});

  final List<String> chosenAnswers;
  final void Function() resetQuizz;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summery = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summery.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }
    return summery;
  }

  @override
  Widget build(BuildContext context) {
    // final summaryData = sumeryData;
    final numTotalQuestions = questions.length;
    final numCorrectQuestions = summaryData
        .where((data) => data['correct_answer'] == data['user_answer'])
        .length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answed $numCorrectQuestions out of $numTotalQuestions questions correctly',
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 230, 200, 253),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionsSummary(summaryData),
            TextButton.icon(
                style: TextButton.styleFrom(foregroundColor: Colors.white),
                onPressed: resetQuizz,
                icon: const Icon(Icons.refresh),
                label: const Text('Restart Quiz'))
          ],
        ),
      ),
    );
  }
}
