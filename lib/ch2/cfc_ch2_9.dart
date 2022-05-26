import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

class CFCCH29 extends StatefulWidget {
  const CFCCH29({Key? key}) : super(key: key);

  @override
  State<CFCCH29> createState() => _CFCCH29State();
}

class _CFCCH29State extends State<CFCCH29> {
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
                      painter: ArcPainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

class ArcPainter extends CustomPainter {
  final pen = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = 5
    ..strokeJoin = StrokeJoin.round
    ..strokeCap = StrokeCap.round;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPoints(PointMode.points, [const Offset(100, 100)], pen);
    final path = Path();
    //1
    path.addArc(Rect.fromCenter(center: const Offset(100, 100), width: 50, height: 50), 0, -pi);
    //2
    path.arcTo(Rect.fromCenter(center: const Offset(150, 150), width: 50, height: 50), 0, pi, true /* false */);

    //3 : 线的平滑夹角，圆角边框等 TODO: 做个控制参数的Demo
    path.moveTo(40, 300);
    path.lineTo(50, 250);
    path.arcToPoint(const Offset(70, 250), 
    radius: const Radius.circular(116), //0, 0~10，1
    rotation: pi,
    largeArc: true,//false
    clockwise: true,
    ); //曲线链接端点
    path.moveTo(70, 250);
    path.lineTo(80, 300);
    
    canvas.drawPath(path, pen);
  }

  @override
  bool shouldRepaint(ArcPainter oldDelegate) => true;
}
