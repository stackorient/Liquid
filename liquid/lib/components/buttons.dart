part of 'components.dart';

enum ButtonType {
  primary,
  secondary,
  success,
  warning,
  danger,
  info,
  light,
  dark
}

enum ButtonShape { standard, circular }

class LNButton extends StatelessWidget {
  final void Function() onPressed;
  final void Function() onLongPress;
  final void Function(bool) onHighlightChanged;
  final TextStyle textStyle;
  final Color fillColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color splashColor;
  final double elevation;
  final double focusElevation;
  final double hoverElevation;
  final double highlightElevation;
  final double disabledElevation;
  final EdgeInsetsGeometry padding;
  final VisualDensity visualDensity;
  final BoxConstraints constraints;
  final ShapeBorder shape;
  final Duration animationDuration;
  final Clip clipBehavior;
  final FocusNode focusNode;
  final bool autofocus;
  final MaterialTapTargetSize materialTapTargetSize;
  final Widget child;
  final bool enableFeedback;

  const LNButton({
    Key key,
    this.onLongPress,
    this.onHighlightChanged,
    this.textStyle,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation = 2.0,
    this.focusElevation = 4.0,
    this.hoverElevation = 4.0,
    this.highlightElevation = 8.0,
    this.disabledElevation = 0.0,
    this.padding = EdgeInsets.zero,
    this.visualDensity = const VisualDensity(),
    this.constraints = const BoxConstraints(minWidth: 77.0, minHeight: 36.0),
    this.shape = const RoundedRectangleBorder(),
    this.animationDuration = kThemeChangeDuration,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.child,
    this.enableFeedback = true,
    this.onPressed,
    this.materialTapTargetSize,
  })  : assert(shape != null),
        assert(elevation != null && elevation >= 0.0),
        assert(focusElevation != null && focusElevation >= 0.0),
        assert(hoverElevation != null && hoverElevation >= 0.0),
        assert(highlightElevation != null && highlightElevation >= 0.0),
        assert(disabledElevation != null && disabledElevation >= 0.0),
        assert(padding != null),
        assert(constraints != null),
        assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onLongPress: onLongPress,
      onHighlightChanged: onHighlightChanged,
      textStyle: textStyle,
      fillColor: fillColor,
      focusColor: focusColor,
      hoverColor: hoverColor,
      highlightColor: highlightColor,
      splashColor: splashColor,
      elevation: elevation,
      focusElevation: focusElevation,
      hoverElevation: hoverElevation,
      highlightElevation: highlightElevation,
      disabledElevation: disabledElevation,
      padding: padding,
      visualDensity: visualDensity,
      shape: shape,
      clipBehavior: clipBehavior,
      focusNode: focusNode,
      autofocus: autofocus,
      materialTapTargetSize: materialTapTargetSize,
      animationDuration: animationDuration,
      enableFeedback: enableFeedback,
      child: child,
      onPressed: onPressed,
      constraints: constraints,
    );
  }
}

class LButton extends StatelessWidget {
  final Color textColor;
  final Color color;
  final String text;
  final ButtonType type;
  final ButtonShape shape;
  final Widget child;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Function onPressed;
  final bool autofocus;
  final BorderRadius borderRadius;
  final bool canRequestFocus;
  final ShapeBorder customBorder;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final Color focusColor;
  final FocusNode focusNode;
  final Color highlightColor;
  final Color hoverColor;
  final Function onFocusChange;
  final Function onHighlightChanged;
  final Function onHover;
  final bool small;
  final double borderThickness;

  const LButton({
    Key key,
    this.child,
    this.color,
    this.text,
    this.textColor,
    this.elevation = 0.0,
    this.small = false,
    this.type = ButtonType.primary,
    this.shape = ButtonShape.standard,
    this.margin,
    this.padding,
    this.onPressed,
    this.autofocus,
    this.borderRadius,
    this.canRequestFocus,
    this.customBorder,
    this.enableFeedback,
    this.excludeFromSemantics,
    this.focusColor,
    this.focusNode,
    this.highlightColor,
    this.hoverColor,
    this.onFocusChange,
    this.onHighlightChanged,
    this.onHover,
    this.borderThickness,
  })  : assert(
            (child != null && text == null) || (child == null && text != null),
            "Use either child or text"),
        super(key: key);

  Color getColor(LiquidThemeData themeData) {
    final bg = themeData.buttonColors;

    switch (type) {
      case ButtonType.secondary:
        return bg.secondaryColor;
        break;
      case ButtonType.success:
        return bg.success;
        break;
      case ButtonType.danger:
        return bg.danger;
        break;
      case ButtonType.info:
        return bg.info;
        break;
      case ButtonType.warning:
        return bg.warning;
        break;
      case ButtonType.light:
        return bg.light;
        break;
      case ButtonType.dark:
        return bg.dark;
        break;

      case ButtonType.primary:
      default:
        return bg.primaryColor;
        break;
    }
  }

  double _getRadius() {
    switch (shape) {
      case ButtonShape.circular:
        return 1000.0;
        break;
      case ButtonShape.standard:
      default:
        return 2.0;
    }
  }

  ShapeBorder _getShape(LiquidThemeData themeData, Color color) {
    return RoundedRectangleBorder(
        borderRadius: borderRadius ?? BorderRadius.circular(_getRadius()),
        side: BorderSide(width: borderThickness ?? 1.0, color: color));
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final _color = color ?? getColor(theme);
    final _shape = _getShape(theme, _color);

    return Container(
      margin: margin ?? theme.buttonTheme.margin,
      child: Material(
        color: onPressed == null ? _color.withOpacity(0.6) : _color,
        shape: _shape,
        elevation: elevation,
        child: InkWell(
          autofocus: autofocus,
          borderRadius: borderRadius ?? BorderRadius.circular(_getRadius()),
          canRequestFocus: canRequestFocus,
          customBorder: customBorder,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusColor: focusColor,
          focusNode: focusNode,
          highlightColor: _color.darken(0.05),
          onFocusChange: onFocusChange,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          onTap: onPressed,
          child: Padding(
              padding: padding ??
                  (small
                      ? theme.buttonTheme.smallPadding
                      : theme.buttonTheme.padding),
              child: _buildChild(theme, textColor ?? Colors.white)),
        ),
      ),
    );
  }

  Widget _buildChild(LiquidThemeData theme, Color color) {
    if (text != null) {
      return Text(
        text,
        textAlign: TextAlign.center,
        style: (small
                ? theme.typographyTheme.small.size(10.0)
                : theme.typographyTheme.p)
            .withColor(color)
            .weight(FontWeight.w500),
      );
    }
    return child;
  }
}

class LOutlineButton extends LButton {
  final ShapeBorder border;

  const LOutlineButton({
    Key key,
    this.border,
    Widget child,
    Color color,
    String text,
    Color textColor,
    double elevation = 0.0,
    bool small = false,
    ButtonType type = ButtonType.primary,
    ButtonShape shape = ButtonShape.standard,
    EdgeInsets margin,
    EdgeInsets padding,
    Function onPressed,
    bool autofocus,
    BorderRadius borderRadius,
    bool canRequestFocus,
    bool enableFeedback,
    bool excludeFromSemantics,
    Color focusColor,
    FocusNode focusNode,
    Color highlightColor,
    Color hoverColor,
    Function onFocusChange,
    Function onHighlightChanged,
    Function onHover,
    double borderThickness,
  })  : assert(
            (child != null && text == null) || (child == null && text != null),
            "Use either child or text"),
        super(
          key: key,
          child: child,
          elevation: elevation,
          small: small,
          text: text,
          textColor: textColor,
          color: color,
          type: type,
          shape: shape,
          margin: margin,
          padding: padding,
          onPressed: onPressed,
          autofocus: autofocus,
          borderRadius: borderRadius,
          canRequestFocus: canRequestFocus,
          customBorder: null,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusColor: focusColor,
          focusNode: focusNode,
          highlightColor: highlightColor,
          hoverColor: hoverColor,
          onFocusChange: onFocusChange,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          borderThickness: borderThickness,
        );

  @override
  ShapeBorder _getShape(LiquidThemeData themeData, Color color) {
    return RoundedRectangleBorder(
      borderRadius: borderRadius ?? BorderRadius.circular(_getRadius()),
      side: BorderSide(width: borderThickness ?? 1.0, color: color),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final _color =
        (color ?? getColor(theme)).lighten(onPressed != null ? 0.0 : 0.05);
    final _shape = _getShape(theme, _color);

    return Container(
      margin: margin ?? theme.buttonTheme.margin,
      child: Material(
        borderOnForeground: true,
        shape: border ?? _shape,
        elevation: elevation,
        child: InkWell(
          autofocus: autofocus,
          borderRadius: borderRadius == null
              ? BorderRadius.circular(_getRadius())
              : borderRadius,
          canRequestFocus: canRequestFocus,
          enableFeedback: enableFeedback,
          excludeFromSemantics: excludeFromSemantics,
          focusColor: focusColor,
          focusNode: focusNode,
          highlightColor: _color.withOpacity(0.1),
          onFocusChange: onFocusChange,
          onHighlightChanged: onHighlightChanged,
          onHover: onHover,
          onTap: onPressed,
          child: Padding(
              padding: padding ??
                  (small
                      ? theme.buttonTheme.smallPadding
                      : theme.buttonTheme.padding),
              child: _buildChild(theme, textColor ?? _color)),
        ),
      ),
    );
  }
}
