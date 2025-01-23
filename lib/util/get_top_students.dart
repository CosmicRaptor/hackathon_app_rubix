import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user_model.dart';

Future<List<UserModel>> getTopStudents() async {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<UserModel> topStudents = [];

  QuerySnapshot querySnapshot = await _firestore
      .collection('QuizProgress')
      .orderBy('correctAnswers', descending: true)
      .get();
  // print('Query snapshot: ${querySnapshot.docs}'); // Debugging output

  for (var doc in querySnapshot.docs) {
    // print('Doc: ${doc.data()}'); // Debugging output
    // print('UID: ${doc['uid']}'); // Debugging output
    // Fetch user details
    DocumentSnapshot userSnapshot =
    await _firestore.collection('User').doc(doc['uid']).get();
    // print('User snapshot: ${userSnapshot.data()}'); // Debugging output

    // Map the data to a UserModel object
    if (userSnapshot.exists) {
      UserModel user =
      UserModel.fromMap(userSnapshot.data() as Map<String, dynamic>);
      // print('User: ${user.name}'); // Debugging output

      // Check if the user is a student
      if (user.type == 'student') {
        topStudents.add(user);
      }
    }
  }

  // print(topStudents); // Debugging output
  return topStudents;
}
