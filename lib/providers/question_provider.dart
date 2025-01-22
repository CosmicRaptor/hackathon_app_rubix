
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/models/question_model.dart';

import '../services/question_service.dart';

final questionNotifierProvider = StateNotifierProvider.family<QuestionNotifier, bool, QuestionServiceArgs>((ref, qargs) {
  final questionService = ref.watch(questionServiceProvider(qargs));
  return QuestionNotifier(questionService: questionService, ref: ref, level: qargs.level, era: qargs.era);
});

final questionsProvider = FutureProvider.family<List<QuestionModel>, QuestionServiceArgs>((ref, args) async {
  final questionService = ref.watch(questionServiceProvider(args));
  return await questionService.getQuestions();
});

class QuestionNotifier extends StateNotifier<bool>{
  final QuestionService _questionService;
  final Ref _ref;
  final int level;
  final String era;

  QuestionNotifier({required questionService, required ref, required this.level, required this.era})
      : _questionService = questionService,
        _ref = ref,
        super(false);

  Future<List<QuestionModel>> getQuestions() async {
    final questions = await _questionService.getQuestions();
    state = true;
    print('Questions: $questions');
    return questions;
  }
}