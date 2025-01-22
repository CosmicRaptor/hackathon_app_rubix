import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/question_service.dart';
import '../providers/question_provider.dart';

class QuizScreen extends ConsumerWidget {
  final QuestionServiceArgs args;
  const QuizScreen({super.key, required this.args});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: ref.watch(questionsProvider(args)).when(
        data: (questions) {
          return ListView.builder(
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final question = questions[index];
              return ListTile(
                title: Text(question.question),
                subtitle: Text(question.options.toString()),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) {
          print('Error: $error');
          // print('Stack: $stack');
          return Center(child: Text('Error: $error'));
        },
      ),
    );
  }
}

