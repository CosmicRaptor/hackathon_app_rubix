import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hackathon_app_rubix/widgets/riddle_card.dart';

import '../models/riddle_model.dart';
import '../services/riddle_service.dart';
import '../widgets/custom_scaffold.dart';
import '../widgets/drawer.dart';

class RiddlesScreen extends ConsumerStatefulWidget {
  const RiddlesScreen({super.key});

  @override
  ConsumerState<RiddlesScreen> createState() => _RiddlesScreenState();
}

class _RiddlesScreenState extends ConsumerState<RiddlesScreen> {
  int selectedIndex = 0;
  int attempted = 0;
  int correct = 0;
  int noOfRiddles = 0;
  Stopwatch s1 = Stopwatch();

  @override
  void initState() {
    s1.start();
    super.initState();
  }

  void _onItemTapped(bool isCorrect) {
    if (selectedIndex < noOfRiddles - 1) {
      setState(() {
        selectedIndex++;
      });
      if (isCorrect) {
        correct++;
      }
      attempted++;
    } else {
      if (isCorrect) {
        correct++;
      }
      attempted++;
      print('Quiz Ended');
      // navigateToResultScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Riddles'),
      ),
      drawer: DrawerWidget(),
      body: ref.watch(riddlesProvider).when(
            data: (riddles) {
              noOfRiddles = riddles.length;
              Riddle riddle = riddles[selectedIndex];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: RiddleCard(
                  riddle: riddle,
                  onSubmit: _onItemTapped,
                  key: ValueKey(riddle),
                ),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) => Center(child: Text('Error: $error')),
          ),
    );
  }
}
