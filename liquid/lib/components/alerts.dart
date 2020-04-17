import 'package:flutter/material.dart';

import '../base/base.dart';

enum AlertType {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  light,
  dark
}

class LAlert extends StatelessWidget {
  final AlertType type;
  final String text;
  final String heading;
  final List<Uri> urls;
  final EdgeInsets margin;
  final EdgeInsets headingPadding;
  final LTextStyle headingStyle;
  final LTextStyle style;
  final List<Widget> bottom;

  const LAlert(
    this.text, {
    this.heading,
    Key key,
    this.type = AlertType.primary,
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
      case AlertType.primary:
        return [bg.primaryColor, tc.primaryColor];
        break;
      case AlertType.secondary:
        return [bg.secondaryColor, tc.secondaryColor];
        break;
      case AlertType.success:
        return [bg.success, tc.success];
        break;
      case AlertType.danger:
        return [bg.danger, tc.danger];
        break;
      case AlertType.info:
        return [bg.info, tc.info];
        break;
      case AlertType.warning:
        return [bg.warning, tc.warning];
        break;
      case AlertType.light:
        return [bg.light, tc.light];
        break;
      case AlertType.dark:
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
        heading != null ? _heading : Container(),
        _text,
      ];

      return LColumn(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _childrens + (bottom ?? []),
      );
    } else {
      return _text;
    }
  }
}
