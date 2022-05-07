import 'dart:math';

import 'package:flutter/material.dart';

const romanNumeralList = ['XII', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI'];

class CFCCH12 extends StatefulWidget {
  const CFCCH12({Key? key}) : super(key: key);

  @override
  State<CFCCH12> createState() => _CFCCH12State();
}

class _CFCCH12State extends State<CFCCH12> with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    controller.repeat();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: FittedBox(
                child: SizedBox(
                  width: 300,
                  height: 300,
                  child: CustomPaint(
                    painter: ClockPainter(controller),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

///时钟示例
///drawRRect
///drawCircle
///save
///restore
///translate
///rotate
///drawLine
class ClockPainter extends CustomPainter {
  final Animation<double> value;

  const ClockPainter(this.value) : super(repaint: value);

  final angleByOneTick = pi * 2 / 60;
  final hourTickMarkLength = 10.0;
  final minuteTickMarkLength = 5.0;
  final hourTickMarkWidth = 3.0;
  final minuteTickMarkWidth = 1.5;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()..strokeCap = StrokeCap.round;
    final radius = size.width / 2 - 10;
    //1. 绘制底色
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(32)),
        paint..color = Colors.black87);
    //2. 绘制表盘
    canvas.drawCircle(Offset(size.width / 2, size.width / 2), radius, paint..color = Colors.white);
    //3. 绘制刻度&文字
    canvas.save();
    canvas.translate(radius + 10, radius + 10);
    var textPainter = TextPainter(
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    var textStyle = const TextStyle(
        fontFamily: 'Times New Roman', fontWeight: FontWeight.bold, fontSize: 16.0, color: Colors.black);
    for (var i = 0; i < 60; i++) {
      final tickLength = i % 5 == 0 ? hourTickMarkLength : minuteTickMarkLength;
      paint.strokeWidth = i % 5 == 0 ? hourTickMarkWidth : minuteTickMarkWidth;
      canvas.drawLine(Offset(0.0, -radius), Offset(0.0, -radius + tickLength), paint..color = Colors.black87);

      //draw text
      if (i % 5 == 0) {
        canvas.save();
        canvas.translate(0.0, -radius + 25.0);
        textPainter.text = TextSpan(text: romanNumeralList[i ~/ 5], style: textStyle);
        canvas.rotate(-angleByOneTick * i);
        textPainter.layout();
        textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
        canvas.restore();
      }

      canvas.rotate(angleByOneTick);
    }

    canvas.restore();
    //4. 绘制指针
    DateTime now = DateTime.now();
    canvas.save();
    canvas.translate(radius + 10, radius + 10);

    canvas.drawCircle(Offset.zero, 5, paint);

    canvas.save();
    canvas.rotate(angleByOneTick * 5 * now.hour);
    canvas.drawLine(
        const Offset(0.0, -5),
        Offset(0.0, -radius * 0.6),
        paint
          ..color = Colors.black87
          ..strokeWidth = 4);
    canvas.restore();

    canvas.save();
    canvas.rotate(angleByOneTick * now.minute);
    canvas.drawLine(
        const Offset(0.0, -5),
        Offset(0.0, -radius * 0.82),
        paint
          ..color = Colors.black87
          ..strokeWidth = 3);
    canvas.restore();

    canvas.save();
    canvas.rotate(angleByOneTick * now.second);
    canvas.drawLine(
        const Offset(0.0, -5),
        Offset(0.0, -radius * 0.95),
        paint
          ..color = Colors.orangeAccent
          ..strokeWidth = 1);
    canvas.restore();

    canvas.restore();
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) => true;
}
