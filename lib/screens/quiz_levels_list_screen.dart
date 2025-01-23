import 'package:flutter/material.dart';
import 'package:hackathon_app_rubix/widgets/drawer.dart';

import '../widgets/custom_scaffold.dart';
import '../widgets/level_marker.dart';

class QuizLevelsListScreen extends StatelessWidget {
  final String quizEra;
  const QuizLevelsListScreen({super.key, required this.quizEra});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: AppBar(
        title: const Text('Quiz Levels'),
      ),
      drawer: DrawerWidget(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
            itemCount: 6,
            itemBuilder: (context, index) {
              if (index == 0) {
                return const SizedBox();
              }

              return Column(
                children: [
                  // Level Marker
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: [MainAxisAlignment.start, MainAxisAlignment.end][index % 2],
                      children: [
                        SizedBox(
                          width: 100,
                          height: 150,
                          child: LevelMarker(
                            level: index,
                            era: quizEra,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Arrow
                  if (index != 5) // Don't show arrow for the last marker
                    CustomPaint(
                      size: const Size(50, 50), // Customize size for arrow spacing
                      painter: ArrowPainter(
                        direction: index % 2 == 0
                            ? ArrowDirection.rightToLeft
                            : ArrowDirection.leftToRight,
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

// Enum for arrow direction
enum ArrowDirection { leftToRight, rightToLeft }

// Custom painter for drawing the arrows
class ArrowPainter extends CustomPainter {
  final ArrowDirection direction;

  ArrowPainter({required this.direction});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();

    if (direction == ArrowDirection.leftToRight) {
      // Draw slanted left-to-right arrow
      path.moveTo(0, size.height); // Start at bottom-left
      path.lineTo(size.width, 0); // Slanted line to top-right
      path.lineTo(size.width - 10, 10); // Arrowhead top
      path.moveTo(size.width, 0); // Return to end point
      path.lineTo(size.width - 10, -10); // Arrowhead bottom
    } else {
      // Draw slanted right-to-left arrow
      path.moveTo(size.width, size.height); // Start at bottom-right
      path.lineTo(0, 0); // Slanted line to top-left
      path.lineTo(10, 10); // Arrowhead top
      path.moveTo(0, 0); // Return to start point
      path.lineTo(10, -10); // Arrowhead bottom
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
