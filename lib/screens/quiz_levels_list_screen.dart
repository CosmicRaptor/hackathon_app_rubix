import 'package:flutter/material.dart';
import 'package:hackathon_app_rubix/widgets/drawer.dart';

import '../widgets/custom_scaffold.dart';
import '../widgets/level_marker.dart';

class QuizLevelsListScreen extends StatelessWidget {
  const QuizLevelsListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Quiz Levels'),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: 100,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox();
              }
              return Padding(
                padding: EdgeInsets.all(8),
                child: SizedBox(
                  width: 100,
                  height: 200,
                  child: LevelMarker(
                    level: index,
                    era: ['modern', 'medieval', 'ancient'][index % 3],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
