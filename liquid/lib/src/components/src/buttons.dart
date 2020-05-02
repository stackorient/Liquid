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
  ///  Button type
  ///
  /// See:
  /// * primary,
  /// * secondary,
  /// * success,
  /// * warning,
  /// * danger,
  /// * info,
  /// * light,
  /// * dark
  final ButtonType type;

  /// Button Shape
  ///
  /// See:
  /// * standard
  /// * pill
  final ButtonShape buttonShape;

  /// Reduces the button size from standard size
  final bool small;

  final void Function(PointerEnterEvent) onMouseEnter;
  final void Function(PointerExitEvent) onMouseExit;
  final void Function(PointerHoverEvent) onMouseHover;
  final void Function() onPressed;
  final void Function() onLongPress;
  final void Function(bool) onHighlightChanged;

  /// Styles Button text [LButton.text]
  final TextStyle textStyle;

  /// Disables text style
  final TextStyle disabledTextStyle;

  /// When Button disabled
  final Color disabledColor;

  /// Button background color
  final Color fillColor;

  /// Button Background color on focus
  final Color focusColor;

  /// Button Background color on hover
  final Color hoverColor;

  /// Button Background color for highlight
  final Color highlightColor;

  /// inkspread color
  final Color splashColor;

  /// Button elevation
  final double elevation;

  /// Button elevation on focus
  final double focusElevation;

  /// Button elevation on hover
  final double hoverElevation;

  /// Button elevation on highlight
  final double highlightElevation;

  /// Button elevation on disabled
  final double disabledElevation;

  /// Button Padding
  final EdgeInsetsGeometry padding;

  /// Button Margin
  final EdgeInsetsGeometry margin;

  /// Defines the visual density of user interface components.
  ///Density, in the context of a UI, is the vertical and horizontal "compactness" of the components in the UI.
  ///It is unitless, since it means different things to different UI components.
  ///
  ///The default for visual densities is zero for both vertical and horizontal densities,
  ///which corresponds to the default visual density of components in the Material Design specification.
  ///It does not affect text sizes, icon sizes, or padding values.
  ///
  ///For example, for buttons, it affects the spacing around the child of the button.
  ///For lists, it affects the distance between baselines of entries in the list.
  ///For chips, it only affects the vertical size, not the horizontal size.
  ///
  ///See also:
  ///[ThemeData.visualDensity], where this property is used to specify the base horizontal density of Material components.
  ///Material design guidance on density.
  final VisualDensity visualDensity;

  ///Immutable layout constraints for [RenderBox] layout.
  ///
  ///A [Size] respects a [BoxConstraints] if, and only if, all of the following relations hold:
  ///
  ///[minWidth] <= [Size.width] <= [maxWidth]
  ///[minHeight] <= [Size.height] <= [maxHeight]
  ///The constraints themselves must satisfy these relations:
  ///
  ///0.0 <= [minWidth] <= [maxWidth] <= [double.infinity]
  ///0.0 <= [minHeight] <= [maxHeight] <= [double.infinity]
  ///[double.infinity] is a legal value for each constraint.
  ///
  ///The box layout model
  ///Render objects in the Flutter framework are laid out by a one-pass layout model which walks down the render tree passing constraints,
  ///then walks back up the render tree passing concrete geometry.
  ///
  ///For boxes, the constraints are [BoxConstraints], which, as described herein,
  ///consist of four numbers: a minimum width [minWidth], a maximum width [maxWidth],
  ///a minimum height [minHeight], and a maximum height [maxHeight].

  ///The geometry for boxes consists of a [Size],
  ///which must satisfy the constraints described above.
  ///
  ///Each [RenderBox] (the objects that provide the layout models for box widgets) receives [BoxConstraints] from its parent,
  ///then lays out each of its children, then picks a [Size] that satisfies the [BoxConstraints].
  ///
  ///Render objects position their children independently of laying them out.
  ///Frequently, the parent will use the children's sizes to determine their position.
  ///A child does not know its position and will not necessarily be laid out again, or repainted, if its position changes.
  ///
  ///Terminology
  ///When the minimum constraints and the maximum constraint in an axis are the same,
  ///that axis is tightly constrained.
  ///
  ///See:
  ///
  ///[ BoxConstraints.tightFor], [ BoxConstraints.tightForFinite], [tighten], [hasTightWidth], [hasTightHeight], [isTight].
  ///
  ///An axis with a minimum constraint of 0.0 is loose (regardless of the maximum constraint; if it is also 0.0,
  /// then the axis is simultaneously tight and loose!). See: [ BoxConstraints.loose], [loosen].
  ///
  ///An axis whose maximum constraint is not infinite is bounded. See: [hasBoundedWidth],
  /// [hasBoundedHeight].
  ///
  ///An axis whose maximum constraint is infinite is unbounded. An axis is expanding if
  /// it is tightly infinite (its minimum and maximum constraints are both infinite). See: [ BoxConstraints.expand].
  ///
  ///An axis whose minimum constraint is infinite is just said to be infinite (since by
  /// definition the maximum constraint must also be infinite in that case). See: [hasInfiniteWidth], [hasInfiniteHeight].
  ///
  ///A size is constrained when it satisfies a [BoxConstraints] description.
  ///
  ///See:
  ///[constrain], [constrainWidth], [constrainHeight], [constrainDimensions], [constrainSizeAndAttemptToPreserveAspectRatio], [isSatisfiedBy].
  ///
  ///
  final BoxConstraints constraints;

  ///Base class for shape outlines.
  ///
  ///This class handles how to add multiple borders together. Subclasses define various shapes,
  ///like circles ([CircleBorder]), rounded rectangles ([RoundedRectangleBorder]), continuous rectangles ([ContinuousRectangleBorder]), or beveled rectangles ([BeveledRectangleBorder]).
  ///
  ///See also:
  ///
  /// * [ShapeDecoration], which can be used with [DecoratedBox] to show a shape.
  /// * [Material] (and many other widgets in the Material library), which takes a [ShapeBorder] to define its shape.
  /// * [NotchedShape], which describes a shape with a hole in it.
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
  /// A button without elevation.
  ///
  /// Example:
  ///
  /// ```
  /// ...
  ///
  ///  LFlatButton(
  ///     child: Text("hello"),
  ///     type: ButtonType.success,
  ///     onPressed: () {},
  ///   ),
  ///
  /// ...
  /// ```
  ///
  ///See Also:
  /// * [LFlatButton.icon], [LFlatButton.text]
  ///
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

  /// [LFlatButton] with an `icon` and a `label`.
  ///
  /// Example:
  ///
  /// ```
  /// ...
  ///
  /// LFlatButton.icon(
  ///     icon: Text("hello"),
  ///     label: LBadge.text(
  ///       "3",
  ///       type: BadgeType.danger,
  ///       shape: BadgeShape.pills,
  ///     ),
  ///     onPressed: () {},
  ///     type: ButtonType.danger,
  ///   ),
  ///
  /// ...
  /// ```
  ///
  /// See Also:
  ///   * [LFlatButton], [LFlatButton.text]

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

  ///[LFlatButton] with a text
  ///
  ///Example:
  ///```
  ///...
  ///LFlatButton.text(
  ///     small: true,
  ///     text: "Dropdown",
  ///     onPressed: () {
  ///       _dropdown.currentState.toggleDropdown();
  ///     },
  ///     type: ButtonType.warning,
  ///   ),
  /// ...
  /// ```
  /// See Also:
  ///   * [LFlatButton], [LFlatButton.icon]
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

/// [LOutlineButton]
///
/// Example:
/// ```
/// ...
/// LOutlineButton(
///     child: Text("hello"),
///     onPressed: () {},
///     type: ButtonType.primary,
///   ),
/// ...
/// ```
/// See Also:
///   * [LOutlineButton.icon], [LOutlineButton.text]
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

  ///[LOutlineButton] with `icon`
  ///
  ///Example:
  ///```
  ///...
  /// LOutlineButton.icon(
  ///     icon: Icon(Icons.ac_unit),
  ///     label: Text("hello"),
  ///     onPressed: () {},
  ///     type: ButtonType.light,
  ///     direction: Axis.vertical,
  ///     // small: true,
  ///     fillMode: FillMode.transparent,
  ///   ),/// ...
  /// ```
  ///See Also:
  /// * [LOutlineButton], [LOutlineButton.text]
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

  ///[LOutlineButton] with text
  ///
  ///Example:
  ///```
  ///...
  /// LOutlineButton.text(
  ///   text: 'heee',
  ///   small: true,
  /// ),
  /// ...
  /// ```
  ///
  ///See Also:
  /// * [LOutlineButton], [LOutlineButton.icon]
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
  /// [LButton] with elevation
  ///
  ///Example:
  ///```
  ///...
  /// LRaisedButton(
  ///    child: Text("hello"),
  ///    onPressed: () {},
  ///    type: ButtonType.danger,
  ///  ),
  /// ...
  /// ```
  ///See Also:
  /// * [LRaisedButton.icon], [LRaisedButton.text]
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

  ///[LRaisedButton] with `icon` and `label`
  ///
  ///Example:
  ///```
  ///...
  ///LRaisedButton.icon(
  ///    icon: Icon(Icons.ac_unit),
  ///    label: Text("Hello"),
  ///    onPressed: () {},
  ///    type: ButtonType.light,
  ///    buttonShape: ButtonShape.pill,
  ///    small: true,
  ///  ),
  /// ...
  /// ```
  ///See Also:
  /// * [LRaisedButton], [LRaisedButton.text]
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

  ///[LRaisedButton] with `text`
  ///
  ///Example:
  ///```
  ///...
  ///LRaisedButton.text(
  ///   text: "First",
  ///   onPressed: () {},
  ///   small: true,
  ///),
  /// ...
  /// ```
  ///See Also:
  /// * [LRaisedButton], [LRaisedButton.icon]
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

  /// [LButton] with `icon`
  ///
  ///Example:
  ///```
  ///...
  ///LIconButton(
  ///  icon: Icon(Icons.ac_unit),
  ///  color: Colors.green,
  ///  onPressed: () {},
  ///  splashThickness: 010.0,
  ///),
  /// ...
  /// ```
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
