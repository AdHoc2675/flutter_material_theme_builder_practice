import 'dart:math';

import 'package:flutter/material.dart';
import 'color_schemes.g.dart';

class DragAndDropPage extends StatefulWidget {
  const DragAndDropPage({super.key});

  @override
  State<DragAndDropPage> createState() => _DragAndDropPageState();
}

class _DragAndDropPageState extends State<DragAndDropPage> {
  dynamic _balls;
  double xPos = 100;
  double yPos = 100;

  @override
  Widget build(BuildContext context) {
    _balls = _paint(xPosition: xPos, yPosition: yPos, ballRad: 20);
    bool isClick = false;

    return Scaffold(
        appBar: AppBar(
          title: Text("Drag and Drop"),
        ),
        body: GestureDetector(
          onHorizontalDragDown: (details) {
            setState(() {
              if (_balls.isBallRegion(
                  details.localPosition.dx, details.localPosition.dy)) {
                isClick = true;
              }
            });
          },
          onHorizontalDragEnd: (details) {
            setState(() {
              isClick = false;
            });
          },
          onHorizontalDragUpdate: (details) {
            if (isClick) {
              setState(() {
                xPos = details.localPosition.dx;
                yPos = details.localPosition.dy;
              });
            }
          },
          child: Container(
            width: 300,
            height: 300,
            color: Colors.lightBlueAccent,
            child: CustomPaint(
              painter: _balls,
            ),
          ),
        ));
  }
}

class _paint extends CustomPainter {
  final xPosition;
  final yPosition;
  final ballRad;

  _paint({
    required this.xPosition,
    required this.yPosition,
    required this.ballRad,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.indigoAccent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    Path path = Path();

    for (double i = 0; i < ballRad - 1; i++) {
      path.addOval(
          Rect.fromCircle(center: Offset(xPosition, yPosition), radius: i));
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;

  bool isBallRegion(double checkX, double checkY) {
    if ((pow(xPosition - checkX, 2) + pow(yPosition - checkY, 2)) <=
        pow(ballRad, 2)) {
      return true;
    }
    return false;
  }
}
