import 'package:flutter/material.dart';

class CFCCH13 extends StatefulWidget {
  const CFCCH13({Key? key}) : super(key: key);

  @override
  State<CFCCH13> createState() => _CFCCH13State();
}

class _CFCCH13State extends State<CFCCH13> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return SizedBox(
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              child: GestureDetector(
                onTap: () => debugPrint('Painter onTap'),
                child: FittedBox(
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: CustomPaint(
                      painter: TouchablePainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

class TouchablePainter extends CustomPainter {
  List<Path> paths = [];

  final pen = Paint()..color = Colors.blue;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), pen..color = Colors.black87);

    paths.clear();

    final path1 = Path();
    path1.addRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(0, 0, 50, 50), const Radius.circular(10)));
    paths.add(path1);
    canvas.drawPath(path1, pen..color = Colors.blueAccent);

    final path2 = Path();
    path2.addRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(100, 100, 50, 50), const Radius.circular(10)));
    paths.add(path2);
    canvas.drawPath(path2, pen..color = Colors.yellowAccent);
  }

  @override
  bool? hitTest(Offset position) {
    return paths.any((path) => path.contains(position));
  }

  @override
  bool shouldRepaint(TouchablePainter oldDelegate) => true;
}
