import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CFCCH26 extends StatefulWidget {
  const CFCCH26({Key? key}) : super(key: key);

  @override
  State<CFCCH26> createState() => _CFCCH26State();
}

class _CFCCH26State extends State<CFCCH26> {
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
                      painter: FastGraphPainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

class FastGraphPainter extends CustomPainter {
  final pen = Paint()
    ..strokeWidth = 5
    // ..style = PaintingStyle.fill
    // ..strokeCap = StrokeCap.butt;
    ..strokeCap = StrokeCap.round;
  // ..strokeCap = StrokeCap.square;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    //绘点成点
    drawPoints(canvas, PointMode.points);
    canvas.translate(100, 0);
    //绘点成线：两点一对，绘制一条线，落单的点
    drawPoints(canvas, PointMode.lines);
    canvas.translate(100, 0);
    //绘点成面：
    drawPoints(canvas, PointMode.polygon);
    canvas.restore();

    canvas.translate(0, 100);
    drawLines(canvas, size);
    canvas.translate(0, 20);
    drawVertices(canvas);
    canvas.translate(0, 50);
    drawFaces(canvas);
  }

  void drawPoints(Canvas canvas, PointMode mode) {
    canvas.save();
    canvas.drawPoints(
        mode,
        [
          const Offset(10, 10),
        ],
        pen);
    canvas.translate(0, 20);
    canvas.drawPoints(
        mode,
        [
          const Offset(10, 10),
          const Offset(30, 10),
        ],
        pen);
    canvas.translate(0, 20);
    canvas.drawPoints(
        mode,
        [
          const Offset(10, 10),
          const Offset(70, 10),
          const Offset(40, 40),
          // const Offset(10, 10),
        ],
        pen);
    canvas.restore();
  }

  void drawLines(Canvas canvas, Size size) {
    canvas.drawLine(const Offset(0, 0), Offset(size.width, 0), pen);
  }

  void drawVertices(Canvas canvas) {
    canvas.save();
    //多面体
    // 相关知识：https://docs.microsoft.com/en-us/windows/win32/direct3d9/primitives
    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [
          const Offset(10, 10),
          const Offset(70, 10),
          const Offset(40, 40),
        ], colors: [
          Colors.red,
          Colors.green,
          Colors.blue
        ]),
        BlendMode.clear,
        pen);
    canvas.translate(110, 0);

    canvas.drawVertices(
        Vertices(VertexMode.triangleFan, [
          const Offset(10, 10),
          const Offset(70, 10),
          const Offset(70, 40),
          const Offset(10, 40),
        ], colors: [
          Colors.red,
          Colors.green,
          Colors.yellow,
          Colors.purple
        ]),
        BlendMode.srcOver,
        pen);

    canvas.restore();
  }

  void drawFaces(Canvas canvas) {
    //DRRect
    canvas.save();
    canvas.drawDRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(10, 10, 50, 50), const Radius.circular(10)),
        RRect.fromRectAndRadius(const Rect.fromLTWH(20, 20, 30, 30), const Radius.circular(15)),
        Paint()
          ..strokeWidth = 5
          ..style = PaintingStyle.stroke);

    canvas.translate(100, 0);
    canvas.drawDRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(10, 10, 50, 50), const Radius.circular(10)),
        RRect.fromRectAndRadius(const Rect.fromLTWH(20, 20, 30, 30), const Radius.circular(15)),
        Paint()
          ..strokeWidth = 5
          ..style = PaintingStyle.fill);
    canvas.restore();

    //ARC
    canvas.save();
    canvas.translate(0, 50);
    Rect arcRect = const Rect.fromLTWH(10, 10, 50, 50);

    canvas.drawArc(arcRect, 0, pi / 2, true, pen);
    canvas.drawArc(arcRect.shift(const Offset(50, 0)), 0, pi / 2, false, pen);

    canvas.drawArc(
        arcRect.shift(const Offset(100, 0)),
        0,
        pi / 2,
        true,
        pen
          ..style = PaintingStyle.stroke
          ..strokeJoin = StrokeJoin.round);
    canvas.drawArc(arcRect.shift(const Offset(150, 0)), 0, pi / 2, false, pen..style = PaintingStyle.stroke);

    canvas.restore();

    //Oval Circle
    canvas.save();
    canvas.translate(0, 120);
    canvas.drawOval(const Rect.fromLTWH(10, 10, 150, 50), pen);
    canvas.translate(160, 0);
    canvas.drawOval(const Rect.fromLTWH(10, 10, 50, 50), pen);
    canvas.translate(50, 0);
    canvas.drawCircle(const Offset(40, 40), 20, pen..color = Colors.redAccent);
    canvas.restore();
  }

  @override
  bool shouldRepaint(FastGraphPainter oldDelegate) => true;
}
