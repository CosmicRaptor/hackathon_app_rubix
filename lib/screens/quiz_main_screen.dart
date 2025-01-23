import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon_app_rubix/screens/quiz_levels_list_screen.dart';
import 'package:hackathon_app_rubix/widgets/custom_scaffold.dart';

import '../models/quiz_progress_model.dart';
import '../models/user_model.dart';
import '../providers/quiz_progress_provider.dart';
import '../providers/user_provider.dart';
import '../services/quiz_progress_service.dart';
import '../util/globals.dart';
import '../widgets/drawer.dart';

class QuizMainScreen extends ConsumerWidget {
  const QuizMainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    UserModel? user = ref.read(userModelProvider.notifier).state;
    if(user != null){
      ref
          .read(
            quizProgressProvider(
              QuizProgressServiceArgs(
                  uid: ref.read(userProvider.notifier).state!.uid,
                  level: 0,
                  correctAnswers: 0,
                  totalQuestions: 0,
              ),
            ),
          )
          .when(
              data: (QuizProgressModel? quizProgress) {
                if (quizProgress != null) {
                  print('Quiz Progress: $quizProgress');
                  Globals.level = quizProgress.level;
                }
              },
              loading: () => print('Loading'),
              error: (error, stackTrace) {
                print('Error: $error');
      });
    }
    return CustomScaffold(
        appBar: AppBar(
          title: const Text('Quiz'),
        ),
        drawer: DrawerWidget(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizLevelsListScreen(quizEra: 'ancient'),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    //3 cards, for 3 eras
                    children: [
                      //image, era name and description
                      SizedBox(
                        width: 100,
                        height: 100,
                          child: SvgPicture.asset('assets/pyramid.svg')),
                      const Text('Ancient era'),
                      const Text('Quiz yourself about ancient history. From early humans to the fall of the Roman Empire. From Egypt to India.'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizLevelsListScreen(quizEra: 'medieval'),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    //image, era name and description
                    children: [
                      SizedBox(
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset('assets/castle.svg')),
                      const Text('Medieval era'),
                      const Text('Quiz yourself about medieval history. From the fall of the Roman Empire to the Renaissance. From the Vikings to the Mongols.'),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizLevelsListScreen(quizEra: 'modern'),
                    ),
                  );
                },
                child: Card(
                  child: Column(
                    //image, era name and description
                    children: [
                      SizedBox(
                          width: 100,
                          height: 100,
                          child: SvgPicture.asset('assets/factory.svg')),
                      const Text('Modern era'),
                      const Text('Quiz yourself about modern history. From the Renaissance to the present day. From the Industrial Revolution to the Space Age.'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
    );
  }
}
