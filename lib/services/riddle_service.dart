import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/riddle_model.dart';

final riddleServiceProvider = Provider<RiddleService>(
      (ref) => RiddleService(FirebaseFirestore.instance),
);

final riddlesProvider = FutureProvider<List<Riddle>>((ref) async {
  final riddleService = ref.read(riddleServiceProvider);
  return await riddleService.fetchRiddles();
});

class RiddleService {
  final FirebaseFirestore _firestore;

  RiddleService(this._firestore);

  Future<List<Riddle>> fetchRiddles() async {
    final snapshot = await _firestore.collection('Riddles').get();
    return snapshot.docs
        .map((doc) => Riddle.fromJson(doc.data()))
        .toList();
  }
}
