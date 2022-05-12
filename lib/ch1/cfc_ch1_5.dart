import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CFCCH15 extends StatefulWidget {
  const CFCCH15({Key? key}) : super(key: key);

  @override
  State<CFCCH15> createState() => _CFCCH15State();
}

class _CFCCH15State extends State<CFCCH15> {
  late GoChessboardPainter painter;
  Uint8List? _imgData;
  @override
  void initState() {
    super.initState();
    painter = GoChessboardPainter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Center(child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              padding: const EdgeInsets.all(6),
              child: Column(
                children: [
                  SizedBox(
                    width: constraints.maxWidth / 2,
                    height: constraints.maxHeight / 2,
                    child: GestureDetector(
                      onTap: () => debugPrint('Painter onTap'),
                      child: FittedBox(
                        child: SizedBox(
                          width: 300,
                          height: 300,
                          child: CustomPaint(
                            painter: painter,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  IconButton(
                    onPressed: () async {
                      ByteData? data = await painter.saveToImageData(const Size(300, 300));
                      _imgData = data!.buffer.asUint8List();
                      setState(() {});
                    },
                    icon: const Icon(Icons.save),
                    iconSize: 44,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (_imgData != null)
                    Image.memory(
                      _imgData!,
                      width: 100,
                      height: 100,
                    ),
                ],
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

  Future<ByteData?> saveToImageData(Size size) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    paint(Canvas(recorder), size);
    ui.Picture picture = recorder.endRecording();

    ui.Image image = await picture.toImage(size.width.toInt(), size.height.toInt());
    return image.toByteData(format: ui.ImageByteFormat.png);
  }

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
