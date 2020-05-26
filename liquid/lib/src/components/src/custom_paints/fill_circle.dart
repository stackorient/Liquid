// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';
import 'package:flutter/rendering.dart';

class DrawFillCircle extends CustomPainter {
  final Color color;
  final double diameter;

  DrawFillCircle({
    @required this.color,
    @required this.diameter,
  })  : assert(diameter != null && !diameter.isNegative),
        assert(color != null);

  @override
  void paint(Canvas canvas, Size size) {
    Paint circle = Paint()..color = color;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = diameter / 2;
    canvas.drawCircle(center, radius, circle);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
