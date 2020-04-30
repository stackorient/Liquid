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

class LAnimatedBox extends StatefulWidget {
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
  _LAnimatedBoxState createState() => _LAnimatedBoxState();
}

class _LAnimatedBoxState extends State<LAnimatedBox>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return LResponsiveBuilder(
      useMediaQuery: widget.useMediaQuery,
      onXS: (_) => AnimatedSize(
        duration: Duration(milliseconds: 400),
        vsync: this,
        child: SizedBox.fromSize(
          size: widget.visibility.xs ? null : Size.zero,
          child: _buildBox(
            height: widget.height.xs,
            width: widget.width.xs,
            padding: widget.padding.xs,
            margin: widget.margin.xs,
            alignment: widget.alignment.xs,
            decoration: widget.decoration.xs,
          ),
        ),
      ),
      onSM: (_) => AnimatedSize(
        duration: Duration(milliseconds: 400),
        vsync: this,
        child: SizedBox.fromSize(
            size: widget.visibility.sm ? null : Size.zero,
            child: _buildBox(
              height: widget.height.sm,
              width: widget.width.sm,
              padding: widget.padding.sm,
              margin: widget.margin.sm,
              alignment: widget.alignment.sm,
              decoration: widget.decoration.sm,
            )),
      ),
      onMD: (_) => AnimatedSize(
        duration: Duration(milliseconds: 400),
        vsync: this,
        child: SizedBox.fromSize(
          size: widget.visibility.md ? null : Size.zero,
          child: _buildBox(
            height: widget.height.md,
            width: widget.width.md,
            padding: widget.padding.md,
            margin: widget.margin.md,
            alignment: widget.alignment.md,
            decoration: widget.decoration.md,
          ),
        ),
      ),
      onLG: (_) => AnimatedSize(
        duration: Duration(milliseconds: 400),
        vsync: this,
        child: SizedBox.fromSize(
            size: widget.visibility.lg ? null : Size.zero,
            child: _buildBox(
              height: widget.height.lg,
              width: widget.width.lg,
              padding: widget.padding.lg,
              margin: widget.margin.lg,
              alignment: widget.alignment.lg,
              decoration: widget.decoration.lg,
            )),
      ),
      onXL: (_) => AnimatedSize(
        duration: Duration(milliseconds: 400),
        vsync: this,
        child: SizedBox.fromSize(
          size: widget.visibility.xl ? null : Size.zero,
          child: _buildBox(
            height: widget.height.xl,
            width: widget.width.xl,
            padding: widget.padding.xl,
            margin: widget.margin.xl,
            alignment: widget.alignment.xl,
            decoration: widget.decoration.xl,
          ),
        ),
      ),
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
      child: widget.child,
    );
  }
}
