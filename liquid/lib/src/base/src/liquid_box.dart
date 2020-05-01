import 'package:flutter/widgets.dart';

import 'liquid_layout.dart';

class LBoxDimension {
  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;

  const LBoxDimension({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });
}

class LBoxEdgeInsetsGeometry {
  final EdgeInsetsGeometry xs;
  final EdgeInsetsGeometry sm;
  final EdgeInsetsGeometry md;
  final EdgeInsetsGeometry lg;
  final EdgeInsetsGeometry xl;

  const LBoxEdgeInsetsGeometry({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });
}

class LBoxAlignmentGeometry {
  final AlignmentGeometry xs;
  final AlignmentGeometry sm;
  final AlignmentGeometry md;
  final AlignmentGeometry lg;
  final AlignmentGeometry xl;

  const LBoxAlignmentGeometry({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });
}

class LBoxDecoration {
  final Decoration xs;
  final Decoration sm;
  final Decoration md;
  final Decoration lg;
  final Decoration xl;

  const LBoxDecoration({
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  });
}

class LBox extends StatelessWidget {
  final LBoxDimension height;
  final LBoxDimension width;
  final LBoxVisibility visibility;
  final LBoxEdgeInsetsGeometry padding;
  final LBoxEdgeInsetsGeometry margin;
  final LBoxAlignmentGeometry alignment;
  final LBoxDecoration decoration;
  final bool useMediaQuery;

  final Widget child;

  const LBox({
    Key key,
    this.height = const LBoxDimension(),
    this.width = const LBoxDimension(),
    this.visibility = const LBoxVisibility(),
    this.padding = const LBoxEdgeInsetsGeometry(),
    this.margin = const LBoxEdgeInsetsGeometry(),
    this.alignment = const LBoxAlignmentGeometry(),
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

class LAnimatedBox extends StatelessWidget {
  final Duration duration;
  final LBoxDimension height;
  final LBoxDimension width;
  final LBoxVisibility visibility;
  final LBoxEdgeInsetsGeometry padding;
  final LBoxEdgeInsetsGeometry margin;
  final LBoxAlignmentGeometry alignment;
  final LBoxDecoration decoration;
  final bool useMediaQuery;

  final Widget child;

  const LAnimatedBox({
    Key key,
    this.duration = const Duration(milliseconds: 150),
    this.height = const LBoxDimension(),
    this.width = const LBoxDimension(),
    this.visibility = const LBoxVisibility(),
    this.padding = const LBoxEdgeInsetsGeometry(),
    this.margin = const LBoxEdgeInsetsGeometry(),
    this.alignment = const LBoxAlignmentGeometry(),
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
    return AnimatedContainer(
      duration: duration,
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
