part of 'base.dart';

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

class LiquidAlertTheme {
  final LiquidAlertTextColors textColors;
  final LiquidAlertBackgroundColors backgroundColors;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final EdgeInsets headingPadding;

  const LiquidAlertTheme({
    this.textColors = const LiquidAlertTextColors(),
    this.backgroundColors = const LiquidAlertBackgroundColors(),
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    this.margin = const EdgeInsets.only(bottom: 12.0),
    this.headingPadding = const EdgeInsets.only(bottom: 8.0),
  });
}

class LiquidBadgeTextColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;

  const LiquidBadgeTextColors({
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

class LiquidBadgeBackgroundColors {
  final Color primaryColor;
  final Color secondaryColor;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;

  const LiquidBadgeBackgroundColors({
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

class LiquidBadgeTheme {
  final LiquidBadgeBackgroundColors backgroundColors;
  final LiquidBadgeTextColors textColors;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const LiquidBadgeTheme({
    this.backgroundColors = const LiquidBadgeBackgroundColors(),
    this.textColors = const LiquidBadgeTextColors(),
    this.padding = const EdgeInsets.symmetric(horizontal: 5.0, vertical: 2.0),
    this.margin = const EdgeInsets.only(bottom: 0.0),
  });
}

class LiquidButtonTheme {
  final LiquidButtonColors buttonColors;
  final LiquidTextColors textColors;
  final EdgeInsets padding;
  final EdgeInsets smallPadding;
  final EdgeInsets margin;

  const LiquidButtonTheme({
    this.buttonColors = const LiquidButtonColors(),
    this.textColors = const LiquidTextColors(),
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    this.smallPadding =
        const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 4.0),
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
    this.transparent = const Color(0xffffff00),
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

class LiquidTypographyTheme {
  final LTextStyle h1;
  final LTextStyle h2;
  final LTextStyle h3;
  final LTextStyle h4;
  final LTextStyle h5;
  final LTextStyle h6;
  final LTextStyle p;
  final LTextStyle small;
  final LTextStyle display1;
  final LTextStyle display2;
  final LTextStyle display3;
  final LTextStyle display4;
  final LTextStyle lead;
  final LTextStyle quote;
  final LTextStyle quoteFooter;

  const LiquidTypographyTheme({
    this.h1 = const LTextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h2 = const LTextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h3 = const LTextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h4 = const LTextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h5 = const LTextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h6 = const LTextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.p = const LTextStyle(
      fontSize: 14.0,
    ),
    this.small = const LTextStyle(
      fontSize: 12.8,
    ),
    this.display1 = const LTextStyle(
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.display2 = const LTextStyle(
      fontSize: 88.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.display3 = const LTextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.display4 = const LTextStyle(
      fontSize: 56.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.lead = const LTextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.quote = const LTextStyle(
      fontSize: 20.0,
    ),
    this.quoteFooter = const LTextStyle(
      fontSize: 16.0,
      color: Color(0xFF6c757d),
    ),
  });
}

class LiquidThemeData {
  final LiquidButtonColors buttonColors;
  final LiquidTextColors textColors;
  final LiquidBackgroundColors backgroundColors;
  final LiquidGradients gradients;
  final LiquidAlertTheme alertTheme;
  final LiquidBadgeTheme badgeTheme;
  final LiquidButtonTheme buttonTheme;
  final LiquidTypographyTheme typographyTheme;

  const LiquidThemeData({
    this.buttonColors = const LiquidButtonColors(),
    this.textColors = const LiquidTextColors(),
    this.backgroundColors = const LiquidBackgroundColors(),
    this.gradients = const LiquidGradients(),
    this.alertTheme = const LiquidAlertTheme(),
    this.badgeTheme = const LiquidBadgeTheme(),
    this.buttonTheme = const LiquidButtonTheme(),
    this.typographyTheme = const LiquidTypographyTheme(),
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
