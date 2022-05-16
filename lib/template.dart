import 'package:flutter/material.dart';

class CFCCHX extends StatefulWidget {
  const CFCCHX({Key? key}) : super(key: key);

  @override
  State<CFCCHX> createState() => _CFCCHXState();
}

class _CFCCHXState extends State<CFCCHX> {
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
                      painter: XPainter(),
                    ),
                  ),
                ),
              ),
            );
          },
        )));
  }
}

class XPainter extends CustomPainter {
  final pen = Paint();

  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(XPainter oldDelegate) => true;
}
