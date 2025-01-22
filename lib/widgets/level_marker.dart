import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

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
      )
    );
  }
}