import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CFCCH211 extends StatefulWidget {
  const CFCCH211({Key? key}) : super(key: key);

  @override
  State<CFCCH211> createState() => _CFCCH211State();
}

class _CFCCH211State extends State<CFCCH211> {
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
                      painter: PolygonPainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

class PolygonPainter extends CustomPainter {
  final pen = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round;

  @override
  void paint(Canvas canvas, Size size) {
    // canvas.translate(size.width / 2, size.height / 2);
    Offset center = Offset(size.width / 2, size.height / 2);
    canvas.drawPoints(PointMode.points, [center], pen);

    final path = Path();
    int sides = 10;
    var points = getPoints(center, 150, sides, 0);
    // path.moveTo(points.first.dx, points.first.dy);
    // for (var i = 1; i < sides; i++) {
    //   path.lineTo(points[i].dx, points[i].dy);
    // }
    // path.close();

    Offset firstPoint = getMidPoint(points.first, points.last);
    Offset secondPoint = getMidPoint(points.first, points[1]); 
    path.moveTo(firstPoint.dx, firstPoint.dy);
    for (var i = 0; i < sides; i++) {
      path.conicTo(points[i].dx, points[i].dy, secondPoint.dx, secondPoint.dy, 10);
      firstPoint = secondPoint;
      secondPoint = getMidPoint(points[(i + 1) % sides], points[(i + 2) % sides]);
    }

    canvas.drawPath(path, pen);
  }

  List<Offset> getPoints(Offset center, double radius, int sides, double? startAngle) {
    List<Offset> points = [];
    double angle = startAngle ?? 0;
    double angleOne = (pi * 2) / sides;
    for (var i = 0; i < sides; i++) {
      points.add(Offset(center.dx + sin(angle) * radius, center.dy - cos(angle) * radius));
      angle += angleOne;
    }
    return points;
  }

  Offset getMidPoint(Offset point1, Offset point2) {
    Offset temp = point1 + point2;
    return Offset(temp.dx / 2, temp.dy / 2);
  }

  @override
  bool shouldRepaint(PolygonPainter oldDelegate) => true;
}
