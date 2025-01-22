import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/quiz_progress_model.dart';
import '../services/quiz_progress_service.dart';

final quizProgressNotifierProvider = StateNotifierProvider.family<
    QuizProgressNotifier, bool, QuizProgressServiceArgs>((ref, args) {
  final quizProgressService = ref.watch(quizProgressServiceProvider(args));
  return QuizProgressNotifier(
      quizProgressService: quizProgressService,
      ref: ref,
      uid: args.uid,
      level: args.level,
      correctAnswers: args.correctAnswers,
      totalQuestions: args.totalQuestions);
});

final quizProgressProvider =
    FutureProvider.family<QuizProgressModel?, QuizProgressServiceArgs>(
        (ref, args) async {
  final quizProgressService = ref.watch(quizProgressServiceProvider(args));
  QuizProgressModel? quizProgress = await quizProgressService.getQuizProgress();
  print('quizProgress: $quizProgress');
  return quizProgress;
});

class QuizProgressNotifier extends StateNotifier<bool> {
  final QuizProgressService _quizProgressService;
  final Ref _ref;
  final String uid;
  final int level;
  final int correctAnswers;
  final int totalQuestions;

  QuizProgressNotifier(
      {required quizProgressService,
      required ref,
      required this.uid,
      required this.level,
      required this.correctAnswers,
      required this.totalQuestions})
      : _quizProgressService = quizProgressService,
        _ref = ref,
        super(false);

  Future<void> saveQuizProgress() async {
    try {
      print("Saving Quiz Progress");
      await _quizProgressService.saveQuizProgress();
      state = true;
    } catch (e) {
      print("Error saving quiz progress: $e");
      state = false;
    }
  }

  Future<QuizProgressModel?> getQuizProgress() async {
    try {
      print("Getting Quiz Progress");
      final quizProgress = await _quizProgressService.getQuizProgress();
      state = true;
      return quizProgress;
    } catch (e) {
      print("Error getting quiz progress: $e");
      state = false;
      return null;
    }
  }
}
