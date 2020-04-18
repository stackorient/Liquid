import 'package:flutter/material.dart';
import '../base/base.dart';

class LCard extends StatelessWidget {
  final LCardImage image;
  final LCardBody body;
  final double height;
  final double width;
  final Color color;
  final BorderRadius borderRadius;
  final BoxBorder border;
  final double elevation;
  const LCard(
      {Key key,
      this.image,
      this.body,
      this.height,
      this.width,
      this.color,
      this.borderRadius,
      this.border,
      this.elevation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: elevation,
      borderRadius: borderRadius ?? BorderRadius.circular(5.0),
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: borderRadius ?? BorderRadius.circular(5.0),
          border: border ?? Border.all(color: Colors.black26, width: 1.0),
          color: color,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            image ?? Container(),
            body ?? Container(),
          ],
        ),
      ),
    );
  }
}

class LCardImage extends StatelessWidget {
  final ImageProvider image;
  final Widget child;
  final void Function(dynamic, StackTrace) onError;
  final ColorFilter colorFilter;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final Rect centerSlice;
  final ImageRepeat repeat;
  final bool matchTextDirection;

  LCardImage(
      {Key key,
      @required this.image,
      this.child,
      this.onError,
      this.colorFilter,
      this.fit,
      this.alignment,
      this.centerSlice,
      this.repeat,
      this.matchTextDirection})
      : assert(image != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: child ?? Container(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          colorFilter: colorFilter,
          fit: fit,
          alignment: alignment,
          centerSlice: centerSlice,
          repeat: repeat,
          matchTextDirection: matchTextDirection,
        ),
      ),
    );
  }
}

class LCardBody extends StatelessWidget {
  final String title;
  final Widget child;
  final LTextStyle titleStyle;
  final EdgeInsets padding;
  const LCardBody(
      {Key key, this.title, this.child, this.titleStyle, this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    return Container(
      padding: padding ?? EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            title,
            style: titleStyle ?? theme.typographyTheme.h5,
          ),
          child ?? Container()
        ],
      ),
    );
  }
}
