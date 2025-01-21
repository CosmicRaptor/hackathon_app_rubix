import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/models/user_model.dart';
import 'package:hackathon_app_rubix/providers/user_provider.dart';
import 'package:hackathon_app_rubix/screens/home_screen.dart';
import 'package:hackathon_app_rubix/screens/login_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
      ProviderScope(
          child: const MyApp(),
      ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(authNotifierProvider.notifier).fetchUserDetails();
    UserModel? user = ref.watch(userModelProvider.notifier).state;
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: user == null ? LoginScreen() : const HomeScreen(),
    );
  }
}