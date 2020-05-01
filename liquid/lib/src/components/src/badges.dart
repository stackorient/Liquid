import 'package:flutter/material.dart';

import '../../base/base.dart';

enum BadgeType {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  light,
  dark
}

enum BadgeShape {
  standard,

  pills
}

class LBadge extends StatelessWidget {
  /// defines the badge type
  ///
  /// `primary`, `secondary`, `success`, `warning`,
  /// `danger`, `dark`, `info`, `light`, `dark`
  ///
  /// see: [BadgeType]
  final BadgeType type;

  /// defines the badge shape
  ///
  /// `standard`, `pills`
  ///
  /// see: [BadgeShape]
  final BadgeShape shape;

  final Widget child;

  /// defins the margin around badge
  final EdgeInsets margin;

  /// defines the padding inside the badge
  final EdgeInsets padding;

  /// defines the background color of the badge
  final Color background;

  /// Creates a badge of Widget type
  ///
  ///
  ///
  /// example:
  /// ```dart
  ///
  /// ...
  /// LBadge(
  ///   shape: BadgeShape.pills,
  ///   type: BadgeType.info,
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
    this.type = BadgeType.primary,
    this.shape = BadgeShape.standard,
    this.margin,
    this.padding,
    this.child,
    this.background,
  })  : assert(child != null),
        super(key: key);

  List<Color> _getColors(LiquidThemeData themeData) {
    final bg = themeData.badgeTheme.backgroundColors;
    final tc = themeData.badgeTheme.textColors;

    switch (type) {
      case BadgeType.primary:
        return [bg.primaryColor, tc.primaryColor];
        break;
      case BadgeType.secondary:
        return [bg.secondaryColor, tc.secondaryColor];
        break;
      case BadgeType.success:
        return [bg.success, tc.success];
        break;
      case BadgeType.danger:
        return [bg.danger, tc.danger];
        break;
      case BadgeType.info:
        return [bg.info, tc.info];
        break;
      case BadgeType.warning:
        return [bg.warning, tc.warning];
        break;
      case BadgeType.light:
        return [bg.light, tc.light];
        break;
      case BadgeType.dark:
        return [bg.dark, tc.dark];
        break;

      default:
        return [bg.primaryColor, tc.primaryColor];
        break;
    }
  }

  BorderRadius _getShape(LiquidThemeData themeData) {
    switch (shape) {
      case BadgeShape.pills:
        return BorderRadius.circular(15.0);
        break;
      case BadgeShape.standard:
      default:
        return BorderRadius.circular(4.0);
    }
  }

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
  factory LBadge.text(
    String text, {
    TextStyle style,
    BadgeType type,
    BadgeShape shape,
    EdgeInsets margin,
    EdgeInsets padding,
    Color background,
  }) {
    assert(text != null);
    return LBadge(
      type: type,
      shape: shape,
      margin: margin,
      padding: padding,
      background: background,
      child: Text(
        text,
        style: style,
      ),
    );
  }

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
  factory LBadge.icon({
    @required Widget icon,
    @required Widget label,
    TextStyle style,
    double iconSize,
    Color color = Colors.white,
    double spacing,
    BadgeType type,
    BadgeShape shape,
    EdgeInsets margin,
    EdgeInsets padding,
    Color background,
  }) {
    assert(icon != null, label != null);
    return LBadge(
      type: type,
      shape: shape,
      margin: margin,
      padding: padding,
      background: background,
      child: DefaultTextStyle(
        style: (TextStyle(fontSize: 12.0) ?? style).withColor(color),
        child: IconTheme(
          data: IconThemeData.fallback()
              .copyWith(color: color, size: iconSize ?? 16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              icon,
              SizedBox(width: spacing ?? 5.0),
              label,
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final colors = _getColors(theme);
    final _shape = _getShape(theme);
    return Material(
      color: background ?? colors[0],
      borderRadius: _shape,
      child: Container(
        margin: margin ?? theme.badgeTheme.margin,
        padding: padding ?? theme.badgeTheme.padding,
        child: child,
      ),
    );
  }
}
