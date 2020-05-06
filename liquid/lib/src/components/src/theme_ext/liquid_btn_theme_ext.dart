import 'package:flutter/material.dart';

import '../../../base/base.dart';
import '../buttons.dart';

extension LButtonThemeExtension on LiquidButtonTheme {
  Color getFillColor(LButton button, Color color) {
    if (button is LOutlineButton) {
      return Colors.transparent;
    }
    return color;
  }

  double getElevation(LButton button) {
    if (button is LRaisedButton) {
      return 2.0;
    }
    return 0.0;
  }

  double getFocusElevation(LButton button) {
    if (button is LRaisedButton) {
      return 4.0;
    }
    return 0.0;
  }

  double getHighlightElevation(LButton button) {
    if (button is LRaisedButton) {
      return 8.0;
    }
    return 0.0;
  }

  double getHoverElevation(LButton button) {
    if (button is LRaisedButton) {
      return 4.0;
    }
    return 0.0;
  }

  Color getHighlightColor(LButton button, Color color) {
    if (button is LRaisedButton) return color.lighten(0.1);
    if (button is LOutlineButton) {
      if (button.fillMode == FillMode.solid) return color;
      return color.withOpacity(0.3);
    }
    return color.darken(0.1);
  }

  Color getHoverColor(LButton button, Color color) {
    if (button is LOutlineButton) {
      if (button.type == LElementType.light) return color;
      return color.withOpacity(0.1);
    }
    ;
    return color.darken(0.05);
  }

  ShapeBorder getShape(LButton button, BorderRadius radius, Color color,
      {double widthfactor = 1.0}) {
    if (button is LOutlineButton) {
      if (button.fillMode == FillMode.link)
        return const RoundedRectangleBorder();
      return RoundedRectangleBorder(
        borderRadius: radius,
        side: BorderSide(
          color: button.type == LElementType.light ? color.darken(0.1) : color,
          width: 1.2 * widthfactor,
        ),
      );
    }
    return RoundedRectangleBorder(borderRadius: radius);
  }

  TextStyle getTextStyle(
      LButton button, TextStyle style, Color color, bool _hover) {
    if (button.type == LElementType.light ||
        button.type == LElementType.warning)
      return style.withColor(Colors.black);

    if (button is LOutlineButton) {
      if (button.fillMode == FillMode.solid && _hover)
        return style.withColor(Colors.white);
      return style.withColor(color);
    }
    return style.withColor(Colors.white);
  }
}
