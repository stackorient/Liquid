import 'package:flutter/widgets.dart';
import 'custom_paints/custom_paints.dart';

///Displays Linear progress indicator [LProgressIndicator].
class LProgressIndicator extends StatelessWidget {
  /// Indicates the amount of progress.
  final double progress;

  /// Add color to the background of the progress indicator.
  final Color background;

  /// Add color to the progress indicator.
  final Color barColor;

  /// Progress indicator width.
  final double width;

  /// Progress indicator height.
  final double height;

  /// Progress indicator border radius.
  final double radius;

  /// Progress indicator bar radius.
  final double barRadius;

  final Widget barChild;

  ///Documentation and example for using Liquid custom progress bars
  ///featuring support for stacked bars, animated backgrounds, and text labels.
  ///
  ///Displays Linear progress indicator [LProgressIndicator].
  ///
  ///Example:
  ///```
  ///...
  ///
  /// LProgressIndicator(
  ///    progress: 0.2,
  ///    barChild: Text(
  ///      "20%",
  ///      style: LiquidTheme.of(context)
  ///          .typographyTheme
  ///          .small
  ///          .withColor(Colors.white),
  ///    ),
  ///  ),
  ///...
  ///```
  ///See:
  /// * [LCircularProgressIndicator]
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

///Displays Circular progress indicator [LCircularProgressIndicator].
class LCircularProgressIndicator extends StatelessWidget {
  /// Indicates the amount of progress.
  final double progress;

  /// Progress indicator background color.
  final Color background;

  /// Progress indicator bar color.
  final Color barColor;

  /// Progress indicator diameter.
  final double diameter;

  /// Progress Bar width.
  final double thickness;

  final StrokeCap cap;
  final Widget child;

  ///Documentation and example for using Liquid custom progress bars
  ///featuring support for stacked bars, animated backgrounds, and text labels.
  ///
  ///Displays Circular progress indicator [LCircularProgressIndicator].
  ///
  ///Example:
  ///```
  ///...
  ///
  ///  LCircularProgressIndicator(
  ///     progress: 0.6,
  ///     diameter: 70.0,
  ///     thickness: 6.0,
  ///     barColor: LiquidTheme.of(context).backgroundColors.primaryColor,
  ///     child: Text(
  ///       "60%",
  ///       style: LiquidTheme.of(context).typographyTheme.small,
  ///     ),
  ///   ),
  ///...
  ///```
  ///See:
  /// * [LProgressIndicator]
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
