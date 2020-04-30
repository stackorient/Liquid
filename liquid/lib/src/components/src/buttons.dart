import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:liquid/components.dart';

import '../../base/base.dart';
import 'theme/liquid_theme_extension.dart';

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

enum ButtonShape { standard, pill }

class LButton extends StatefulWidget {
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
  final TextStyle disabledTextStyle;
  final Color disabledColor;
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

  const LButton({
    Key key,
    this.type = ButtonType.primary,
    this.small,
    this.onLongPress,
    this.onHighlightChanged,
    this.onMouseEnter,
    this.onMouseExit,
    this.onMouseHover,
    this.textStyle,
    this.disabledTextStyle,
    this.disabledColor,
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

  bool get enabled => onPressed != null || onLongPress != null;

  LButton copyWith({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BoxConstraints constraints,
    ShapeBorder shape,
    MaterialTapTargetSize materialTapTargetSize,
    ButtonShape buttonShape,
  }) =>
      LButton(
        type: this.type,
        small: this.small,
        onLongPress: this.onLongPress,
        onHighlightChanged: this.onHighlightChanged,
        onMouseEnter: this.onMouseEnter,
        onMouseExit: this.onMouseExit,
        onMouseHover: this.onMouseHover,
        textStyle: this.textStyle,
        fillColor: this.fillColor,
        focusColor: this.focusColor,
        hoverColor: this.hoverColor,
        highlightColor: this.highlightColor,
        splashColor: this.splashColor,
        elevation: this.elevation,
        focusElevation: this.focusElevation,
        hoverElevation: this.hoverElevation,
        highlightElevation: this.highlightElevation,
        disabledElevation: this.disabledElevation,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        visualDensity: this.visualDensity,
        constraints: constraints ?? this.constraints,
        shape: shape ?? this.shape,
        animationDuration: this.animationDuration,
        clipBehavior: this.clipBehavior,
        focusNode: this.focusNode,
        autofocus: this.autofocus,
        child: this.child,
        enableFeedback: this.enableFeedback,
        onPressed: this.onPressed,
        materialTapTargetSize:
            materialTapTargetSize ?? this.materialTapTargetSize,
        buttonShape: buttonShape ?? this.buttonShape,
      );

  @override
  _LButtonState createState() => _LButtonState();
}

class _LButtonState extends State<LButton> {
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
            textStyle: (widget.enabled
                    ? widget.textStyle
                    : widget.disabledTextStyle) ??
                buttonTheme.getTextStyle(widget, hover),
            fillColor:
                (widget.enabled ? widget.fillColor : widget.disabledColor) ??
                    buttonTheme.getFillColor(widget),
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
            padding: widget.padding ??
                ((widget.small ?? false)
                    ? buttonTheme.smallPadding
                    : buttonTheme.padding),
            visualDensity: widget.visualDensity,
            shape: widget.shape ?? buttonTheme.getButtonShape(widget),
            clipBehavior: Clip.antiAlias,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus,
            materialTapTargetSize: widget.materialTapTargetSize ??
                ((widget.small ?? false)
                    ? buttonTheme.smallMaterialTapTargetSize
                    : buttonTheme.materialTapTargetSize),
            animationDuration: Duration(milliseconds: 120),
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

class LFlatButton extends LButton {
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
          disabledColor: disabledColor,
          disabledTextStyle: disabledTextStyle,
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
        disabledColor: disabledColor,
        disabledTextStyle: disabledTextStyle,
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
        disabledColor: disabledColor,
        disabledTextStyle: disabledTextStyle,
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

  @override
  LFlatButton copyWith({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BoxConstraints constraints,
    ShapeBorder shape,
    MaterialTapTargetSize materialTapTargetSize,
    ButtonShape buttonShape,
  }) =>
      LFlatButton(
        type: this.type,
        small: this.small,
        onLongPress: this.onLongPress,
        onHighlightChanged: this.onHighlightChanged,
        onMouseEnter: this.onMouseEnter,
        onMouseExit: this.onMouseExit,
        onMouseHover: this.onMouseHover,
        textStyle: this.textStyle,
        disabledColor: this.disabledColor,
        disabledTextStyle: this.disabledTextStyle,
        fillColor: this.fillColor,
        focusColor: this.focusColor,
        hoverColor: this.hoverColor,
        highlightColor: this.highlightColor,
        splashColor: this.splashColor,
        elevation: this.elevation,
        focusElevation: this.focusElevation,
        hoverElevation: this.hoverElevation,
        highlightElevation: this.highlightElevation,
        disabledElevation: this.disabledElevation,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        visualDensity: this.visualDensity,
        constraints: constraints ?? this.constraints,
        shape: shape ?? this.shape,
        animationDuration: this.animationDuration,
        clipBehavior: this.clipBehavior,
        focusNode: this.focusNode,
        autofocus: this.autofocus,
        child: this.child,
        enableFeedback: this.enableFeedback,
        onPressed: this.onPressed,
        materialTapTargetSize:
            materialTapTargetSize ?? this.materialTapTargetSize,
        buttonShape: buttonShape ?? this.buttonShape,
      );
}

enum FillMode { transparent, solid }

class LOutlineButton extends LButton {
  final FillMode fillMode;
  const LOutlineButton({
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
          disabledColor: disabledColor,
          disabledTextStyle: disabledTextStyle,
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

  factory LOutlineButton.icon({
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
      LOutlineButton(
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
        disabledColor: disabledColor,
        disabledTextStyle: disabledTextStyle,
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

  factory LOutlineButton.text({
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
      LOutlineButton(
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
        disabledColor: disabledColor,
        disabledTextStyle: disabledTextStyle,
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

  @override
  LOutlineButton copyWith({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BoxConstraints constraints,
    ShapeBorder shape,
    MaterialTapTargetSize materialTapTargetSize,
    ButtonShape buttonShape,
  }) =>
      LOutlineButton(
        type: this.type,
        small: this.small,
        onLongPress: this.onLongPress,
        onHighlightChanged: this.onHighlightChanged,
        onMouseEnter: this.onMouseEnter,
        onMouseExit: this.onMouseExit,
        onMouseHover: this.onMouseHover,
        textStyle: this.textStyle,
        disabledColor: this.disabledColor,
        disabledTextStyle: this.disabledTextStyle,
        fillColor: this.fillColor,
        focusColor: this.focusColor,
        hoverColor: this.hoverColor,
        highlightColor: this.highlightColor,
        splashColor: this.splashColor,
        elevation: this.elevation,
        focusElevation: this.focusElevation,
        hoverElevation: this.hoverElevation,
        highlightElevation: this.highlightElevation,
        disabledElevation: this.disabledElevation,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        visualDensity: this.visualDensity,
        constraints: constraints ?? this.constraints,
        shape: shape ?? this.shape,
        animationDuration: this.animationDuration,
        clipBehavior: this.clipBehavior,
        focusNode: this.focusNode,
        autofocus: this.autofocus,
        child: this.child,
        enableFeedback: this.enableFeedback,
        onPressed: this.onPressed,
        materialTapTargetSize:
            materialTapTargetSize ?? this.materialTapTargetSize,
        buttonShape: buttonShape ?? this.buttonShape,
      );
}

class LRaisedButton extends LButton {
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
          disabledColor: disabledColor,
          disabledTextStyle: disabledTextStyle,
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
        disabledColor: disabledColor,
        disabledTextStyle: disabledTextStyle,
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
    TextStyle disabledTextStyle,
    Color disabledColor,
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
        disabledColor: disabledColor,
        disabledTextStyle: disabledTextStyle,
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

  @override
  LRaisedButton copyWith({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BoxConstraints constraints,
    ShapeBorder shape,
    MaterialTapTargetSize materialTapTargetSize,
    ButtonShape buttonShape,
  }) =>
      LRaisedButton(
        type: this.type,
        small: this.small,
        onLongPress: this.onLongPress,
        onHighlightChanged: this.onHighlightChanged,
        onMouseEnter: this.onMouseEnter,
        onMouseExit: this.onMouseExit,
        onMouseHover: this.onMouseHover,
        textStyle: this.textStyle,
        disabledColor: this.disabledColor,
        disabledTextStyle: this.disabledTextStyle,
        fillColor: this.fillColor,
        focusColor: this.focusColor,
        hoverColor: this.hoverColor,
        highlightColor: this.highlightColor,
        splashColor: this.splashColor,
        elevation: this.elevation,
        focusElevation: this.focusElevation,
        hoverElevation: this.hoverElevation,
        highlightElevation: this.highlightElevation,
        disabledElevation: this.disabledElevation,
        padding: padding ?? this.padding,
        margin: margin ?? this.margin,
        visualDensity: this.visualDensity,
        constraints: constraints ?? this.constraints,
        shape: shape ?? this.shape,
        animationDuration: this.animationDuration,
        clipBehavior: this.clipBehavior,
        focusNode: this.focusNode,
        autofocus: this.autofocus,
        child: this.child,
        enableFeedback: this.enableFeedback,
        onPressed: this.onPressed,
        materialTapTargetSize:
            materialTapTargetSize ?? this.materialTapTargetSize,
        buttonShape: buttonShape ?? this.buttonShape,
      );
}

class LIconButton extends StatelessWidget {
  final Icon icon;
  final double iconSize;
  final Color disabledColor;
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

  bool get enabled =>
      onPressed != null || onLongPress != null || onDoubleTap != null;

  const LIconButton({
    Key key,
    @required this.icon,
    this.onPressed,
    this.iconSize = 24.0,
    this.splashThickness = 10.0,
    this.onLongPress,
    this.onDoubleTap,
    this.disabledColor,
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
        data: IconThemeData.fallback().copyWith(
            size: iconSize,
            color: enabled ? color : (disabledColor ?? Colors.grey)),
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
