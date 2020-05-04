import 'package:flutter/material.dart';

import '../../base/base.dart';

class LHeaderTag extends StatelessWidget {
  ///Tag Width
  final double tagWidth;

  ///Tag height
  final double tagHeight;

  final EdgeInsetsGeometry margin;

  ///Tag Color
  final Color tagColor;
  final EdgeInsets padding;

  /// Widget trailing tag.
  final Widget child;

  /// Add tags [LHeaderTag]
  ///
  /// Example:
  ///
  /// ```
  /// ...
  ///
  ///  LHeaderTag(
  ///    child: Text('Header'),
  ///    tagColor:
  ///        LiquidTheme.of(context).backgroundColors.secondaryColor,
  ///  ),
  /// ...
  /// ```
  const LHeaderTag({
    Key key,
    this.tagWidth = 4.0,
    this.tagHeight = 20.0,
    this.margin = const EdgeInsets.all(2.0),
    this.tagColor,
    this.child,
    this.padding,
  })  : assert(child != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: tagWidth ?? 5.0,
          margin: margin ?? EdgeInsets.all(2.0),
          height: tagHeight ?? 20.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: tagColor ?? theme.backgroundColors.primaryColor,
          ),
        ),
        Container(
          padding:
              padding ?? EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
          child: child ?? Container(),
        ),
      ],
    );
  }
}