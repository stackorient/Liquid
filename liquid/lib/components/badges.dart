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

class LBadges extends StatelessWidget {
  final BadgesType type;
  final BadgesShape shape;
  final String text;

  final EdgeInsets margin;
  final EdgeInsets padding;

  const LBadges(
    this.text, {
    Key key,
    this.type = BadgesType.primary,
    this.shape = BadgesShape.standard,
    this.margin,
    this.padding,
  })  : assert(text != null),
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
      case BadgesShape.standard:
        return BorderRadius.circular(5.0);

        break;
      case BadgesShape.pills:
        return BorderRadius.circular(15.0);
        break;
      default:
        return BorderRadius.circular(5.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final colors = _getColors(theme);
    final shape = _getShape(theme);
    return Container(
      padding: theme.badgeTheme.padding,
      decoration: BoxDecoration(
        color: colors[0],
        borderRadius: shape,
      ),
      child: Text(
        text,
        style: theme.typographyTheme.small.withColor(colors[1]).size(10.0),
      ),
    );
  }
}
