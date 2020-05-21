import 'package:flutter/material.dart';
import 'theme_ext/theme_ext.dart';

import '../../base/base.dart';

/// Creates a badge of Widget type
class LBadge extends StatelessWidget {
  /// defines the badge type
  ///
  /// `primary`, `secondary`, `success`, `warning`,
  /// `danger`, `dark`, `info`, `light`, `dark`
  ///
  /// see: [LElementType]
  final LElementType type;

  final LElementSize size;

  /// defines the badge shape
  ///
  /// `standard`, `pill`
  ///
  /// see: [LElementShape]
  final LElementShape shape;

  final Widget child;

  /// defins the margin around badge
  final EdgeInsets margin;

  /// defines the padding inside the badge
  final EdgeInsets padding;

  /// defines the background color of the badge
  final Color background;

  final TextStyle textStyle;

  final double iconSize;

  final Color iconColor;

  final BorderRadius radius;

  /// Creates a badge of Widget type
  ///
  ///
  ///
  /// example:
  /// ```dart
  ///
  /// ...
  /// LBadge(
  ///   shape: LElementShape.pill,
  ///   type: LElementType.info,
  ///   child: Row(
  ///        mainAxisSize: MainAxisSize.min,
  ///        children: <Widget>[
  ///        Icon(
  ///           Icons.warning,
  ///           size: 15.0,
  ///             ),
  ///        SizedBox(
  ///           width: 10.0,
  ///         ),
  ///        Text(
  ///          "No Update",
  ///         ),
  ///       ],
  ///     ),
  ///   ),
  ///
  /// ...
  /// ```
  /// see:
  /// `BadgeType`, `BadgeShape`, `background`
  ///
  /// seeAlso:
  /// * `LBadge.text()` holds for text as child,
  /// *`LBadge.icon()` holds for icon as child
  const LBadge({
    Key key,
    this.type = LElementType.primary,
    this.shape = LElementShape.standard,
    this.margin,
    this.padding,
    this.child,
    this.background,
    this.textStyle,
    this.iconColor,
    this.iconSize,
    this.size = LElementSize.normal,
    this.radius,
  })  : assert(child != null),
        assert(size != null),
        super(key: key);

  /// defines text instead of widget [child] in LBadge
  ///
  ///example:
  ///```
  ///...
  /// child: LBadge.text(
  ///          "Hello, @heypnd and @heyrjs",
  ///          shape: BadgeShape.standard,
  ///          type: BadgeType.dark,
  ///        ),
  ///...
  ///```
  ///
  LBadge.text(
    String text, {
    Key key,
    this.type = LElementType.primary,
    this.shape = LElementShape.standard,
    this.margin,
    this.padding,
    this.background,
    this.textStyle,
    this.iconColor,
    this.iconSize,
    this.size = LElementSize.normal,
    this.radius,
  })  : assert(text != null),
        child = Text(text),
        super(key: key);

  /// defines icon instead of widget [child] in LBadge
  ///
  /// `label` defines for a trailing widget
  ///
  /// `spacing` space between `icon` and `label`
  ///
  ///Example:
  ///
  ///```
  ///...
  ///
  /// child: LBadge.icon(
  ///          icon: Icon(Icons.ac_unit),
  ///          shape: BadgeShape.standard,
  ///          type: BadgeType.dark,
  ///        ),
  ///
  ///...
  ///```
  ///
  ///
  LBadge.icon({
    Key key,
    this.type = LElementType.primary,
    this.shape = LElementShape.standard,
    this.margin,
    this.padding,
    this.background,
    @required Widget icon,
    @required Widget label,
    this.textStyle,
    this.iconColor,
    this.iconSize,
    double spacing = 3.0,
    this.radius,
    this.size = LElementSize.normal,
  })  : assert(icon != null, label != null),
        assert(spacing != null && spacing >= 0.0),
        child = Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon,
            SizedBox(width: spacing),
            label,
          ],
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final LiquidThemeData theme = LiquidTheme.of(context);
    final badgeTheme = theme.badgeTheme;
    final _contentColor = badgeTheme.getContentColor(type);
    final _textStyle = theme.typographyTheme.small.withColor(_contentColor);
    final _sizeFactor = LiquidThemeData().getElementSizeFactor(size);

    return DefaultTextStyle(
      style: textStyle ?? _textStyle.size(_textStyle.fontSize * _sizeFactor),
      child: IconTheme(
        data: IconThemeData(
          color: iconColor ?? _contentColor,
          size: iconSize ?? 16.0 * _sizeFactor,
        ),
        child: Container(
          margin: margin ?? badgeTheme.margin * _sizeFactor,
          padding: padding ?? badgeTheme.padding * _sizeFactor,
          decoration: BoxDecoration(
            color: background ?? theme.getTypeColor(type),
            borderRadius: radius ??
                theme.getElementShape(
                  shape: shape,
                  radius: badgeTheme.defaultRadius,
                ),
          ),
          child: child,
        ),
      ),
    );
  }
}
