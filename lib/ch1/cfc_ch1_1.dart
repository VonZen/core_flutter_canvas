import 'package:flutter/material.dart';

class CFCCH11 extends StatefulWidget {
  const CFCCH11({Key? key}) : super(key: key);

  @override
  State<CFCCH11> createState() => _CFCCH11State();
}

class _CFCCH11State extends State<CFCCH11> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              //CustomPaint: Painter的Widget容器
              child: CustomPaint(
                painter: SimplePainter(),
                foregroundPainter: SimpleForegroundPainter(),
                child: const Center(
                    child: Text(
                  'A simple painter Demo.',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                )),
              ),
            );
          },
        )));
  }
}

//CustomPainter: 画板
class SimplePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = Colors.redAccent);
  }

  @override
  bool shouldRepaint(SimplePainter oldDelegate) => true;
}

class SimpleForegroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, size.height / 2, size.width, size.height / 2),
        Paint()..color = Colors.purple.withOpacity(0.8));
  }

  @override
  bool shouldRepaint(SimpleForegroundPainter oldDelegate) => true;
}
