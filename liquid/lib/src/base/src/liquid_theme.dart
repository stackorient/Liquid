import 'package:flutter/material.dart';

enum LElementType {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  light,
  dark
}

enum LElementShape { standard, pill }

enum LElementSize { large, medium, normal, small }

class LiquidAlertTheme {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final EdgeInsets headingPadding;

  const LiquidAlertTheme({
    this.padding = const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12.0),
    this.margin = const EdgeInsets.only(bottom: 12.0),
    this.headingPadding =
        const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
  });
}

class LiquidBadgeTheme {
  final EdgeInsets padding;
  final EdgeInsets margin;
  final double defaultRadius;

  const LiquidBadgeTheme({
    this.padding = const EdgeInsets.symmetric(horizontal: 9.0, vertical: 5.0),
    this.margin = EdgeInsets.zero,
    this.defaultRadius = 4.0,
  });

  Color getContentColor(LElementType type) {
    if (type == LElementType.light) return Colors.black;
    return Colors.white;
  }
}

class LiquidButtonTheme {
  final EdgeInsets padding;
  final EdgeInsets margin;

  const LiquidButtonTheme({
    this.padding = const EdgeInsets.symmetric(horizontal: 16.0, vertical: 7.0),
    this.margin = const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5.0),
  });
}

class LiquidColors {
  final Color primary;
  final Color secondary;
  final Color success;
  final Color danger;
  final Color warning;
  final Color info;
  final Color light;
  final Color dark;
  final Color white;
  final Color transparent;

  const LiquidColors({
    this.primary = const Color(0xFF007bff),
    this.secondary = const Color(0xFF6c757d),
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

class LiquidTypography {
  final TextStyle h1;
  final TextStyle h2;
  final TextStyle h3;
  final TextStyle h4;
  final TextStyle h5;
  final TextStyle h6;
  final TextStyle p;
  final TextStyle small;
  final TextStyle display1;
  final TextStyle display2;
  final TextStyle display3;
  final TextStyle display4;
  final TextStyle lead;
  final TextStyle quote;
  final TextStyle quoteFooter;

  const LiquidTypography({
    this.h1 = const TextStyle(
      fontSize: 40.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h2 = const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h3 = const TextStyle(
      fontSize: 28.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h4 = const TextStyle(
      fontSize: 24.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h5 = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.h6 = const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
    ),
    this.p = const TextStyle(
      fontSize: 14.0,
    ),
    this.small = const TextStyle(
      fontSize: 12.8,
    ),
    this.display1 = const TextStyle(
      fontSize: 96.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.display2 = const TextStyle(
      fontSize: 88.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.display3 = const TextStyle(
      fontSize: 72.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.display4 = const TextStyle(
      fontSize: 56.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.lead = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w300,
      height: 1.2,
    ),
    this.quote = const TextStyle(
      fontSize: 20.0,
    ),
    this.quoteFooter = const TextStyle(
      fontSize: 16.0,
      color: Color(0xFF6c757d),
    ),
  });
}

class LiquidDropdownItemTheme {
  final EdgeInsets padding;
  final Color splashColor;
  final Color focusColor;
  final Color highlightColor;
  final Color hoverColor;
  final TextStyle textStyle;
  final TextStyle disabledTextStyle;
  final TextStyle headerTextStyle;
  final EdgeInsets headerPadding;

  const LiquidDropdownItemTheme({
    this.padding = const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
    this.headerPadding =
        const EdgeInsets.symmetric(horizontal: 24.0, vertical: 6.0),
    this.splashColor,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.textStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black,
      fontSize: 14.8,
    ),
    this.headerTextStyle = const TextStyle(
      fontWeight: FontWeight.w500,
      color: Colors.black45,
      fontSize: 12.0,
    ),
    this.disabledTextStyle = const TextStyle(
      fontWeight: FontWeight.w400,
      color: Colors.black26,
      fontSize: 14.8,
    ),
  });
}

class LiquidDropdownTheme {
  final LiquidDropdownItemTheme itemTheme;
  final EdgeInsets padding;
  final Color background;
  final double elevation;
  final ShapeBorder shape;

  const LiquidDropdownTheme({
    this.itemTheme = const LiquidDropdownItemTheme(),
    this.padding = const EdgeInsets.symmetric(vertical: 6.0),
    this.background = Colors.white,
    this.elevation = 0.0,
    this.shape,
  });
}

class LiquidCollapseTheme {
  final TextStyle titleStyle;
  final TextStyle subtitleStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;

  const LiquidCollapseTheme({
    this.titleStyle = const TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: Colors.black,
    ),
    this.subtitleStyle = const TextStyle(
      fontSize: 12.8,
      color: Colors.black38,
    ),
    this.padding,
    this.margin,
  });
}

class LiquidThemeData {
  final LiquidColors colors;
  final LiquidGradients gradients;
  final LiquidAlertTheme alertTheme;
  final LiquidBadgeTheme badgeTheme;
  final LiquidButtonTheme buttonTheme;
  final LiquidTypography typographyTheme;
  final LiquidDropdownTheme dropdownTheme;
  final LiquidCollapseTheme collapseTheme;

  const LiquidThemeData({
    this.colors = const LiquidColors(),
    this.gradients = const LiquidGradients(),
    this.alertTheme = const LiquidAlertTheme(),
    this.badgeTheme = const LiquidBadgeTheme(),
    this.buttonTheme = const LiquidButtonTheme(),
    this.typographyTheme = const LiquidTypography(),
    this.dropdownTheme = const LiquidDropdownTheme(),
    this.collapseTheme = const LiquidCollapseTheme(),
  });

  Color getTypeColor(LElementType type) {
    switch (type) {
      case LElementType.secondary:
        return colors.secondary;
        break;
      case LElementType.success:
        return colors.success;
        break;
      case LElementType.danger:
        return colors.danger;
        break;
      case LElementType.info:
        return colors.info;
        break;
      case LElementType.warning:
        return colors.warning;
        break;
      case LElementType.light:
        return colors.light;
        break;
      case LElementType.dark:
        return colors.dark;
        break;
      case LElementType.primary:
      default:
        return colors.primary;
        break;
    }
  }

  BorderRadius getElementShape({
    LElementShape shape,
    double radius,
  }) {
    switch (shape) {
      case LElementShape.pill:
        return BorderRadius.circular(1500);
        break;
      case LElementShape.standard:
      default:
        return BorderRadius.circular(radius ?? 4.0);
    }
  }

  double getElementSizeFactor(LElementSize size) {
    switch (size) {
      case LElementSize.large:
        return 1.5;
        break;
      case LElementSize.medium:
        return 1.25;

      case LElementSize.small:
        return 0.75;

      case LElementSize.normal:
      default:
        return 1.0;
    }
  }
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
