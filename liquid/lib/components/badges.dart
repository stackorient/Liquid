part of 'components.dart';

enum BadgesType {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  light,
  dark
}

enum BadgesShape {
  standard,

  pills
}

class LBadge extends StatelessWidget {
  final BadgesType type;
  final BadgesShape shape;
  final Widget child;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color background;

  const LBadge({
    Key key,
    this.type = BadgesType.primary,
    this.shape = BadgesShape.standard,
    this.margin,
    this.padding,
    this.child,
    this.background,
  })  : assert(child != null),
        super(key: key);

  List<Color> _getColors(LiquidThemeData themeData) {
    final bg = themeData.badgeTheme.backgroundColors;
    final tc = themeData.badgeTheme.textColors;

    switch (type) {
      case BadgesType.primary:
        return [bg.primaryColor, tc.primaryColor];
        break;
      case BadgesType.secondary:
        return [bg.secondaryColor, tc.secondaryColor];
        break;
      case BadgesType.success:
        return [bg.success, tc.success];
        break;
      case BadgesType.danger:
        return [bg.danger, tc.danger];
        break;
      case BadgesType.info:
        return [bg.info, tc.info];
        break;
      case BadgesType.warning:
        return [bg.warning, tc.warning];
        break;
      case BadgesType.light:
        return [bg.light, tc.light];
        break;
      case BadgesType.dark:
        return [bg.dark, tc.dark];
        break;

      default:
        return [bg.primaryColor, tc.primaryColor];
        break;
    }
  }

  BorderRadius _getShape(LiquidThemeData themeData) {
    switch (shape) {
      case BadgesShape.pills:
        return BorderRadius.circular(15.0);
        break;
      case BadgesShape.standard:
      default:
        return BorderRadius.circular(5.0);
    }
  }

  factory LBadge.text(
    String text, {
    TextStyle style,
    BadgesType type,
    BadgesShape shape,
    EdgeInsets margin,
    EdgeInsets padding,
    Color background,
  }) {
    assert(text != null);
    return LBadge(
      type: type,
      shape: shape,
      margin: margin,
      padding: padding,
      background: background,
      child: Text(
        text,
        style: style,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final colors = _getColors(theme);
    final _shape = _getShape(theme);
    return Material(
      color: background ?? colors[0],
      borderRadius: _shape,
      child: Container(
        margin: margin ?? theme.badgeTheme.margin,
        padding: padding ?? theme.badgeTheme.padding,
        child: child,
      ),
    );
  }
}
