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

enum ButtonShape { standard, circular, pill }

class LNButton extends StatefulWidget {
  final ButtonType type;
  final ButtonShape buttonShape;
  final bool small;
  final void Function(PointerEnterEvent) onMouseEnter;
  final void Function(PointerExitEvent) onMouseExit;
  final void Function(PointerHoverEvent) onMouseHover;
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
  final EdgeInsetsGeometry margin;
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
    this.type = ButtonType.primary,
    this.small,
    this.onLongPress,
    this.onHighlightChanged,
    this.onMouseEnter,
    this.onMouseExit,
    this.onMouseHover,
    this.textStyle,
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.splashColor,
    this.elevation,
    this.focusElevation,
    this.hoverElevation,
    this.highlightElevation,
    this.disabledElevation,
    this.padding,
    this.margin,
    this.visualDensity = const VisualDensity(),
    this.constraints,
    this.shape,
    this.animationDuration = kThemeChangeDuration,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.child,
    this.enableFeedback = true,
    this.onPressed,
    this.materialTapTargetSize,
    this.buttonShape = ButtonShape.standard,
  })  : assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        assert(buttonShape != null),
        assert(
            (buttonShape == ButtonShape.pill && shape == null) ||
                (buttonShape != ButtonShape.pill),
            "shape is not allowed in Pill Buttons"),
        super(
          key: key,
        );

  @override
  _LNButtonState createState() => _LNButtonState();
}

class _LNButtonState extends State<LNButton> {
  bool hover;
  bool mouseOver;

  @override
  void initState() {
    super.initState();
    hover = false;
  }

  @override
  Widget build(BuildContext context) {
    final LiquidThemeData _theme = LiquidTheme.of(context);
    final LiquidButtonTheme buttonTheme = _theme.buttonTheme;
    return MouseRegion(
      onEnter: _onMouseEnter,
      onExit: _onMouseExit,
      onHover: _onMouseHover,
      child: IconTheme(
        data: IconThemeData(
          size: (widget.small ?? false) ? 16.0 : 24.0,
        ),
        child: Container(
          margin: widget.margin ??
              ((widget.small ?? false)
                  ? buttonTheme.smallMargin
                  : buttonTheme.margin),
          child: RawMaterialButton(
            onLongPress: widget.onLongPress,
            onHighlightChanged: _onHighlightChanged,
            textStyle:
                widget.textStyle ?? buttonTheme.getTextStyle(widget, hover),
            fillColor: widget.fillColor ?? buttonTheme.getFillColor(widget),
            focusColor: widget.focusColor ?? buttonTheme.getFocusColor(widget),
            hoverColor: widget.hoverColor ?? buttonTheme.getHoverColor(widget),
            highlightColor:
                widget.highlightColor ?? buttonTheme.getHighlightColor(widget),
            splashColor:
                widget.splashColor ?? buttonTheme.getSplashColor(widget),
            elevation: widget.elevation ?? buttonTheme.getElevation(widget),
            focusElevation:
                widget.focusElevation ?? buttonTheme.getFocusElevation(widget),
            hoverElevation:
                widget.hoverElevation ?? buttonTheme.getHoverElevation(widget),
            highlightElevation: widget.highlightElevation ??
                buttonTheme.getHighlightElevation(widget),
            disabledElevation: widget.disabledElevation ??
                buttonTheme.getDisabledElevation(widget),
            padding: (widget.small ?? false)
                ? buttonTheme.smallPadding
                : buttonTheme.padding,
            visualDensity: widget.visualDensity,
            shape: widget.shape ?? buttonTheme.getButtonShape(widget),
            clipBehavior: Clip.antiAlias,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            materialTapTargetSize: widget.materialTapTargetSize ??
                ((widget.small ?? false)
                    ? buttonTheme.smallMaterialTapTargetSize
                    : buttonTheme.materialTapTargetSize),
            animationDuration: Duration(milliseconds: 0),
            enableFeedback: widget.enableFeedback ?? true,
            child: widget.child,
            onPressed: widget.onPressed,
            constraints: widget.constraints ??
                buttonTheme.constraints *
                    ((widget.small ?? false) ? 0.75 : 1.0),
          ),
        ),
      ),
    );
  }

  void _onHover(bool _) {
    setState(() {
      hover = _;
    });
  }

  void _onHighlightChanged(_) {
    if (!kIsWeb) _onHover(_);
    if (widget.onHighlightChanged != null) widget.onHighlightChanged(_);
  }

  void _onMouseHover(PointerHoverEvent _) {
    _onHover(true);

    if (widget.onMouseHover != null) widget.onMouseHover(_);
  }

  void _onMouseExit(PointerExitEvent _) {
    _onHover(false);

    if (widget.onMouseExit != null) widget.onMouseExit(_);
  }

  void _onMouseEnter(PointerEnterEvent _) {
    _onHover(true);
    if (widget.onMouseEnter != null) widget.onMouseEnter(_);
  }
}

class LFlatButton extends LNButton {
  const LFlatButton({
    Key key,
    bool small,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    Widget child,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
  })  : assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        super(
          key: key,
          type: type,
          buttonShape: buttonShape,
          small: small,
          onMouseEnter: onMouseEnter,
          onMouseExit: onMouseExit,
          onMouseHover: onMouseHover,
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
          margin: margin,
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

  factory LFlatButton.icon({
    Key key,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    bool small,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required Widget icon,
    @required Widget label,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    Axis direction,
  }) =>
      LFlatButton(
        type: type,
        buttonShape: buttonShape,
        small: small,
        onMouseEnter: onMouseEnter,
        onMouseExit: onMouseExit,
        onMouseHover: onMouseHover,
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
        margin: margin,
        visualDensity: visualDensity,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        animationDuration: animationDuration,
        enableFeedback: enableFeedback,
        child: Flex(
          direction: direction ?? Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Transform.scale(
              scale: (small ?? false) ? 0.7 : 1.0,
              child: icon,
            ),
            SizedBox(width: (small ?? false) ? 4.0 : 8.0),
            label,
          ],
        ),
        onPressed: onPressed,
        constraints: constraints,
      );

  factory LFlatButton.text({
    Key key,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    bool small,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required String text,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
  }) =>
      LFlatButton(
        type: type,
        buttonShape: buttonShape,
        small: small,
        onMouseEnter: onMouseEnter,
        onMouseExit: onMouseExit,
        onMouseHover: onMouseHover,
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
        margin: margin,
        visualDensity: visualDensity,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        animationDuration: animationDuration,
        enableFeedback: enableFeedback,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed,
        constraints: constraints,
      );
}

enum FillMode { transparent, solid }

class LNOutlineButton extends LNButton {
  final FillMode fillMode;
  const LNOutlineButton({
    Key key,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    bool small,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    this.fillMode = FillMode.solid,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    Widget child,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
  })  : assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        super(
          key: key,
          type: type,
          buttonShape: buttonShape,
          small: small,
          onMouseEnter: onMouseEnter,
          onMouseExit: onMouseExit,
          onMouseHover: onMouseHover,
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
          margin: margin,
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

  factory LNOutlineButton.icon({
    Key key,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    bool small,
    FillMode fillMode = FillMode.solid,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required Widget icon,
    @required Widget label,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    Axis direction,
  }) =>
      LNOutlineButton(
        type: type,
        buttonShape: buttonShape,
        small: small,
        fillMode: fillMode,
        onMouseEnter: onMouseEnter,
        onMouseExit: onMouseExit,
        onMouseHover: onMouseHover,
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
        margin: margin,
        visualDensity: visualDensity,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        animationDuration: animationDuration,
        enableFeedback: enableFeedback,
        child: Flex(
          direction: direction ?? Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon,
            SizedBox(width: (small ?? false) ? 4.0 : 8.0),
            label,
          ],
        ),
        onPressed: onPressed,
        constraints: constraints,
      );

  factory LNOutlineButton.text({
    Key key,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    bool small,
    FillMode fillMode = FillMode.solid,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required String text,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
  }) =>
      LNOutlineButton(
        type: type,
        buttonShape: buttonShape,
        small: small,
        fillMode: fillMode,
        onMouseEnter: onMouseEnter,
        onMouseExit: onMouseExit,
        onMouseHover: onMouseHover,
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
        margin: margin,
        visualDensity: visualDensity,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        animationDuration: animationDuration,
        enableFeedback: enableFeedback,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed,
        constraints: constraints,
      );
}

class LRaisedButton extends LNButton {
  const LRaisedButton({
    Key key,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    bool small,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    Widget child,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
  })  : assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        super(
          key: key,
          type: type,
          buttonShape: buttonShape,
          small: small,
          onMouseEnter: onMouseEnter,
          onMouseExit: onMouseExit,
          onMouseHover: onMouseHover,
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
          margin: margin,
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

  factory LRaisedButton.icon({
    Key key,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    bool small,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required Widget icon,
    @required Widget label,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    Axis direction,
  }) =>
      LRaisedButton(
        type: type,
        buttonShape: buttonShape,
        small: small,
        onMouseEnter: onMouseEnter,
        onMouseExit: onMouseExit,
        onMouseHover: onMouseHover,
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
        margin: margin,
        visualDensity: visualDensity,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        animationDuration: animationDuration,
        enableFeedback: enableFeedback,
        child: Flex(
          direction: direction ?? Axis.horizontal,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            icon,
            SizedBox(width: (small ?? false) ? 4.0 : 8.0),
            label,
          ],
        ),
        onPressed: onPressed,
        constraints: constraints,
      );

  factory LRaisedButton.text({
    Key key,
    ButtonType type,
    ButtonShape buttonShape = ButtonShape.standard,
    bool small,
    void Function(PointerEnterEvent) onMouseEnter,
    void Function(PointerExitEvent) onMouseExit,
    void Function(PointerHoverEvent) onMouseHover,
    void Function() onLongPress,
    void Function(bool) onHighlightChanged,
    TextStyle textStyle,
    Color fillColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color splashColor,
    double elevation,
    double focusElevation,
    double hoverElevation,
    double highlightElevation,
    double disabledElevation,
    EdgeInsets padding,
    EdgeInsetsGeometry margin,
    VisualDensity visualDensity = const VisualDensity(),
    BoxConstraints constraints,
    ShapeBorder shape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required String text,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
  }) =>
      LRaisedButton(
        type: type,
        buttonShape: buttonShape,
        small: small,
        onMouseEnter: onMouseEnter,
        onMouseExit: onMouseExit,
        onMouseHover: onMouseHover,
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
        margin: margin,
        visualDensity: visualDensity,
        shape: shape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        animationDuration: animationDuration,
        enableFeedback: enableFeedback,
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
        onPressed: onPressed,
        constraints: constraints,
      );
}

class LIconButton extends StatelessWidget {
  final Icon icon;
  final double iconSize;
  final double splashThickness;
  final Color splashColor;
  final Color color;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final EdgeInsetsGeometry margin;
  final void Function() onPressed;
  final void Function() onLongPress;
  final void Function() onDoubleTap;

  const LIconButton({
    Key key,
    @required this.icon,
    this.onPressed,
    this.iconSize = 24.0,
    this.splashThickness = 10.0,
    this.onLongPress,
    this.onDoubleTap,
    this.splashColor,
    this.color,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.margin = EdgeInsets.zero,
  })  : assert(splashThickness != null),
        assert(margin != null),
        assert(iconSize != null),
        assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: IconTheme(
        data: IconThemeData.fallback().copyWith(size: iconSize, color: color),
        child: InkWell(
          borderRadius: BorderRadius.circular(iconSize + splashThickness),
          onTap: onPressed,
          onLongPress: onLongPress,
          onDoubleTap: onDoubleTap,
          splashColor: splashColor ?? (color ?? Colors.black).withOpacity(0.2),
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          child: Padding(
            padding: EdgeInsets.all(splashThickness),
            child: icon,
          ),
        ),
      ),
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
    final bg = themeData.buttonTheme.buttonColors;

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
