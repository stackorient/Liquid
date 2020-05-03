import 'package:flutter/widgets.dart';
import 'custom_paints/custom_paints.dart';

class LProgressIndicator extends StatelessWidget {
  final double progress;
  final Color background;
  final Color barColor;
  final double width;
  final double height;
  final double radius;
  final double barRadius;
  final Widget barChild;

  const LProgressIndicator({
    Key key,
    this.progress = 0.0,
    this.background = const Color(0xFFe9ecef),
    this.barColor = const Color(0xFF000000),
    this.width,
    this.height = 16.0,
    this.radius = 2.5,
    this.barRadius,
    this.barChild,
  })  : assert(progress != null && progress >= 0 && progress <= 1),
        assert(background != null),
        assert(barColor != null),
        assert(height != null && height >= 0),
        assert(radius != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return width != null
        ? getBar(width)
        : LayoutBuilder(
            builder: (context, constraints) {
              return getBar(constraints.maxWidth);
            },
          );
  }

  Widget getBar(double barWidth) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        alignment: Alignment.centerLeft,
        height: height,
        width: barWidth,
        color: background,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 450),
          alignment: Alignment.center,
          height: height,
          width: barWidth * progress,
          decoration: BoxDecoration(
            color: barColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(radius),
              bottomLeft: Radius.circular(radius),
              topRight: Radius.circular(barRadius ?? radius),
              bottomRight: Radius.circular(barRadius ?? radius),
            ),
          ),
          child: barChild,
        ),
      ),
    );
  }
}

class LCircularProgressIndicator extends StatelessWidget {
  final double progress;
  final Color background;
  final Color barColor;
  final double diameter;
  final double thickness;
  final StrokeCap cap;
  final Widget child;

  const LCircularProgressIndicator({
    Key key,
    this.progress = 0.0,
    this.background = const Color(0xFFe9ecef),
    this.barColor = const Color(0xFF000000),
    this.diameter = 30.0,
    this.thickness = 3.0,
    this.cap,
    this.child,
  })  : assert(progress != null && progress >= 0 && progress <= 1),
        assert(background != null),
        assert(barColor != null),
        assert(thickness != null && thickness >= 0),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(diameter),
      foregroundPainter: DrawStrokeCircle(
        complete: progress,
        background: background,
        color: barColor,
        thickness: thickness,
        diameter: diameter,
        cap: cap,
      ),
      child: Container(
        width: diameter,
        height: diameter,
        alignment: Alignment.center,
        child: child,
      ),
    );
  }
}
