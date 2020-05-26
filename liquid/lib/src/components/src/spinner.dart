// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/widgets.dart';
import 'custom_paints/custom_paints.dart';

/// Repeatedly growing spinner.
///
/// If you want a fancy  border spinner, switch to the grow spinner.
/// While it doesn’t technically spin, it does repeatedly grow!
///
class LGrowSpinner extends StatefulWidget {
  final double diameter;
  final Color color;
  final CustomPaint _circle;

  ///
  /// Repeatedly growing spinner.
  ///
  /// If you want a fancy border spinner, switch to the grow spinner.
  /// While it doesn’t technically spin, it does repeatedly grow!
  ///
  /// Example:
  ///
  /// ```
  /// ...
  ///
  /// LGrowSpinner(
  ///     diameter: 50.0,
  ///   ),
  ///
  /// ...
  /// ```
  /// See:
  ///   * [LSpinner]
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

/// Liquid [LSpinner] can be used to show the loading state in your projects
///
/// Use [LSpinner] for lightweight loading indicator.
class LSpinner extends StatefulWidget {
  /// `LSpinner` width.
  final double diameter;

  /// Add color to the [LSpinner]
  final Color color;

  ///
  final double thickness;
  final StrokeCap cap;
  final CustomPaint _circle;

  /// Liquid [LSpinner] can be used to show the loading state in your projects
  ///
  /// Use [LSpinner] for lightweight loading indicator.
  ///
  /// Example:
  ///
  /// ```
  /// ...
  ///  LSpinner(
  ///    diameter: 50.0,
  ///    thickness: 6.0,
  ///    cap: StrokeCap.round,
  ///  ),
  ///
  /// ...
  /// ```
  ///
  /// See:
  /// * [LGrowSpinner]
  ///
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
