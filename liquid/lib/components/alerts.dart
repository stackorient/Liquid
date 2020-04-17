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
  final List<Uri> urls;

  const LAlert(
    this.text, {
    Key key,
    this.type = AlertType.primary,
    this.urls,
  })  : assert(text != null),
        super(key: key);

  List<Color> _getColors(LiquidThemeData themeData) {
    final bg = themeData.alertBackgroundColors;
    final tc = themeData.alertTextColors;

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
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
          width: 0.7,
          style: BorderStyle.solid,
          color: colors[1].withOpacity(0.1),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: colors[1],
        ),
      ),
    );
  }
}
