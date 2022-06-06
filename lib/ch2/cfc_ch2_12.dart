import 'dart:math';

import 'package:flutter/material.dart';

class CFCCH212 extends StatefulWidget {
  const CFCCH212({Key? key}) : super(key: key);

  @override
  State<CFCCH212> createState() => _CFCCH212State();
}

class _CFCCH212State extends State<CFCCH212> {
  final ComponentManager manager = ComponentManager();

  @override
  void initState() {
    super.initState();

    manager.add(PolygonComponent(center: const Offset(50, 50), radius: 50, sides: 3, vertexStyle: VertexStyle.round));

    manager.add(PolygonComponent(center: const Offset(150, 50), radius: 30, sides: 4, color: Colors.redAccent));

    manager.add(PolygonComponent(
        center: const Offset(50, 150), radius: 30, sides: 5, color: Colors.pinkAccent, vertexStyle: VertexStyle.round));
  }

  Offset startPoint = Offset.zero;

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
                    child: GestureDetector(
                      onPanStart: (details) {
                        startPoint = details.localPosition;
                        manager.onMoveStart(startPoint);
                        setState(() {});
                      },
                      onPanUpdate: (details) {
                        manager.move(details.delta);
                        setState(() {});
                      },
                      onPanEnd: (details) {
                        manager.onMoveEnd();
                        setState(() {});
                      },
                      child: CustomPaint(
                        painter: TouchablePainter(componentManager: manager),
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

class TouchablePainter extends CustomPainter {
  final pen = Paint();

  late ComponentManager componentManager;

  TouchablePainter({required this.componentManager});

  @override
  void paint(Canvas canvas, Size size) { 
    for (var element in componentManager.components) {
      element.paint(canvas);
    }
  }

  @override
  bool shouldRepaint(TouchablePainter oldDelegate) => true;

  @override
  bool? hitTest(Offset position) {
    return componentManager.containPoint(position);
  }
}

class ComponentManager {
  List<PolygonComponent> components = [];

  void add(PolygonComponent component) {
    components.add(component);
  }

  void remove(PolygonComponent component) {
    components.remove(component);
  }

  void clear() {
    components.clear();
  }

  PolygonComponent? willToMoveItem;
  bool containPoint(Offset point) {
    for (var item in components) {
      if (item.containPoint(point)) {
        return true;
      }
    }
    return false;
  }

  void onMoveStart(Offset point) {
    for (var item in components.reversed) {
      if (item.containPoint(point)) {
        willToMoveItem = item;
        willToMoveItem?.running = true;
        break;
      }
    }
  }

  void onMoveEnd() {
    willToMoveItem?.running = false;
    willToMoveItem = null;
  }

  void move(Offset offset) {
    willToMoveItem?.move(offset);
  }
}

enum VertexStyle {
  normal,
  round,
}

class PolygonComponent {
  final double radius;
  final int sides;
  final double startAngle;
  final PaintingStyle paintingStyle;
  final Color color;
  final VertexStyle vertexStyle;

  Offset center;
  var path = Path();
  bool running = false;

  PolygonComponent(
      {required this.center,
      required this.radius,
      required this.sides,
      this.startAngle = 0,
      this.paintingStyle = PaintingStyle.fill,
      this.color = Colors.black,
      this.vertexStyle = VertexStyle.normal})
      : assert(sides >= 3, 'sides must be greater than or equal to 3');

  void paint(Canvas canvas) {
    final vertexes = _getVertexes();

    switch (vertexStyle) {
      case VertexStyle.normal:
        {
          path.moveTo(vertexes.first.dx, vertexes.first.dy);
          for (var i = 1; i < sides; i++) {
            path.lineTo(vertexes[i].dx, vertexes[i].dy);
          }
          path.close();
        }
        break;
      case VertexStyle.round:
        {
          Offset firstPoint = _getMidPoint(vertexes.first, vertexes.last);
          Offset secondPoint = _getMidPoint(vertexes.first, vertexes[1]);
          path.moveTo(firstPoint.dx, firstPoint.dy);
          for (var i = 0; i < sides; i++) {
            path.conicTo(vertexes[i].dx, vertexes[i].dy, secondPoint.dx, secondPoint.dy, 10);
            firstPoint = secondPoint;
            secondPoint = _getMidPoint(vertexes[(i + 1) % sides], vertexes[(i + 2) % sides]);
          }
        }
        break;
    }

    canvas.save();
    canvas.drawPath(
        path,
        Paint()
          ..strokeWidth = 2
          ..style = paintingStyle
          ..color = color.withOpacity(running?0.5:1));
    canvas.restore();
  }

  void move(Offset offset) {
    path.reset();
    center += offset;
  }

  bool containPoint(Offset point) {
    return path.contains(point);
  }

  List<Offset> _getVertexes() {
    List<Offset> vertexes = [];
    double angle = startAngle;
    double angleOne = (pi * 2) / sides;
    for (var i = 0; i < sides; i++) {
      vertexes.add(Offset(center.dx + sin(angle) * radius, center.dy - cos(angle) * radius));
      angle += angleOne;
    }
    return vertexes;
  }

  Offset _getMidPoint(Offset point1, Offset point2) {
    Offset temp = point1 + point2;
    return Offset(temp.dx / 2, temp.dy / 2);
  }
}
