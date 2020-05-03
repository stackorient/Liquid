import 'dart:math' as math;
import 'package:meta/meta.dart';
import 'package:flutter/rendering.dart';

class DrawStrokeCircle extends CustomPainter {
  final Color color;
  final Color background;
  final double diameter;
  final double thickness;
  final double complete;
  final StrokeCap cap;

  DrawStrokeCircle({
    this.background = const Color(0x00000000),
    @required this.color,
    @required this.diameter,
    @required this.thickness,
    @required this.complete,
    this.cap,
  })  : assert(diameter != null && !diameter.isNegative),
        assert(color != null),
        assert(thickness != null && !thickness.isNegative),
        assert(
            diameter > thickness, "Diameter should be greater than thickness"),
        assert(complete != null && complete >= 0.0 && complete <= 1.0);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeCap = cap ?? StrokeCap.square
      ..strokeWidth = thickness;

    Paint strokeBG = Paint()
      ..color = background
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = ((diameter + thickness) / 2);
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi,
      false,
      strokeBG,
    );

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * complete,
      false,
      circle,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
