import 'package:flutter/material.dart';

class CFCCH14 extends StatefulWidget {
  const CFCCH14({Key? key}) : super(key: key);

  @override
  State<CFCCH14> createState() => _CFCCH14State();
}

class _CFCCH14State extends State<CFCCH14> {
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
                child: GestureDetector(
                  onTap: () => debugPrint('Painter onTap'),
                  child: FittedBox(
                    child: SizedBox(
                      width: 300,
                      height: 300,
                      child: CustomPaint(
                        painter: GoChessboardPainter(),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

const int boardLineNum = 19;

class GoChessboardPainter extends CustomPainter {
  List<Path> paths = [];

  final pen = Paint();

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), pen..color = const Color(0xfff4cd88));

    double gridItemSize = size.width / (boardLineNum - 1);
    for (var i = 0; i < boardLineNum; i++) {
      //画列
      canvas.save();
      canvas.translate(gridItemSize * i, 0);
      if (i == 0 || i == 18) {
        canvas.drawLine(
            Offset.zero,
            Offset(0, size.height),
            pen
              ..color = Colors.black87
              ..strokeWidth = 1.2);
      } else {
        canvas.drawLine(Offset.zero, Offset(0, size.height), pen..strokeWidth = 0.6);
      }
      canvas.restore();

      //画行
      canvas.save();
      canvas.translate(0, gridItemSize * i);
      canvas.drawLine(Offset.zero, Offset(size.width, 0), pen);
      canvas.restore();
    }

    //画天元
    for (var i = 0; i < 3; i++) {
      for (var j = 0; j < 3; j++) {
        canvas.drawCircle(
            Offset(gridItemSize * 3 + gridItemSize * 6 * i, gridItemSize * 3 + gridItemSize * 6 * j), 2, pen);
      }
    }
  }

  @override
  bool shouldRepaint(GoChessboardPainter oldDelegate) => true;
}
