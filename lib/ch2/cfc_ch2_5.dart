import 'package:flutter/material.dart';
import 'dart:ui' as ui;

class CFCCH25 extends StatefulWidget {
  const CFCCH25({Key? key}) : super(key: key);

  @override
  State<CFCCH25> createState() => _CFCCH25State();
}

class _CFCCH25State extends State<CFCCH25> {
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
                      painter: ShadowPainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

class ShadowPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    drawBadShadows(canvas);

    canvas.translate(0, 100);

    drawGoodShadows(canvas);

    canvas.translate(0, 100);

    drawNeumorphism(canvas);

    canvas.translate(100, 0);

    drawNeumorphism(canvas, true);
  }

  void drawBadShadows(Canvas canvas) {
    Paint pen = Paint()..color = Colors.white;
    Rect rect = const Rect.fromLTWH(10, 10, 80, 80);

    canvas.drawShadow(Path()..addRect(rect), Colors.grey, 5, true);
    canvas.drawRect(rect, pen);

    pen.color = Colors.redAccent;
    Rect circle = const Rect.fromLTWH(100, 10, 80, 80);
    canvas.drawShadow(Path()..addOval(circle), Colors.red, 15, true);
    pen.shader = ui.Gradient.radial(circle.center, 40, [Colors.orangeAccent, Colors.redAccent]);
    canvas.drawRRect(RRect.fromRectAndRadius(circle, const Radius.circular(40)), pen);
  }

  void drawGoodShadows(Canvas canvas) {
    Paint pen = Paint()..color = Colors.white;
    Rect rect = const Rect.fromLTWH(10, 10, 80, 80);
    pen.color = Colors.white;
    SimpleBoxShadow rectShadow = const SimpleBoxShadow(
      color: Colors.black54,
      offset: Offset(-2, -2),
      blurRadius: 5.0,
      spreadRadius: -5,
    );
    canvas.drawRect(rectShadow.toBounds(rect), rectShadow.toPaint());
    canvas.drawRect(rect, pen);

    pen.color = Colors.redAccent;
    Rect circle = const Rect.fromLTWH(100, 10, 80, 80);
    SimpleBoxShadow circleShadow = const SimpleBoxShadow(
      color: Colors.redAccent,
      offset: Offset(0, 0),
      blurRadius: 15.0,
      spreadRadius: -10,
    );
    canvas.drawRRect(
        RRect.fromRectAndRadius(circleShadow.toBounds(circle), const Radius.circular(40)), circleShadow.toPaint());
    pen.shader = ui.Gradient.radial(circle.center, 40, [Colors.orangeAccent, Colors.redAccent]);
    canvas.drawRRect(RRect.fromRectAndRadius(circle, const Radius.circular(40)), pen);
  }

  void drawNeumorphism(Canvas canvas, [bool pressed=false]) {
    Paint pen = Paint()..color = const Color(0xfff0f0f0);
    Rect rect = const Rect.fromLTWH(10, 10, 80, 80);
    RRect rRect = RRect.fromRectAndRadius(rect, const Radius.circular(40));
    Offset offset = const Offset(6, 6);
    double raduis = 6.0;

    SimpleBoxShadow shadow1 = SimpleBoxShadow(
      color: _baseColor(pen.color, pressed?-20:20),
      offset: offset * -1,
      blurRadius: raduis,
      spreadRadius: 0,
    );
    canvas.drawRRect(rRect.shift(offset * -1).inflate(0), shadow1.toPaint());

    SimpleBoxShadow shadow2 = SimpleBoxShadow(
      color: _baseColor(pen.color, pressed?20:-20),
      offset: offset,
      blurRadius: raduis,
      spreadRadius: 0,
    );
    canvas.drawRRect(rRect.shift(offset).inflate(0), shadow2.toPaint());

    canvas.drawRRect(rRect, pen);
  }

  @override
  bool shouldRepaint(ShadowPainter oldDelegate) => true;

  Color _baseColor(Color color, amount) {
    Map colors = {"red": color.red, "green": color.green, "blue": color.blue};
    colors = colors.map((key, value) {
      if (value + amount < 0) return MapEntry(key, 0);
      if (value + amount > 255) return MapEntry(key, 255);
      return MapEntry(key, value + amount);
    });
    return Color.fromRGBO(colors["red"], colors["green"], colors["blue"], 1);
  }
}

class SimpleBoxShadow {
  const SimpleBoxShadow({
    this.color = const Color(0xFF000000),
    this.offset = Offset.zero,
    this.blurRadius = 0.0,
    this.spreadRadius = 0.0,
    this.blurStyle = BlurStyle.normal,
  });

  final Color color;

  final Offset offset;

  final double blurRadius;

  final double spreadRadius;

  final BlurStyle blurStyle;

  Paint toPaint() {
    return Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(blurStyle, convertRadiusToSigma(blurRadius));
  }

  Rect toBounds(dynamic rect) {
    return rect.shift(offset).inflate(spreadRadius);
  }

  double convertRadiusToSigma(double radius) {
    return radius > 0 ? radius * 0.57735 + 0.5 : 0;
  }
}
