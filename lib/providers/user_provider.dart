import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/models/user_model.dart';
import 'package:hackathon_app_rubix/services/auth_service.dart';

final authNotifierProvider = StateNotifierProvider<AuthNotifier, bool>((ref) {
  final authService = ref.watch(authServiceProvider);
  return AuthNotifier(authService: authService, ref: ref);
});

final userModelProvider = StateProvider<UserModel?>((ref) {
  return null;
});

final userProvider = StateProvider<User?>((ref) {
  return ref.watch(authServiceProvider).user;
});

class AuthNotifier extends StateNotifier<bool> {
  final AuthService _authService;
  final Ref _ref;

  AuthNotifier({authService, ref})
      : _authService = authService,
        _ref = ref,
        super(false);

  Future<UserCredential?> signInUser(
      String email, String password, BuildContext context) async {
    return await _authService.signInUser(email, password, context);
  }

  Future<UserCredential?> registerUser(String email, String password,
      String name, String type, BuildContext context) async {
    return await _authService.registerUser(
        email, password, name, type, context);
  }

  Future<UserCredential?> signInWithGoogle(BuildContext context) async {
    return await _authService.signInWithGoogle(context);
  }

  Future<UserModel?> fetchUserDetails() async {
    final user = _authService.user;
    if (user != null) {
      final userDoc = await _authService.usersCollection.doc(user.uid).get();
      if (userDoc.exists) {
        _ref.read(userModelProvider.notifier).state =
            UserModel.fromMap(userDoc.data()!);
        return UserModel.fromMap(userDoc.data()!);
      }
    }
    return null;
  }

  Future<void> signOut() async {
    //TODO: set states of providers to null
    _ref.read(userModelProvider.notifier).state = null;
    await _authService.signOut();
  }
}
