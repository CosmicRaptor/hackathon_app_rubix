import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/screens/sign_up_screen.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../widgets/custom_scaffold.dart';
import 'home_screen.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // App Icon
                const SizedBox(
                  height: 200,
                  width: 200,
                  child: FlutterLogo(),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    await ref.read(authNotifierProvider.notifier).signInUser(
                          emailController.text,
                          passwordController.text,
                          context,
                        );
                    await ref
                        .read(authNotifierProvider.notifier)
                        .fetchUserDetails();
                    UserModel? user =
                        ref.watch(userModelProvider.notifier).state;
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  },
                  child: const Text('Sign in'),
                ),
                const SizedBox(height: 20),
                SignInButton(
                  Buttons.google,
                  onPressed: () async {
                    await ref
                        .watch(authNotifierProvider.notifier)
                        .signInWithGoogle(context);
                    await ref
                        .watch(authNotifierProvider.notifier)
                        .fetchUserDetails();
                    UserModel? user =
                        ref.watch(userModelProvider.notifier).state;
                    if (user != null) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ),
                      );
                    }
                  },
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpScreen()),
                    );
                  },
                  child: const Text("Don't have an account? Sign Up"),
                ),
              ]),
        ),
      ),
    );
  }
}
