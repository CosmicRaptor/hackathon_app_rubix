import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hackathon_app_rubix/util/globals.dart';

import '../screens/quiz_screen.dart';
import '../services/question_service.dart';

class LevelMarker extends StatelessWidget {
  final int level;
  final String era;

  const LevelMarker({super.key, required this.level, required this.era,});
  final ancientSvg = 'assets/pyramid.svg';
  final medievalSvg = 'assets/castle.svg';
  final modernSvg = 'assets/factory.svg';

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: GestureDetector(
        onTap: (){
          //TODO: put the actual era here later
          Globals.level = level;
          Navigator.push(context, MaterialPageRoute(builder: (context) => QuizScreen(args: QuestionServiceArgs(level: level, era: 'modern'),),),);
        },
        child: Stack(
          children: [
            Positioned.fill(
              bottom: 30,
              child: SvgPicture.asset(
                era == 'ancient' ? ancientSvg : era == 'medieval' ? medievalSvg : modernSvg,
                fit: BoxFit.contain,
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
          ],
        ),
      )
    );
  }
}