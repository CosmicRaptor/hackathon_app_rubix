import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/models/question_model.dart';

final questionServiceProvider = Provider.family<QuestionService, QuestionServiceArgs>((ref, args) {
  final firebaseStorage = FirebaseFirestore.instance;
  return QuestionService(firebaseStorage: firebaseStorage, level: args.level, era: args.era);
});

class QuestionServiceArgs {
  final int level;
  final String era;

  QuestionServiceArgs({required this.level, required this.era});
}

class QuestionService {
  final FirebaseFirestore firebaseStorage;
  final int level;
  final String era;
  late final CollectionReference<Map<String, dynamic>> questionsCollection;

  QuestionService({
    required this.firebaseStorage,
    required this.level,
    required this.era,
  }) {
    questionsCollection = firebaseStorage.collection('Quiz').doc(era).collection('levels').doc(level.toString()).collection('questions');
  }

  Future<List<QuestionModel>> getQuestions() async {
    final querySnapshot = await questionsCollection.get();
    final questions =  querySnapshot.docs.map((doc) {
      print('Doc data: ${doc.data()}');
      return QuestionModel.fromJson(doc.data());
    }).toList();
    print('Questions in service: $questions');
    return questions;
  }
}