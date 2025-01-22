import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/models/quiz_progress_model.dart';

final quizProgressServiceProvider = Provider.family<QuizProgressService, QuizProgressServiceArgs>((ref, args) {
  final firebaseStorage = FirebaseFirestore.instance;
  return QuizProgressService(
    firebaseStorage: firebaseStorage,
    uid: args.uid,
    level: args.level,
    correctAnswers: args.correctAnswers,
    totalQuestions: args.totalQuestions,
  );
});

class QuizProgressServiceArgs {
  final String uid;
  final int level;
  final int correctAnswers;
  final int totalQuestions;

  QuizProgressServiceArgs({
    required this.uid,
    required this.level,
    required this.correctAnswers,
    required this.totalQuestions,
  });
}

class QuizProgressService {
  final FirebaseFirestore firebaseStorage;
  final String uid;
  final int level;
  final int correctAnswers;
  final int totalQuestions;
  
  late final DocumentReference<Map<String, dynamic>> quizProgressDoc;
  QuizProgressService({
    required this.firebaseStorage,
    required this.uid,
    required this.level,
    required this.correctAnswers,
    required this.totalQuestions,
  }) {
    quizProgressDoc = firebaseStorage.collection('QuizProgress').doc(uid);
  }
  
  Future<void> saveQuizProgress() async {
    int correctAnswers = this.correctAnswers;
    int totalQuestions = this.totalQuestions;
    int level = this.level;
    print('Saving to $quizProgressDoc');
    QuizProgressModel? quizProgress = await getQuizProgress();
    if(quizProgress != null){
      correctAnswers += quizProgress.correctAnswers;
      totalQuestions += quizProgress.totalQuestions;
      level = quizProgress.level;
    }
    await quizProgressDoc.set({
      'uid': uid,
      'level': level,
      'correctAnswers': correctAnswers,
      'totalQuestions': totalQuestions,
    });
  }

  Future<QuizProgressModel?> getQuizProgress() async {
    final docSnapshot = await quizProgressDoc.get();
    print('docSnapshot: ${docSnapshot.data()}');
    if (docSnapshot.exists) {
      QuizProgressModel quizProgress = QuizProgressModel.fromMap(docSnapshot.data()!);
      print('quizProgress: $quizProgress');
      return quizProgress;
    }
    else {
      await quizProgressDoc.set({
        'uid': uid,
        'level': level,
        'correctAnswers': 0,
        'totalQuestions': 0,
      });
      QuizProgressModel quizProgress = QuizProgressModel.fromMap(docSnapshot.data()!);
      print('quizProgress: $quizProgress');
      return quizProgress;
    }
  }
}