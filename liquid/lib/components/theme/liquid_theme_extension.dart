part of '../components.dart';

extension on LiquidButtonTheme {
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
    if (button is LNOutlineButton) return Colors.white;
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
        return buttonColors.light.darken(0.1);
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
    return getButtonColor(button).darken(0.05);
  }

  Color getHighlightColor(LNButton button) {
    if (button is LNOutlineButton) {
      if (button.fillMode == FillMode.transparent) {
        return getButtonColor(button).lighten(0.45);
      }
    }
    return getButtonColor(button).darken(0.1);
  }

  Color getSplashColor(LNButton button) {
    if (button is LNOutlineButton) {
      if (button.fillMode == FillMode.transparent) {
        return getButtonColor(button).lighten(0.2);
      }
    }
    return getButtonColor(button).lighten(0.4);
  }

  double getElevation(LNButton button) {
    if (button is LRaisedButton) return 2.0;
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
        borderRadius: BorderRadius.circular(3.0),
      );
    return RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(3.0),
      side: BorderSide(
        width: 1,
        color: getButtonColor(button).darken(0.05),
      ),
    );
  }

  TextStyle getTextStyle(LNButton button, bool hover) {
    if (button is LNOutlineButton && !hover) {
      return textStyle.withColor(
        button.type == ButtonType.light
            ? getButtonColor(button).darken(0.3)
            : getButtonColor(button),
      );
    }

    if (button.type == ButtonType.warning || button.type == ButtonType.light) {
      return textStyle.withColor(Colors.black);
    }
    return textStyle.withColor(Colors.white);
  }
}
