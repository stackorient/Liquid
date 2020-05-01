import 'package:flutter/widgets.dart';

import 'liquid_layout.dart';

class LBoxDimension {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  /// used in [LBox] for `height` and `width` values
  /// on each [LBreakPoint]
  const LBoxDimension({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });

  factory LBoxDimension.all(double value) => LBoxDimension(
        xs: value,
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxDimension.aboveXS(double value) => LBoxDimension(
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxDimension.aboveSM(double value) => LBoxDimension(
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxDimension.aboveMD(double value) => LBoxDimension(
        lg: value,
        xl: value,
      );

  factory LBoxDimension.belowXL(double value) => LBoxDimension(
        xs: value,
        sm: value,
        md: value,
        lg: value,
      );
  factory LBoxDimension.belowLG(double value) => LBoxDimension(
        xs: value,
        sm: value,
        md: value,
      );

  factory LBoxDimension.belowMD(double value) => LBoxDimension(
        xs: value,
        sm: value,
      );
}

class LBoxEdgeInsets {
  final EdgeInsetsGeometry xs;
  final EdgeInsetsGeometry sm;
  final EdgeInsetsGeometry md;
  final EdgeInsetsGeometry lg;
  final EdgeInsetsGeometry xl;

  /// used in [LBox] to provide `padding` or `margin` values
  /// on each [LBreakPoint]
  const LBoxEdgeInsets({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });

  factory LBoxEdgeInsets.all(EdgeInsetsGeometry value) => LBoxEdgeInsets(
        xs: value,
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxEdgeInsets.aboveXS(EdgeInsetsGeometry value) => LBoxEdgeInsets(
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxEdgeInsets.aboveSM(EdgeInsetsGeometry value) => LBoxEdgeInsets(
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxEdgeInsets.aboveMD(EdgeInsetsGeometry value) => LBoxEdgeInsets(
        lg: value,
        xl: value,
      );

  factory LBoxEdgeInsets.belowXL(EdgeInsetsGeometry value) => LBoxEdgeInsets(
        xs: value,
        sm: value,
        md: value,
        lg: value,
      );
  factory LBoxEdgeInsets.belowLG(EdgeInsetsGeometry value) => LBoxEdgeInsets(
        xs: value,
        sm: value,
        md: value,
      );

  factory LBoxEdgeInsets.belowMD(EdgeInsetsGeometry value) => LBoxEdgeInsets(
        xs: value,
        sm: value,
      );
}

class LBoxAlignment {
  final AlignmentGeometry xs;
  final AlignmentGeometry sm;
  final AlignmentGeometry md;
  final AlignmentGeometry lg;
  final AlignmentGeometry xl;

  /// used in [LBox] to provide `alignment` to `child`
  /// on each [LBreakPoint]
  const LBoxAlignment({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });

  factory LBoxAlignment.all(AlignmentGeometry value) => LBoxAlignment(
        xs: value,
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxAlignment.aboveXS(AlignmentGeometry value) => LBoxAlignment(
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxAlignment.aboveSM(AlignmentGeometry value) => LBoxAlignment(
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxAlignment.aboveMD(AlignmentGeometry value) => LBoxAlignment(
        lg: value,
        xl: value,
      );

  factory LBoxAlignment.belowXL(AlignmentGeometry value) => LBoxAlignment(
        xs: value,
        sm: value,
        md: value,
        lg: value,
      );
  factory LBoxAlignment.belowLG(AlignmentGeometry value) => LBoxAlignment(
        xs: value,
        sm: value,
        md: value,
      );

  factory LBoxAlignment.belowMD(AlignmentGeometry value) => LBoxAlignment(
        xs: value,
        sm: value,
      );
}

class LBoxDecoration {
  final Decoration xs;
  final Decoration sm;
  final Decoration md;
  final Decoration lg;
  final Decoration xl;

  /// used in [LBox] to provide `decoration` around `child`
  /// on each [LBreakPoint]
  const LBoxDecoration({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });

  factory LBoxDecoration.all(Decoration value) => LBoxDecoration(
        xs: value,
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxDecoration.aboveXS(Decoration value) => LBoxDecoration(
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxDecoration.aboveSM(Decoration value) => LBoxDecoration(
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxDecoration.aboveMD(Decoration value) => LBoxDecoration(
        lg: value,
        xl: value,
      );

  factory LBoxDecoration.belowXL(Decoration value) => LBoxDecoration(
        xs: value,
        sm: value,
        md: value,
        lg: value,
      );
  factory LBoxDecoration.belowLG(Decoration value) => LBoxDecoration(
        xs: value,
        sm: value,
        md: value,
      );

  factory LBoxDecoration.belowMD(Decoration value) => LBoxDecoration(
        xs: value,
        sm: value,
      );
}

class LBox extends StatelessWidget {
  /// The `height` value of the box on each [LBreakPoint]
  final LBoxDimension height;

  /// The `width` value of the box on each [LBreakPoint]
  final LBoxDimension width;

  /// The `visiblity` of the box on each [LBreakPoint]
  ///
  /// [LBox] will only render `child` if its visiblity is true for current screen BreakPoint.
  ///
  /// default: true (for all breakpoint)
  ///
  /// example:
  /// Image will be hidden in **xs** and **sm** [LBreakPoint]
  /// ```dart
  /// ...
  /// child: LBox(
  ///   visibility: LBoxVisibility(
  ///     xs: false,
  ///     sm: false,
  ///   ),
  ///   child:
  ///       Image.network("https://source.unsplash.com/random/"),
  /// ),
  /// ...
  ///
  /// ```
  final LBoxVisibility visibility;

  /// The `padding` around the `child` at each breakpoint
  ///
  ///
  /// example:
  /// Image will have different padding in **xs** and **md** [LBreakPoint]
  /// ```dart
  /// ...
  /// child: LBox(
  ///   padding: LBoxEdgeInsets(
  ///     xs: const EdgeInsets.all(2.0),
  ///     md: const EdgeInsets.all(15.0),
  ///   ),
  ///   child:
  ///       Image.network("https://source.unsplash.com/random/"),
  /// ),
  /// ...
  ///
  /// ```
  final LBoxEdgeInsets padding;

  /// The `margin` around the `child` at each breakpoint
  ///
  ///
  /// example:
  /// Image will have different margin in **xs** and **md** [LBreakPoint]
  /// ```dart
  /// ...
  /// child: LBox(
  ///   margin: LBoxEdgeInsets(
  ///     xs: const EdgeInsets.all(2.0),
  ///     md: const EdgeInsets.all(15.0),
  ///   ),
  ///   child:
  ///       Image.network("https://source.unsplash.com/random/"),
  /// ),
  /// ...
  ///
  /// ```
  final LBoxEdgeInsets margin;

  /// Align the [child] within the box on each [LBreakPoint].
  ///
  /// If non-null, the box will expand to fill its parent and position its
  /// child within itself according to the given value. If the incoming
  /// constraints are unbounded, then the child will be shrink-wrapped instead.
  ///
  /// Ignored if [child] is null.
  ///
  /// example:
  /// Image will have different alignment in **xs** and **lg** [LBreakPoint]
  /// ```dart
  /// ...
  /// child: LBox(
  ///   alignment: LBoxAlignment(
  ///     xs: Alignment.centerLeft,
  ///     lg: Alignment.bottomRight,
  ///   ),
  ///   height: LBoxDimension(
  ///     xs: 250.0,
  ///     sm: 280.0,
  ///     md: 350.0,
  ///     lg: 450.0,
  ///     xl: 500.0
  ///   ),
  ///   width: LBoxDimension(
  ///     xs: 250.0,
  ///     sm: 280.0,
  ///     md: 350.0,
  ///     lg: 450.0,
  ///     xl: 500.0
  ///   ),
  ///   child:
  ///       Image.network("https://source.unsplash.com/random/", height: 100.0, width: 100.0),
  /// ),
  /// ...
  ///
  /// ```
  final LBoxAlignment alignment;

  /// The decoration to paint behind the [child] on each [LBreakPoint]
  ///
  /// example:
  /// Box with different background color in **xs**, **sm** and **md** [LBreakPoint]
  /// ```dart
  /// ...
  /// child: LBox(
  ///   decoration: LBoxDecoration(
  ///     xs: const BoxDecoration(color: Colors.blue),
  ///     sm: const BoxDecoration(color: Colors.pink),
  ///     md: const BoxDecoration(color: Colors.green),
  ///   ),
  ///   child:
  ///       Image.network("https://source.unsplash.com/random/", height: 100.0, width: 100.0),
  /// ),
  /// ...
  ///
  /// ```
  final LBoxDecoration decoration;

  /// when `true` [LBox] will use Screen width instead of Parent Width
  /// for determining active [LBreakPoint]
  ///
  /// default: `true`
  ///
  /// See also:
  ///
  ///  * [LResponsiveBuilder], a class which used by [LBox]
  ///    to build its child on each [BreakPoint].
  ///
  final bool useMediaQuery;

  /// The [child] contained by the [LBox].
  ///
  /// {@macro flutter.widgets.child}
  final Widget child;

  /// Creates a widget that combines common painting, positioning, and sizing widgets
  /// according to [LBreakPoint]
  ///
  /// example:
  /// ```dart
  /// ...
  /// child: LBox(
  ///   visibility: LBoxVisibility(
  ///     xs: false,
  ///     sm: false,
  ///   ),
  ///   height: LBoxDimension(
  ///     xs: 250.0,
  ///     sm: 280.0,
  ///     md: 350.0,
  ///     lg: 450.0,
  ///     xl: 500.0
  ///   ),
  ///   padding: LBoxEdgeInsets(
  ///     lg: EdgeInsets.all(10.0),
  ///     xl: EdgeInsets.all(20.0),
  ///   ),
  ///   child:
  ///       Image.network("https://source.unsplash.com/random/"),
  /// ),
  /// ...
  ///
  /// ```
  /// See also:
  ///
  ///  * [LResponsiveBuilder], a class which used by [LBox]
  ///    to build its child on each [BreakPoint].
  ///
  ///
  const LBox({
    Key key,
    this.height = const LBoxDimension(),
    this.width = const LBoxDimension(),
    this.visibility = const LBoxVisibility(),
    this.padding = const LBoxEdgeInsets(),
    this.margin = const LBoxEdgeInsets(),
    this.alignment = const LBoxAlignment(),
    this.decoration = const LBoxDecoration(),
    this.useMediaQuery = true,
    @required this.child,
  })  : assert(child != null),
        assert(height != null),
        assert(width != null),
        assert(visibility != null),
        assert(padding != null),
        assert(margin != null),
        assert(alignment != null),
        assert(decoration != null),
        assert(useMediaQuery != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LResponsiveBuilder(
      useMediaQuery: useMediaQuery,
      onXS: (_) => visibility.xs
          ? _buildBox(
              height: height.xs,
              width: width.xs,
              padding: padding.xs,
              margin: margin.xs,
              alignment: alignment.xs,
              decoration: decoration.xs,
            )
          : Container(),
      onSM: (_) => visibility.sm
          ? _buildBox(
              height: height.sm,
              width: width.sm,
              padding: padding.sm,
              margin: margin.sm,
              alignment: alignment.sm,
              decoration: decoration.sm,
            )
          : Container(),
      onMD: (_) => visibility.md
          ? _buildBox(
              height: height.md,
              width: width.md,
              padding: padding.md,
              margin: margin.md,
              alignment: alignment.md,
              decoration: decoration.md,
            )
          : Container(),
      onLG: (_) => visibility.lg
          ? _buildBox(
              height: height.lg,
              width: width.lg,
              padding: padding.lg,
              margin: margin.lg,
              alignment: alignment.lg,
              decoration: decoration.lg,
            )
          : Container(),
      onXL: (_) => visibility.xl
          ? _buildBox(
              height: height.xl,
              width: width.xl,
              padding: padding.xl,
              margin: margin.xl,
              alignment: alignment.xl,
              decoration: decoration.xl,
            )
          : Container(),
    );
  }

  Widget _buildBox({
    double height,
    double width,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    AlignmentGeometry alignment,
    Decoration decoration,
  }) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: decoration,
      child: child,
    );
  }
}

class LAnimatedBox extends LBox {
  final Duration duration;
  final Curve cureve;

  ///Creates a [LBox] that animates its parameters implicitly.
  /// The [curve] and [duration] arguments must not be null.
  const LAnimatedBox({
    Key key,
    this.duration = const Duration(milliseconds: 150),
    this.cureve = Curves.linear,
    LBoxDimension height = const LBoxDimension(),
    LBoxDimension width = const LBoxDimension(),
    LBoxVisibility visibility = const LBoxVisibility(),
    LBoxEdgeInsets padding = const LBoxEdgeInsets(),
    LBoxEdgeInsets margin = const LBoxEdgeInsets(),
    LBoxAlignment alignment = const LBoxAlignment(),
    LBoxDecoration decoration = const LBoxDecoration(),
    bool useMediaQuery = true,
    @required Widget child,
  })  : assert(duration != null),
        assert(cureve != null),
        super(
          key: key,
          height: height,
          width: width,
          visibility: visibility,
          padding: padding,
          margin: margin,
          alignment: alignment,
          decoration: decoration,
          useMediaQuery: useMediaQuery,
          child: child,
        );

  @override
  Widget _buildBox({
    double height,
    double width,
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    AlignmentGeometry alignment,
    Decoration decoration,
  }) {
    return AnimatedContainer(
      duration: duration,
      curve: cureve,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: decoration,
      child: child,
    );
  }
}
