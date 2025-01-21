import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/user_provider.dart';
import 'login_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                ref.read(authNotifierProvider.notifier).signOut();
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),),);
              },
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
