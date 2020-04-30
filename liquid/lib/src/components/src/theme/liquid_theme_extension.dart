import 'package:flutter/material.dart';

import '../../../base/base.dart';
import '../buttons.dart';

extension LButtonTheme on LiquidButtonTheme {
  Color getButtonColor(LNButton button) {
    switch (button.type) {
      case ButtonType.secondary:
        return buttonColors.secondaryColor;
        break;
      case ButtonType.success:
        return buttonColors.success;
        break;
      case ButtonType.danger:
        return buttonColors.danger;
        break;
      case ButtonType.info:
        return buttonColors.info;
        break;
      case ButtonType.warning:
        return buttonColors.warning;
        break;
      case ButtonType.light:
        return buttonColors.light;
        break;
      case ButtonType.dark:
        return buttonColors.dark;
        break;
      case ButtonType.primary:
      default:
        return buttonColors.primaryColor;
        break;
    }
  }

  Color getFillColor(LNButton button) {
    if (button is LNOutlineButton) return Colors.transparent;
    return getButtonColor(button);
  }

  Color getButtonBorderColor(LNButton button) {
    switch (button.type) {
      case ButtonType.secondary:
        return buttonColors.secondaryColor.darken(0.1);
        break;
      case ButtonType.success:
        return buttonColors.success.darken(0.1);
        break;
      case ButtonType.danger:
        return buttonColors.danger.darken(0.1);
        break;
      case ButtonType.info:
        return buttonColors.info.darken(0.1);
        break;
      case ButtonType.warning:
        return buttonColors.warning.darken(0.1);
        break;
      case ButtonType.light:
        return buttonColors.light.darken(0.4);
        break;
      case ButtonType.dark:
        return buttonColors.dark.darken(0.1);
        break;
      case ButtonType.primary:
      default:
        return buttonColors.primaryColor.darken(0.1);
        break;
    }
  }

  Color getFocusColor(LNButton button) {
    return getButtonColor(button).darken(0.1);
  }

  Color getHoverColor(LNButton button) {
    if (button is LNOutlineButton && button.fillMode == FillMode.transparent) {
      return getButtonColor(button).withOpacity(0.2);
    }
    return getButtonColor(button).darken(0.05);
  }

  Color getHighlightColor(LNButton button) {
    if (button is LNOutlineButton && button.fillMode == FillMode.transparent) {
      return null;
    }
    return getButtonColor(button).withOpacity(0.8);
  }

  Color getSplashColor(LNButton button) {
    if (button is LNOutlineButton) {
      if (button.fillMode == FillMode.transparent) {
        return getButtonColor(button).withOpacity(0.3);
      }
    }
    return getButtonColor(button).lighten(0.4);
  }

  double getElevation(LNButton button) {
    if (button is LRaisedButton) return 3.0;
    return 0.0;
  }

  double getFocusElevation(LNButton button) {
    if (button is LRaisedButton) return 5.0;
    return 0.0;
  }

  double getHoverElevation(LNButton button) {
    if (button is LRaisedButton) return 4.0;
    return 0.0;
  }

  double getHighlightElevation(LNButton button) {
    return 0.0;
  }

  double getDisabledElevation(LNButton button) {
    return 0.0;
  }

  ShapeBorder getButtonShape(LNButton button) {
    if (button is LRaisedButton)
      return RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
            button.buttonShape == ButtonShape.pill ? 1000 : 3.0),
      );
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
          button.buttonShape == ButtonShape.pill ? 1000 : 3.0),
      side: BorderSide(
        width: 1,
        color: button.type == ButtonType.light
            ? getButtonColor(button).darken(0.2)
            : getButtonColor(button).darken(0.05),
      ),
    );
  }

  TextStyle getTextStyle(LNButton button, bool hover) {
    final _ts = (button.small ?? false) ? smallTextStyle : textStyle;

    if (button is LNOutlineButton &&
        (button.fillMode == FillMode.transparent || !hover)) {
      return _ts.withColor(
        button.type == ButtonType.light
            ? getButtonColor(button).darken(0.4)
            : getButtonColor(button),
      );
    }

    if (button.type == ButtonType.warning || button.type == ButtonType.light) {
      return _ts.withColor(Colors.black);
    }
    return _ts.withColor(Colors.white);
  }
}
