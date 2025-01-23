import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/providers/user_provider.dart';
import 'package:hackathon_app_rubix/screens/quiz_main_screen.dart';

import '../providers/quiz_progress_provider.dart';
import '../services/quiz_progress_service.dart';
import '../util/globals.dart';
import '../widgets/custom_scaffold.dart';

class ResultScreen extends ConsumerWidget {
  final int correctAnswers;
  final int totalQuestions;
  final double timeTaken;

  const ResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeTaken,
  });

  void submitQuiz(BuildContext context, WidgetRef ref) async {
    final String uid = ref.read(userProvider.notifier).state!.uid;

    final quizProgressNotifier = ref.read(
      quizProgressNotifierProvider(
        QuizProgressServiceArgs(
          uid: uid,
          level: Globals.level + 1,
          correctAnswers: correctAnswers,
          totalQuestions: totalQuestions,
        ),
      ).notifier,
    );

    await quizProgressNotifier.getQuizProgress(); // Fetch progress

    final currentProgress = await quizProgressNotifier.getQuizProgress();
    print(currentProgress);
    if (currentProgress != null) {
      await quizProgressNotifier.saveQuizProgress(); // Save progress
    }
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const QuizMainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Quiz Result'),
        // backgroundColor: Colors.teal,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Title Card
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    const Icon(
                      Icons.emoji_events,
                      color: Colors.amber,
                      size: 80,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Quiz Completed!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal.shade700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Result Details
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              color: Colors.white,
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildResultRow(
                      label: 'Correct Answers:',
                      value: '$correctAnswers / $totalQuestions',
                      color: Colors.green.shade700,
                    ),
                    const SizedBox(height: 10),
                    _buildResultRow(
                      label: 'Time Taken:',
                      value: '${timeTaken.toStringAsFixed(2)} seconds',
                      color: Colors.blue.shade700,
                    ),
                    const SizedBox(height: 10),
                    _buildResultRow(
                      label: 'Score:',
                      value:
                          '${((correctAnswers / totalQuestions) * 100).toStringAsFixed(1)}%',
                      color: Colors.amber.shade700,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),

            // Go Back Button
            ElevatedButton(
              onPressed: () => submitQuiz(context, ref),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade600,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text(
                'Go Back',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResultRow({
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
