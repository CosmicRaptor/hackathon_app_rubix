import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon_app_rubix/util/globals.dart';
import 'package:hackathon_app_rubix/util/show_snackbar.dart';

import '../screens/quiz_screen.dart';
import '../services/question_service.dart';

class LevelMarker extends StatelessWidget {
  final int level;
  final String era;
  late final bool isLocked;

  LevelMarker({
    super.key,
    required this.level,
    required this.era,
  }) {
    isLocked = level > Globals.level + 1;
  }
  final ancientSvg = 'assets/pyramid.svg';
  final medievalSvg = 'assets/castle.svg';
  final modernSvg = 'assets/factory.svg';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 60,
        height: 60,
        child: GestureDetector(
          onTap: () {
            //TODO: put the actual era here later
            if (!isLocked) {
              Globals.level = level;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(
                    args: QuestionServiceArgs(level: level, era: 'modern'),
                  ),
                ),
              );
            }
            else {
              showSnackbar(context, 'Level $level is locked');
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                bottom: 30,
                child: SvgPicture.asset(
                  era == 'ancient'
                      ? ancientSvg
                      : era == 'medieval'
                          ? medievalSvg
                          : modernSvg,
                  fit: BoxFit.contain,
                  colorFilter: isLocked
                      ? ColorFilter.mode(Colors.grey, BlendMode.saturation)
                      : null,
                ),
              ),
              //text comes below the icon
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Text(
                  'Level $level',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
              ),
              if (isLocked)
                Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(
                    Icons.lock,
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ));
  }
}
