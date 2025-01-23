import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/api_key.dart';
import 'package:hackathon_app_rubix/models/user_model.dart';
import 'package:hackathon_app_rubix/providers/user_provider.dart';
import 'package:hackathon_app_rubix/screens/home_screen.dart';
import 'package:hackathon_app_rubix/screens/login_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Gemini.init(apiKey: gemini_api_key);
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: ref.watch(authNotifierProvider.notifier).fetchUserDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        } else {
          UserModel? user = ref.read(userModelProvider.notifier).state;
          // if(user != null){
          //   QuizProgressModel? quizProgress = ref
          //       .watch(
          //         quizProgressProvider(
          //           QuizProgressServiceArgs(
          //               uid: ref.read(userProvider.notifier).state!.uid,
          //               level: 0,
          //               correctAnswers: 0,
          //               totalQuestions: 0,
          //           ),
          //         ),
          //       )
          //       .value;
          //   Globals.level = quizProgress?.level ?? 0;
          // }
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Color(0x00f5f5f4)),
              buttonTheme: ButtonThemeData(
                buttonColor: Color(0x00b45309),
                textTheme: ButtonTextTheme.primary,
              ),
              appBarTheme: AppBarTheme(
                backgroundColor: Colors.transparent,
                elevation: 0,
              ),
              useMaterial3: true,
              fontFamily: 'Cinzel',
            ),
            home: user == null ? LoginScreen() : const HomeScreen(),
          );
        }
      },
    );
  }
}
