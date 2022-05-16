import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CFCCH24 extends StatefulWidget {
  const CFCCH24({Key? key}) : super(key: key);

  @override
  State<CFCCH24> createState() => _CFCCH24State();
}

class _CFCCH24State extends State<CFCCH24> {
  ui.Image? imageSource;
  @override
  void initState() {
    super.initState();

    loadImage();
  }

  void loadImage() async {
    ByteData byteData = await rootBundle.load('assets/images/cute_cat.png');
    ui.Codec codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List(), targetWidth: 80, targetHeight: 80);
    ui.FrameInfo frameInfo = await codec.getNextFrame();
    imageSource = frameInfo.image;
    setState(() {});
  }

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
                      painter: ColorPainter(imageSource: imageSource),
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
///定义颜色、渐变色、图案
///
class ColorPainter extends CustomPainter {
  ui.Image? imageSource;

  ColorPainter({this.imageSource}) : super();

  @override
  void paint(Canvas canvas, Size size) {
    // drawRects(canvas, Paint()..color = Colors.redAccent);

    drawWithPaintColor(canvas);

    canvas.translate(0, 100);

    drawWithGradientColor(canvas);

    canvas.translate(0, 100);

    drawWithImage(canvas);
  }

  void drawWithPaintColor(Canvas canvas) {
    Paint pen = Paint();
    pen.color = Colors.redAccent;
    canvas.drawRRect(RRect.fromRectAndRadius(const Rect.fromLTWH(10, 10, 80, 80), const Radius.circular(10)), pen);
  }

  void drawWithGradientColor(Canvas canvas) {
    Paint pen = Paint();

    // 线性渐变, 适用于 UI背景
    const rect1 = Rect.fromLTWH(10, 10, 80, 80);
    pen.shader = ui.Gradient.linear(rect1.topLeft, rect1.bottomRight, [Colors.redAccent, Colors.pinkAccent]);
    canvas.drawRRect(RRect.fromRectAndRadius(rect1, const Radius.circular(10)), pen);

    // 放射型渐变，适用于球形之类的物体上
    const rect2 = Rect.fromLTWH(100, 10, 80, 80);
    pen.shader = ui.Gradient.radial(rect2.center, 40, [Colors.orangeAccent, Colors.redAccent]);
    canvas.drawRRect(RRect.fromRectAndRadius(rect2, const Radius.circular(40)), pen);

    // 扫描式渐变, 配合 Path 使用，适用于创建环状的进度条
    const rect3 = Rect.fromLTWH(200, 10, 80, 80);
    // pen.style = PaintingStyle.stroke;
    // pen.strokeWidth = 10;
    pen.shader = ui.Gradient.sweep(
      rect3.center,
      [Colors.orangeAccent, Colors.redAccent],
    );
    canvas.drawRRect(RRect.fromRectAndRadius(rect3, const Radius.circular(40)), pen);
  }

  void drawWithImage(Canvas canvas) {
    if (imageSource == null) return;

    
    Paint pen = Paint();  
    // https://medium.com/flutter-community/advanced-flutter-matrix4-and-perspective-transformations-a79404a0d828
    const rect1 = Rect.fromLTWH(10, 10, 80, 80);
    Matrix4 matrix1 = Matrix4.identity()..setTranslationRaw(rect1.left, rect1.top, 0);
    pen.shader = ui.ImageShader(imageSource!, TileMode.clamp, TileMode.clamp, matrix1.storage);
    
    canvas.drawRRect(RRect.fromRectAndRadius(rect1, const Radius.circular(10)), pen);

    const rect2 = Rect.fromLTWH(100, 10, 80*3, 80);
    Matrix4 matrix2 = Matrix4.identity()..setTranslationRaw(rect2.left, rect2.top, 0);
    // 水平方向重复填充
    pen.shader = ui.ImageShader(imageSource!, TileMode.repeated, TileMode.clamp, matrix2.storage);
    
    canvas.drawRRect(RRect.fromRectAndRadius(rect2, const Radius.circular(10)), pen);
  }

  @override
  bool shouldRepaint(ColorPainter oldDelegate) => false;
}
