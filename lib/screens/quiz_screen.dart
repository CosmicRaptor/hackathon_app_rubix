import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/screens/result_screen.dart';
import 'package:hackathon_app_rubix/widgets/question_widget.dart';

import '../services/question_service.dart';
import '../providers/question_provider.dart';

class QuizScreen extends ConsumerStatefulWidget {
  final QuestionServiceArgs args;
  const QuizScreen({super.key, required this.args});

  @override
  ConsumerState<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends ConsumerState<QuizScreen> {
  int selectedIndex = 0;
  int correctAnswers = 0;
  int totalQuestions = 0;

  void passedFunction(int length, bool isCorrect) async{
    await Future.delayed(const Duration(seconds: 3));
    if(selectedIndex < length - 1){
      setState(() {
        selectedIndex++;
        if(isCorrect){
          correctAnswers++;
          print('Correct Answers: $correctAnswers, total questions: $length');
        }
      });
    }
    else {
      if(isCorrect){
        correctAnswers++;
        print('Correct Answers: $correctAnswers, total questions: $length');
      }
      print('Quiz Ended');
      navigateToResultScreen();
    }
  }

  void navigateToResultScreen(){
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => ResultScreen(correctAnswers: correctAnswers, totalQuestions: totalQuestions)));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz'),
      ),
      body: ref.watch(questionsProvider(widget.args)).when(
        data: (questions) {
          totalQuestions = questions.length;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text('Question ${selectedIndex+1}/${questions.length}'),
                const SizedBox(height: 10),
                QuestionWidget(key: ValueKey(selectedIndex), question: questions[selectedIndex], submit: passedFunction, length: questions.length),
              ],
            ),
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

