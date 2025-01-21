import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hackathon_app_rubix/util/show_snackbar.dart';

import '../models/user_model.dart';

final authServiceProvider = Provider((ref) => AuthService(
  firebaseAuth: FirebaseAuth.instance,
  firebaseStorage: FirebaseFirestore.instance,
));

class AuthService {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseStorage;
  AuthService({
    required this.firebaseAuth,
    required this.firebaseStorage,
  });

  CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection('User');
  Stream<User?> get userCurrentState => firebaseAuth.authStateChanges();
  User? get user => firebaseAuth.currentUser;

  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  Future<UserCredential?> signInUser(String email, String password, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showSnackbar(context, "No user found for that email.");
      } else if (e.code == 'wrong-password') {
        showSnackbar(context, "Wrong password provided for that user.");
      }
      else {
        showSnackbar(context, e.message.toString());
      }
      return null;
    }
  }

  //register user with email and password

  Future<UserCredential?> registerUser(String email, String password, String name, String type, BuildContext context) async {
    try {
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await usersCollection.doc(userCredential.user!.uid).set({
        'email': email,
        'name': name,
        'type': type,
        'fcmToken': '',
      });
      return userCredential;
    } on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
      return null;
    }
  }

  //sign in with google

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleSignInAccount = await googleSignIn
          .signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken,
        );
        //check if there's a document in the db

         if(user != null)   {
          DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
              await usersCollection.doc(user!.uid).get();
          if (!documentSnapshot.exists) {
            await usersCollection.doc(user!.uid).set({
              'email': user!.email,
              'name': user!.displayName,
              'type': 'user1',
              'fcmToken': '',
            });
          }
        }

        // Getting users credential
        UserCredential result = await firebaseAuth.signInWithCredential(authCredential);
        return result;
      }
      return null;
    }
    on FirebaseAuthException catch (e) {
      showSnackbar(context, e.message.toString());
      return null;
    }
  }

  Future<UserModel?> fetchUserDetails(User? user, BuildContext context) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await usersCollection.doc(user!.uid).get();
      if (documentSnapshot.exists) {
        return UserModel.fromMap(documentSnapshot.data()!);
      }
      return null;
    } on FirebaseException catch (e) {
      showSnackbar(context, e.message.toString());
      return null;
    }
  }
}