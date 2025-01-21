import 'package:flutter/material.dart';

class IslandLevelIndicator extends StatelessWidget {
  final int level;

  const IslandLevelIndicator({Key? key, required this.level}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60,
      height: 60,
      child: CustomPaint(
        painter: IslandPainter(),
        child: Center(
          child: Text(
            'Level $level',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}

class IslandPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint sandPaint = Paint()..color = Colors.yellow[700]!;
    final Paint grassPaint = Paint()..color = Colors.green[400]!;

    // Smooth curved sandy outline
    final sandPath = Path()
      ..moveTo(size.width * 0.2, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.3, size.height * 0.9, size.width * 0.5, size.height * 0.85)
      ..quadraticBezierTo(
          size.width * 0.7, size.height * 0.9, size.width * 0.8, size.height * 0.7)
      ..quadraticBezierTo(
          size.width * 0.9, size.height * 0.5, size.width * 0.7, size.height * 0.4)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 0.3, size.width * 0.3, size.height * 0.4)
      ..quadraticBezierTo(
          size.width * 0.1, size.height * 0.5, size.width * 0.2, size.height * 0.7)
      ..close();
    canvas.drawPath(sandPath, sandPaint);

    // Smooth green center area
    final grassPath = Path()
      ..moveTo(size.width * 0.35, size.height * 0.6)
      ..quadraticBezierTo(
          size.width * 0.45, size.height * 0.7, size.width * 0.55, size.height * 0.65)
      ..quadraticBezierTo(
          size.width * 0.65, size.height * 0.6, size.width * 0.6, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.5, size.height * 0.4, size.width * 0.4, size.height * 0.5)
      ..quadraticBezierTo(
          size.width * 0.3, size.height * 0.55, size.width * 0.35, size.height * 0.6)
      ..close();
    canvas.drawPath(grassPath, grassPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
