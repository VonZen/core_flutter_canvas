import 'package:flutter/material.dart';

class CFCCH23 extends StatefulWidget {
  const CFCCH23({Key? key}) : super(key: key);

  @override
  State<CFCCH23> createState() => _CFCCH23State();
}

class _CFCCH23State extends State<CFCCH23> {
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
                      painter: RectPainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

///
///绘制矩形
///
class RectPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //绘制矩形: 填充模式，默认 PaintingStyle.fill;

    drawRects(canvas, Paint());

    canvas.translate(0, 100);
    //绘制矩形: 描边模式
    drawRects(canvas, Paint()..style = PaintingStyle.stroke);

    canvas.translate(0, 100);
    //绘制矩形: 描边模式，自定义样式
    drawRects(
        canvas,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 5.0);
  }

  void drawRects(Canvas canvas, Paint pen) {
    canvas.drawRect(const Rect.fromLTWH(10, 10, 80, 80), pen);

    canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(100, 10, 80, 80), const Radius.circular(10)), pen);

    canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(200, 10, 80, 80), const Radius.elliptical(20, 40)), pen);

    canvas.drawRRect(
        RRect.fromRectAndRadius(const Rect.fromLTWH(300, 20, 80, 60), const Radius.elliptical(60, 30)), pen);
  }

  @override
  bool shouldRepaint(RectPainter oldDelegate) => false;
}
