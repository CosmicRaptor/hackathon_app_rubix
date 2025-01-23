import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final leaderboardServiceProvider = Provider<LeaderboardService>((ref) {
  final firestore = FirebaseFirestore.instance;
  return LeaderboardService(firestore);
});

class LeaderboardService {
  final FirebaseFirestore _firestore;

  LeaderboardService(this._firestore);
  CollectionReference get leaderboardCollection =>
      _firestore.collection('QuizProgress');

  Future<List<String>> getTopUids() async {
    final querySnapshot = await leaderboardCollection
        .orderBy('correctAnswers', descending: true)
        .limit(5)
        .get();
    return querySnapshot.docs.map((doc) {
      return doc.id;
    }).toList();
  }

  Future<List<String>> getTopUsers() async {
    final querySnapshot = await leaderboardCollection
        .orderBy('correctAnswers', descending: true)
        .limit(5)
        .get();
    final futures = querySnapshot.docs.map((doc) {
      return _firestore.collection('User').doc(doc.id).get().then((userDoc) {
        return userDoc.get('name') as String;
      });
    }).toList();
    return Future.wait(futures);
  }

  Future<int> getRank(String uid) async {
    final querySnapshot = await leaderboardCollection
        .orderBy('correctAnswers', descending: true)
        .get();
    final docs = querySnapshot.docs;
    final int rank = docs.indexWhere((doc) => doc.id == uid) + 1;
    return rank;
  }
}
