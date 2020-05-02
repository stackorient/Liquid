import 'package:flutter/widgets.dart';
import 'custom_paints/custom_paints.dart';

class LGrowSpinner extends StatefulWidget {
  final double diameter;
  final Color color;
  final CustomPaint _circle;

  LGrowSpinner({
    Key key,
    this.diameter = 25.0,
    this.color = const Color(0xFF000000),
  })  : assert(diameter != null && diameter >= 0),
        assert(color != null),
        _circle = CustomPaint(
          foregroundPainter: DrawFillCircle(color: color, diameter: diameter),
          size: Size.square(diameter),
        ),
        super(key: key);

  @override
  _LGrowSpinnerState createState() => _LGrowSpinnerState();
}

class _LGrowSpinnerState extends State<LGrowSpinner>
    with SingleTickerProviderStateMixin {
  AnimationController _growController;
  TweenSequence _growSequence;

  @override
  void initState() {
    super.initState();
    _growController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    )..repeat();

    _growSequence = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0),
        weight: 0.5,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0),
        weight: 0.5,
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _growController,
      child: FadeTransition(
        opacity: _growSequence.animate(_growController),
        child: widget._circle,
      ),
    );
  }

  @override
  void dispose() {
    _growController.dispose();
    super.dispose();
  }
}

class LSpinner extends StatefulWidget {
  final double diameter;
  final Color color;
  final double thickness;
  final StrokeCap cap;
  final CustomPaint _circle;

  LSpinner({
    Key key,
    this.diameter = 20.0,
    this.thickness = 3.0,
    this.color = const Color(0xFF000000),
    this.cap,
  })  : assert(diameter != null && !diameter.isNegative),
        assert(thickness != null && !thickness.isNegative),
        assert(color != null),
        _circle = CustomPaint(
          foregroundPainter: DrawStrokeCircle(
            color: color,
            diameter: diameter,
            complete: 0.75,
            thickness: thickness,
            cap: cap,
          ),
          size: Size.square(diameter),
        ),
        super(key: key);

  @override
  _LSpinnerState createState() => _LSpinnerState();
}

class _LSpinnerState extends State<LSpinner>
    with SingleTickerProviderStateMixin {
  AnimationController _growController;

  @override
  void initState() {
    super.initState();
    _growController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 750),
    )..repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _growController,
      child: widget._circle,
    );
  }

  @override
  void dispose() {
    _growController.dispose();
    super.dispose();
  }
}

class _LAnimatedSpinner extends AnimatedWidget {
  final double diameter;
  final Color color;

  _LAnimatedSpinner(
      {Key key,
      @required AnimationController controller,
      @required this.diameter,
      @required this.color})
      : super(key: key, listenable: controller);

  Animation<double> get _progress => listenable;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: DrawStrokeCircle(
        color: color,
        diameter: diameter,
        thickness: 10.0,
        complete: _progress.value,
      ),
      size: Size.square(diameter),
    );
  }
}
