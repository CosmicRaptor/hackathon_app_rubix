import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import 'home_screen.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
              ),
              TextField(
                obscureText: true,
                controller: passwordController,
                decoration: const InputDecoration(
                  hintText: 'Password',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await ref.read(authNotifierProvider.notifier).signInUser(
                    emailController.text,
                    passwordController.text,
                    context,
                  );
                  await ref.read(authNotifierProvider.notifier).fetchUserDetails();
                  UserModel? user = ref.watch(userModelProvider.notifier).state;
                  if (user != null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
                  }
                },
                child: const Text('Sign in'),
              ),
              ElevatedButton(
                onPressed: () async {
                  await ref.watch(authNotifierProvider.notifier).signInWithGoogle(context);
                  await ref.watch(authNotifierProvider.notifier).fetchUserDetails();
                  UserModel? user = ref.watch(userModelProvider.notifier).state;
                  if (user != null) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),),);
                  }
                },
                child: const Text('Sign in with Google'),
              ),
        ]
            ),
            ),
      ),
    );
  }
}
