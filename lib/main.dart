import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/api_key.dart';
import 'package:hackathon_app_rubix/models/user_model.dart';
import 'package:hackathon_app_rubix/providers/user_provider.dart';
import 'package:hackathon_app_rubix/screens/home_screen.dart';
import 'package:hackathon_app_rubix/screens/login_screen.dart';
import 'package:rxdart/rxdart.dart';

import 'firebase_options.dart';

final _messageStreamController = BehaviorSubject<RemoteMessage>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();

  if (kDebugMode) {
    print("Handling a background message: ${message.messageId}");
    print('Message data: ${message.data}');
    print('Message notification: ${message.notification?.title}');
    print('Message notification: ${message.notification?.body}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    if (kDebugMode) {
      print('Handling a foreground message: ${message.messageId}');
      print('Message data: ${message.data}');
      print('Message notification: ${message.notification?.title}');
      print('Message notification: ${message.notification?.body}');
    }

    if (message.notification != null) {
      final title = message.notification?.title ?? 'New Notification';
      final body = message.notification?.body ?? 'You have a new message';

      // Use a GlobalKey to access the ScaffoldMessenger
      MyApp.showSnackbar(title, body);
    }

    _messageStreamController.sink.add(message);
  });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  Gemini.init(apiKey: gemini_api_key);
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  static final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
  GlobalKey<ScaffoldMessengerState>();

  static void showSnackbar(String title, String body) {
    final snackBar = SnackBar(
      content: Text('$title: $body'),
      duration: const Duration(seconds: 3),
    );
    print('Showing snackbar');
    scaffoldMessengerKey.currentState?.showSnackBar(snackBar);
  }

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
