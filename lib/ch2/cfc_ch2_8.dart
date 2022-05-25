import 'dart:ui';

import 'package:flutter/material.dart';

class CFCCH28 extends StatefulWidget {
  const CFCCH28({Key? key}) : super(key: key);

  @override
  State<CFCCH28> createState() => _CFCCH28State();
}

class _CFCCH28State extends State<CFCCH28> {
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
                      painter: PathLinePainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

class PathLinePainter extends CustomPainter {
  final pen = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.1; //线条必须先设置

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    drawLines(canvas);
    canvas.translate(50, 120);
    drawGrid(canvas);
    canvas.translate(0, 120);
    drawDashLine(canvas, const Offset(0, 0), const Offset(100, 0));
    canvas.restore();

    canvas.save();
    canvas.translate(150, 0);
    drawLineStyle(canvas);
    canvas.translate(0, 150);
    drawLineJoinStyle(canvas);
    canvas.restore();
  }

  void drawLines(Canvas canvas) {
    //绘制 宽度0.1 - 1 直接的线条
    for (int i = 1; i <= 10; i++) {
      final path = Path();
      path.moveTo(50, i * 10);
      path.lineTo(150, i * 10);
      canvas.drawPath(path, pen..strokeWidth = i * 0.1);
    }
  }

  void drawGrid(Canvas canvas) {
    final path = Path();
    for (int i = 0; i <= 10; i++) {
      path.moveTo(0, i * 10);
      path.lineTo(100, i * 10);

      path.moveTo(i * 10, 0);
      path.lineTo(i * 10, 100);
    }
    canvas.drawPath(
        path,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = Colors.redAccent);
  }

  void drawDashLine(Canvas canvas, Offset p1, Offset p2) {
    final path = Path()
      ..moveTo(p1.dx, p1.dy)
      ..lineTo(p2.dx, p2.dy);

    final dashPath = Path();
    const dashWidth = 4.0;
    const dashSpace = 2.0;
    double distance = 0.0;

    for (var pathMetric in path.computeMetrics()) {
      debugPrint('$pathMetric');
      while (distance < pathMetric.length) {
        dashPath.addPath(pathMetric.extractPath(distance, distance + dashWidth), Offset.zero);
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawPath(dashPath, pen);
  }

  void drawLineStyle(Canvas canvas) {
    final path = Path();
    path.moveTo(50, 10);
    path.lineTo(150, 10);
    canvas.drawPath(
        path,
        pen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.butt);

    canvas.drawPath(
        path.shift(const Offset(0, 20)),
        pen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round);

    canvas.drawPath(
        path.shift(const Offset(0, 40)),
        pen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.square);
  }

  void drawLineJoinStyle(Canvas canvas) {
    final path = Path();
    path.moveTo(50, 10);
    path.lineTo(150, 10);
    path.lineTo(50, 100);
    canvas.drawPath(
        path,
        pen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.butt
          ..strokeJoin = StrokeJoin.bevel);

    canvas.drawPath(
        path.shift(const Offset(0, 20)),
        pen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.round
          ..strokeJoin = StrokeJoin.round);

    canvas.drawPath(
        path.shift(const Offset(0, 40)),
        pen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.square
          ..strokeJoin = StrokeJoin.miter);

  final path2 = Path();
  path2.moveTo(20, 220); 
  path2.lineTo(50, 180);
  path2.lineTo(70, 220); 
  path2.lineTo(90, 180);
  path2.lineTo(120, 220);

    canvas.drawPath(
        path2,
        pen
          ..style = PaintingStyle.stroke
          ..strokeWidth = 10
          ..strokeCap = StrokeCap.butt
          ..strokeJoin = StrokeJoin.miter
          ..strokeMiterLimit = 2); //改变为3， 试试看
  }

  @override
  bool shouldRepaint(PathLinePainter oldDelegate) => true;
}
