import 'dart:ui';

import 'package:flutter/material.dart';

class LiquidAlertTextColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;

  const LiquidAlertTextColors({
    this.primaryColor = const Color(0xFF004085),
    this.secondaryColor = const Color(0xFF383d41),
    this.success = const Color(0xFF155724),
    this.danger = const Color(0xFF721c24),
    this.warning = const Color(0xFF856404),
    this.info = const Color(0xFF0c5460),
    this.light = const Color(0xFF818182),
    this.dark = const Color(0xFF1b1e21),
  });
}

class LiquidAlertBackgroundColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;

  const LiquidAlertBackgroundColors({
    this.primaryColor = const Color(0xFFcce5ff),
    this.secondaryColor = const Color(0xFFe2e3e5),
    this.success = const Color(0xFFd4edda),
    this.danger = const Color(0xFFf8d7da),
    this.warning = const Color(0xFFfff3cd),
    this.info = const Color(0xFFd1ecf1),
    this.light = const Color(0xFFfefefe),
    this.dark = const Color(0xFFd6d8d9),
  });
}

class LiquidButtonColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;
  final Color white;

  const LiquidButtonColors({
    this.primaryColor = const Color(0xFF007bff),
    this.secondaryColor = const Color(0xFF6c757d),
    this.success = const Color(0xFF28a745),
    this.danger = const Color(0xFFdc3545),
    this.warning = const Color(0xFFffc107),
    this.info = const Color(0xFF17a2b8),
    this.light = const Color(0xFFf8f9fa),
    this.dark = const Color(0xFF343a40),
    this.white = const Color(0xFFFFFFFF),
  });
}

class LiquidTextColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;
  final Color body;
  final Color white;
  final Color muted;
  final Color black50;
  final Color white50;

  const LiquidTextColors({
    this.primaryColor = const Color(0xFF007bff),
    this.secondaryColor = const Color(0xFF6c757d),
    this.success = const Color(0xFF28a745),
    this.danger = const Color(0xFFdc3545),
    this.warning = const Color(0xFFffc107),
    this.info = const Color(0xFF17a2b8),
    this.light = const Color(0xFFf8f9fa),
    this.dark = const Color(0xFF343a40),
    this.body = const Color(0xFF515457),
    this.white = const Color(0xFFFFFFFF),
    this.muted = const Color(0xFFb6bbbf),
    this.black50 = const Color(0x80000000),
    this.white50 = const Color(0x80FFFFFF),
  });
}

class LiquidBackgroundColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;
  final Color white;
  final Color transparent;

  const LiquidBackgroundColors({
    this.primaryColor = const Color(0xFF007bff),
    this.secondaryColor = const Color(0xFF6c757d),
    this.success = const Color(0xFF28a745),
    this.danger = const Color(0xFFdc3545),
    this.warning = const Color(0xFFffc107),
    this.info = const Color(0xFF17a2b8),
    this.light = const Color(0xFFf8f9fa),
    this.dark = const Color(0xFF343a40),
    this.white = const Color(0xFFFFFFFF),
    this.transparent = Colors.transparent,
  });
}

class LiquidGradients {
  final LinearGradient primaryColor;
  final LinearGradient secondaryColor;
  final LinearGradient success;
  final LinearGradient danger;
  final LinearGradient warning;
  final LinearGradient info;
  final LinearGradient light;
  final LinearGradient dark;

  const LiquidGradients({
    this.primaryColor = const LinearGradient(colors: [
      Color(0xFF268fff),
      Color(0xFF007bff),
    ]),
    this.secondaryColor = const LinearGradient(colors: [
      Color(0xFF828a91),
      Color(0xFF6c757d),
    ]),
    this.success = const LinearGradient(colors: [
      Color(0xFF48b461),
      Color(0xFF28a745),
    ]),
    this.danger = const LinearGradient(colors: [
      Color(0xFFe15361),
      Color(0xFFdc3545),
    ]),
    this.warning = const LinearGradient(colors: [
      Color(0xFFffca2c),
      Color(0xFFffc107),
    ]),
    this.info = const LinearGradient(colors: [
      Color(0xFF3ab0c3),
      Color(0xFF17a2b8),
    ]),
    this.light = const LinearGradient(colors: [
      Color(0xFFf9fafb),
      Color(0xFFf8f9fa),
    ]),
    this.dark = const LinearGradient(colors: [
      Color(0xFF52585d),
      Color(0xFF343a40),
    ]),
  });
}

class LiquidThemeData {
  final LiquidButtonColors buttonColors;
  final LiquidTextColors textColors;
  final LiquidBackgroundColors backgroundColors;
  final LiquidGradients gradients;
  final LiquidAlertTextColors alertTextColors;
  final LiquidAlertBackgroundColors alertBackgroundColors;

  const LiquidThemeData({
    this.buttonColors = const LiquidButtonColors(),
    this.textColors = const LiquidTextColors(),
    this.backgroundColors = const LiquidBackgroundColors(),
    this.gradients = const LiquidGradients(),
    this.alertTextColors = const LiquidAlertTextColors(),
    this.alertBackgroundColors = const LiquidAlertBackgroundColors(),
  });
}

class LiquidTheme extends InheritedWidget {
  final LiquidThemeData _theme;

  const LiquidTheme(
      {Key key, @required LiquidThemeData theme, @required Widget child})
      : assert(theme != null),
        assert(child != null),
        _theme = theme,
        super(key: key, child: child);

  static LiquidThemeData of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<LiquidTheme>()._theme;
  }

  @override
  bool updateShouldNotify(LiquidTheme old) {
    return _theme != old._theme;
  }
}