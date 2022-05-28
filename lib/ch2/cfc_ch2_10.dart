import 'package:flutter/material.dart';

class CFCCH210 extends StatefulWidget {
  const CFCCH210({Key? key}) : super(key: key);

  @override
  State<CFCCH210> createState() => _CFCCH210State();
}

class _CFCCH210State extends State<CFCCH210> {
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
                      painter: BezierPainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

class BezierPainter extends CustomPainter {
  final pen = Paint()..style = PaintingStyle.stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(50, 50);
    path.conicTo(75, 75, 200, 50, 1); //w=1时，等同于 quadraticBezierTo， W 不同的值有不同的表现，可实现更自由的效果，比如一个平滑的对钩✅，圆角多边形！
    canvas.drawPath(path, pen);

    canvas.translate(0, 10);

    final path2 = Path();
    path2.moveTo(50, 50);
    path2.quadraticBezierTo(75, 75, 200, 50);
    canvas.drawPath(path2, pen);

    canvas.translate(0, 100);
    final path3 = Path();
    path3.moveTo(50, 50);
    path3.cubicTo(115, 15, 110, 150, 200, 80);
    canvas.drawPath(path3, pen);
  }

  @override
  bool shouldRepaint(BezierPainter oldDelegate) => true;
}
