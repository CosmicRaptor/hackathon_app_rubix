import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/providers/user_provider.dart';

import '../providers/quiz_progress_provider.dart';
import '../services/quiz_progress_service.dart';
import '../util/globals.dart';

class ResultScreen extends ConsumerWidget {
  final int correctAnswers;
  final int totalQuestions;
  const ResultScreen(
      {super.key, required this.correctAnswers, required this.totalQuestions});

  void submitQuiz(BuildContext context, WidgetRef ref) async {
    final String uid = ref.read(userProvider.notifier).state!.uid;

    final quizProgressNotifier = ref.read(quizProgressNotifierProvider(
      QuizProgressServiceArgs(
        uid: uid,
        level: Globals.level,
        correctAnswers: correctAnswers,
        totalQuestions: totalQuestions,
      ),
    ).notifier);

    await quizProgressNotifier.getQuizProgress(); // Fetch progress

    final currentProgress = await quizProgressNotifier.getQuizProgress();
    print(currentProgress);
    if (currentProgress != null) {
      await quizProgressNotifier.saveQuizProgress(); // Save progress
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Correct Answers: $correctAnswers'),
            Text('Total Questions: $totalQuestions'),
            ElevatedButton(
              onPressed: () => submitQuiz(context, ref),
              child: const Text('Go Back'),
            )
          ],
        ),
      ),
    );
  }
}
