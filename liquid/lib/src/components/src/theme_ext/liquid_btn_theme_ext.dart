// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../../base/base.dart';
import '../buttons.dart';

extension LButtonThemeExtension on LiquidButtonTheme {
  Color getFillColor(LButton button, Color color) {
    if (button.enabled) {
      if (button is LOutlineButton) {
        return Colors.transparent;
      }
      return color;
    }

    return Colors.black12;
  }

  double getElevation(LButton button) {
    if (button is LRaisedButton) {
      if (button.pushAction == LRaisedButtonPushAction.elevate)
        return button.elevation ?? 2.0;
      else
        return 3.0;
    }
    return button.elevation ?? 0.0;
  }

  double getFocusElevation(LButton button) {
    if (button is LRaisedButton) {
      return button.focusElevation ?? 4.0;
    }
    return button.focusElevation ?? 0.0;
  }

  double getHighlightElevation(LButton button) {
    if (button is LRaisedButton) {
      if (button.pushAction == LRaisedButtonPushAction.elevate)
        return button.highlightElevation ?? 8.0;
      else
        return 0.0;
    }
    return button.highlightElevation ?? 0.0;
  }

  double getHoverElevation(LButton button) {
    if (button is LRaisedButton) {
      if (button.pushAction == LRaisedButtonPushAction.elevate)
        return button.hoverElevation ?? 4.0;
      else
        return 2.5;
    }
    return button.hoverElevation ?? 0.0;
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
      LButton button, TextStyle baseStyle, Color color, bool _hover) {
    if (button.enabled) {
      if (button.type == LElementType.light ||
          button.type == LElementType.warning)
        return baseStyle.withColor(color.darken(0.3));

      if (button is LOutlineButton) {
        if (button.fillMode == FillMode.solid && _hover)
          return baseStyle.withColor(Colors.white);
        return baseStyle.withColor(color);
      }
      return baseStyle.withColor(Colors.white);
    }

    return baseStyle.withColor(Colors.black38);
  }
}
