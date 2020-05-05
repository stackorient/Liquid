import 'package:flutter/widgets.dart';

import '../../base/base.dart';

enum LAlertType {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  light,
  dark
}

/// Create an alert box
class LAlert extends StatelessWidget {
  /// defines alert type
  final LAlertType type;

  /// defines alert description text
  final String text;

  /// defines alert heading
  final String heading;

  /// list of url
  final List<Uri> urls;

  final EdgeInsets margin;

  /// provides padding around heading of the alert [heading]
  final EdgeInsets headingPadding;

  /// To style the heading text
  final TextStyle headingStyle;

  /// To style the alert description text
  final TextStyle style;

  /// List of widget to be aligned at bottom of alert [alert]
  final List<Widget> bottom;

  /// Create an alert box
  ///
  /// example:
  /// ```
  /// ...
  ///
  /// LAlert(
  ///    "Aww yeah, you successfully read this important alert message.",
  ///    heading: "Well done!, @heyrjs and @heypnd",
  ///    type: LAlertType.success,
  ///  ),
  ///...
  ///
  ///```
  ///See Also:
  ///* different type of `LAlertType`
  ///
  ///     * `LAlertType.primary`
  ///     * `LAlertType.secondary`
  ///     * `LAlertType.success`
  ///     * `LAlertType.warning`
  ///     * `LAlertType.danger`
  ///     * `LAlertType.info`
  ///     * `LAlertType.light`
  ///     * `LAlertType.dark`
  ///
  ///

  const LAlert(
    this.text, {
    this.heading,
    Key key,
    this.type = LAlertType.primary,
    this.urls,
    this.margin,
    this.headingPadding,
    this.style,
    this.headingStyle,
    this.bottom,
  })  : assert(text != null),
        super(key: key);

  List<Color> _getColors(LiquidThemeData themeData) {
    final bg = themeData.alertTheme.backgroundColors;
    final tc = themeData.alertTheme.textColors;

    switch (type) {
      case LAlertType.primary:
        return [bg.primaryColor, tc.primaryColor];
        break;
      case LAlertType.secondary:
        return [bg.secondaryColor, tc.secondaryColor];
        break;
      case LAlertType.success:
        return [bg.success, tc.success];
        break;
      case LAlertType.danger:
        return [bg.danger, tc.danger];
        break;
      case LAlertType.info:
        return [bg.info, tc.info];
        break;
      case LAlertType.warning:
        return [bg.warning, tc.warning];
        break;
      case LAlertType.light:
        return [bg.light, tc.light];
        break;
      case LAlertType.dark:
        return [bg.dark, tc.dark];
        break;

      default:
        return [bg.primaryColor, tc.primaryColor];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final colors = _getColors(theme);
    return Container(
      margin: margin ?? theme.alertTheme.margin,
      padding: theme.alertTheme.padding,
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 0.7,
          style: BorderStyle.solid,
          color: colors[1].withOpacity(0.1),
        ),
      ),
      child: _buildChild(theme, colors),
    );
  }

  Widget _buildChild(LiquidThemeData theme, List<Color> colors) {
    final _text = Text(
      text,
      style: style ?? theme.typographyTheme.p.withColor(colors[1]),
      softWrap: true,
    );

    if (heading != null || bottom != null) {
      final _heading = heading != null
          ? Padding(
              padding: headingPadding ?? theme.alertTheme.headingPadding,
              child: Text(
                heading,
                style: headingStyle ??
                    theme.typographyTheme.h4.withColor(colors[1]),
              ),
            )
          : Container();

      final _childrens = <Widget>[
        _heading ?? Container(),
        _text,
      ];

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _childrens + (bottom ?? []),
      );
    } else {
      return _text;
    }
  }
}
