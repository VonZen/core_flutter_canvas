import 'dart:math';

import 'package:flutter/material.dart';

class CFCCH27 extends StatefulWidget {
  const CFCCH27({Key? key}) : super(key: key);

  @override
  State<CFCCH27> createState() => _CFCCH27State();
}

class _CFCCH27State extends State<CFCCH27> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              padding: const EdgeInsets.all(6),
              child: SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: FittedBox(
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                    child: CustomPaint(
                      // painter: Path1Painter(),
                      painter: PathFileRulePainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

//https://medium.com/flutter-community/paths-in-flutter-a-visual-guide-6c906464dcd0
//https://medium.com/flutter-community/playing-with-paths-in-flutter-97198ba046c8
//https://github.com/ravishankarsingh1996/custom_shape_background

///
///1. create path
///2. add...
///3. close() or not
///4. canvas.drawPath
class Path1Painter extends CustomPainter {
  final pen = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    pathWithShape(canvas, PaintingStyle.stroke);
    canvas.translate(100, 0);
    pathWithShape(canvas, PaintingStyle.fill);
    canvas.translate(100, 0);
    pathWthReset(canvas);
  }

  void pathWithShape(Canvas canvas, PaintingStyle style) {
    final path = Path();
    final rect = Rect.fromCenter(center: const Offset(50, 50), width: 50, height: 50);
    path.addRect(rect);

    path.addArc(rect.shift(const Offset(0, 100)), 0.0, pi * 1.5);

    path.addArc(rect.shift(const Offset(0, 200)), 0.0, pi * 1.5);
    // 闭合最近添加的子路径
    path.close();
    canvas.drawPath(path, Paint()..style = style);
  }

  void pathWthReset(Canvas canvas) {
    final path = Path();
    final rect = Rect.fromCenter(center: const Offset(50, 50), width: 50, height: 50);
    path.addRect(rect);

    // path.reset();

    path.addArc(rect.shift(const Offset(0, 100)), 0.0, pi * 1.5);
    // 闭合最近添加的子路径
    path.close();

    canvas.drawPath(path, Paint()..style = PaintingStyle.stroke);
  }

  @override
  bool shouldRepaint(Path1Painter oldDelegate) => true;
}

class PathFileRulePainter extends CustomPainter {
  final pen = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    pathWithFillRule(canvas, PathFillType.nonZero);
    canvas.translate(200, 0);
    pathWithFillRule(canvas, PathFillType.evenOdd);
  }

  void pathWithFillRule(Canvas canvas, PathFillType type) {
    final path = Path()..fillType = type;
    final rect = Rect.fromCenter(center: const Offset(50, 50), width: 50, height: 50);
    final rect2 = Rect.fromCenter(center: const Offset(50, 50), width: 30, height: 30);
    path.addArc(rect, 0, 2 * pi);
    path.addArc(rect.shift(const Offset(40, 0)), 0, 2 * pi);

    path.addArc(rect.shift(const Offset(0, 60)), 0, 2 * pi);
    path.addArc(rect.shift(const Offset(40, 60)), 0, -2 * pi);

    path.addArc(rect.shift(const Offset(20, 120)).inflate(0.5), 0, 2 * pi);
    path.addArc(rect2.shift(const Offset(20, 120)), 0, 2 * pi);

    path.addArc(rect.shift(const Offset(20, 180)).inflate(0.5), 0, 2 * pi);
    path.addArc(rect2.shift(const Offset(20, 180)), 0, -2 * pi);

    path.moveTo(80, 280);
    path.lineTo(80 + cos(pi * 3 / 10) * 50, 330 + sin(pi * 3 / 10) * 50);
    path.lineTo(80 - cos(pi * 1 / 10) * 50, 330 - sin(pi * 1 / 10) * 50);
    path.lineTo(80 + cos(pi * 1 / 10) * 50, 330 - sin(pi * 1 / 10) * 50);
    path.lineTo(80 - cos(pi * 3 / 10) * 50, 330 + sin(pi * 3 / 10) * 50);
    path.lineTo(80, 280);

    canvas.drawPath(path, Paint()..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(PathFileRulePainter oldDelegate) => false;
}
