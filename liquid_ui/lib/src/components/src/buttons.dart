// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../base/base.dart';
import 'theme_ext/theme_ext.dart';

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
  final LElementType type;

  /// Button Shape
  ///
  /// See:
  /// * standard
  /// * pill
  final LElementShape shape;

  final LElementSize size;

  final void Function(PointerEnterEvent) onMouseEnter;
  final void Function(PointerExitEvent) onMouseExit;
  final void Function(PointerHoverEvent) onMouseHover;
  final VoidCallback onPressed;
  final VoidCallback onLongPress;
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
  final ShapeBorder buttonShape;

  final Duration animationDuration;
  final Clip clipBehavior;
  final FocusNode focusNode;
  final bool autofocus;
  final MaterialTapTargetSize materialTapTargetSize;
  final Widget child;
  final bool enableFeedback;

  const LButton({
    Key key,
    this.type = LElementType.primary,
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
    this.shape = LElementShape.standard,
    this.animationDuration = kThemeChangeDuration,
    this.clipBehavior = Clip.none,
    this.focusNode,
    this.autofocus = false,
    this.child,
    this.enableFeedback = true,
    this.onPressed,
    this.materialTapTargetSize,
    this.buttonShape,
    LElementSize size,
  })  : assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        assert(shape != null),
        assert(
          (shape == LElementShape.pill && buttonShape == null) ||
              (shape != LElementShape.pill),
          "buttonShape is not allowed in Pill Buttons",
        ),
        size = size ?? LElementSize.normal,
        super(
          key: key,
        );

  bool get enabled => onPressed != null || onLongPress != null;

  LButton copyWith({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BoxConstraints constraints,
    ShapeBorder buttonShape,
    MaterialTapTargetSize materialTapTargetSize,
    LElementShape shape,
    LElementSize size,
  }) =>
      LButton(
        type: this.type,
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
        size: size ?? this.size,
      );

  @override
  _LButtonState createState() => _LButtonState();
}

class _LButtonState extends State<LButton> {
  bool _hover;
  bool mouseOver;

  @override
  void initState() {
    super.initState();
    _hover = false;
  }

  @override
  Widget build(BuildContext context) {
    final LiquidThemeData _theme = LiquidTheme.of(context);
    final LiquidButtonTheme buttonTheme = _theme.buttonTheme;
    final _color = _theme.getTypeColor(widget.type);
    final _sizeFactor = _theme.getElementSizeFactor(widget.size);
    final Color _fillColor =
        widget.fillColor ?? buttonTheme.getFillColor(widget, _color);

    final _radius = _theme.getElementShape(shape: widget.shape);
    final _effectiveShape = buttonTheme.getShape(
      widget,
      _radius,
      _color,
      widthfactor: _sizeFactor,
    );

    final _defaultStyle = DefaultTextStyle.of(context).style;
    final _textStyle = buttonTheme
        .getTextStyle(widget, _defaultStyle.merge(_theme.typographyTheme.p),
            _color, _hover)
        .weight(FontWeight.w500);
    return MouseRegion(
      onEnter: _onMouseEnter,
      onExit: _onMouseExit,
      onHover: _onMouseHover,
      child: IconTheme(
        data: IconThemeData(
            color: (_textStyle ?? widget.textStyle).color,
            size: 20.0 * _sizeFactor),
        child: Container(
          margin: widget.margin ?? buttonTheme.margin,
          child: RawMaterialButton(
            onPressed: widget.onPressed,
            onLongPress: widget.onLongPress,
            onHighlightChanged: _onHighlightChanged,
            textStyle: (widget.enabled
                    ? widget.textStyle
                    : widget.disabledTextStyle) ??
                _textStyle.copyWith(
                    fontSize: _textStyle.fontSize * _sizeFactor),
            fillColor:
                (widget.enabled ? widget.fillColor : widget.disabledColor) ??
                    _fillColor,
            focusColor: widget.focusColor,
            hoverColor:
                widget.hoverColor ?? buttonTheme.getHoverColor(widget, _color),
            highlightColor: widget.highlightColor ??
                buttonTheme.getHighlightColor(widget, _color),
            splashColor: widget.splashColor,
            elevation: buttonTheme.getElevation(widget),
            focusElevation: buttonTheme.getFocusElevation(widget),
            hoverElevation: buttonTheme.getHoverElevation(widget),
            highlightElevation: buttonTheme.getHighlightElevation(widget),
            disabledElevation: 0.0,
            padding: widget.padding ?? buttonTheme.padding * _sizeFactor,
            visualDensity: widget.visualDensity ?? const VisualDensity(),
            constraints: BoxConstraints(
              minWidth: widget.constraints?.minWidth ?? 88.0 * _sizeFactor,
              minHeight: widget.constraints?.minHeight ?? 36.0 * _sizeFactor,
            ),
            shape: widget.buttonShape ?? _effectiveShape,
            animationDuration: kThemeChangeDuration,
            clipBehavior: Clip.antiAlias,
            focusNode: widget.focusNode,
            autofocus: widget.autofocus ?? false,
            materialTapTargetSize: widget.materialTapTargetSize ??
                MaterialTapTargetSize.shrinkWrap,
            child: widget.child,
            enableFeedback: widget.enableFeedback ?? true,
          ),
        ),
      ),
    );
  }

  void _onHover(bool _) {
    setState(() {
      _hover = _;
    });
  }

  void _onHighlightChanged(_) {
    _onHover(_);
    if (widget.onHighlightChanged != null) widget.onHighlightChanged(_);
  }

  void _onMouseHover(PointerHoverEvent _) {
    if (widget.onMouseHover != null) widget.onMouseHover(_);
  }

  void _onMouseExit(PointerExitEvent _) {
    if (widget.onMouseExit != null) widget.onMouseExit(_);
  }

  void _onMouseEnter(PointerEnterEvent _) {
    if (widget.onMouseEnter != null) widget.onMouseEnter(_);
  }
}

/// A button without elevation.
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
  ///     type: LElementType.success,
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
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    Widget child,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    LElementSize size,
  })  : assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        super(
          key: key,
          type: type,
          shape: shape,
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
          buttonShape: buttonShape,
          clipBehavior: clipBehavior,
          focusNode: focusNode,
          autofocus: autofocus,
          materialTapTargetSize: materialTapTargetSize,
          animationDuration: animationDuration,
          enableFeedback: enableFeedback,
          child: child,
          onPressed: onPressed,
          constraints: constraints,
          size: size,
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
  ///     type: LElementType.danger,
  ///   ),
  ///
  /// ...
  /// ```
  ///
  /// See Also:
  ///   * [LFlatButton], [LFlatButton.text]

  factory LFlatButton.icon({
    Key key,
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
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
    LElementSize size,
    double spacing,
  }) =>
      LFlatButton(
        type: type,
        shape: shape,
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
        buttonShape: buttonShape,
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
            SizedBox(width: spacing ?? 5.0),
            label,
          ],
        ),
        onPressed: onPressed,
        constraints: constraints,
        size: size,
      );

  ///[LFlatButton] with a text
  ///
  ///Example:
  ///```
  ///...
  ///LFlatButton.text(
  ///     text: "Dropdown",
  ///     onPressed: () {
  ///       _dropdown.currentState.toggleDropdown();
  ///     },
  ///     type: LElementType.warning,
  ///   ),
  /// ...
  /// ```
  /// See Also:
  ///   * [LFlatButton], [LFlatButton.icon]
  factory LFlatButton.text({
    Key key,
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required String text,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    LElementSize size,
  }) =>
      LFlatButton(
        type: type,
        shape: shape,
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
        buttonShape: buttonShape,
        clipBehavior: clipBehavior,
        focusNode: focusNode,
        autofocus: autofocus,
        materialTapTargetSize: materialTapTargetSize,
        animationDuration: animationDuration,
        enableFeedback: enableFeedback,
        child: Text(text),
        onPressed: onPressed,
        constraints: constraints,
        size: size,
      );

  @override
  LFlatButton copyWith({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BoxConstraints constraints,
    ShapeBorder buttonShape,
    MaterialTapTargetSize materialTapTargetSize,
    LElementShape shape,
    LElementSize size,
  }) =>
      LFlatButton(
        type: this.type,
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
        size: size ?? this.size,
      );
}

enum FillMode { transparent, solid, link }

/// Button with outline. [LOutlineButton]

class LOutlineButton extends LButton {
  final FillMode fillMode;

  /// [LOutlineButton]
  ///
  /// Example:
  /// ```
  /// ...
  /// LOutlineButton(
  ///     child: Text("hello"),
  ///     onPressed: () {},
  ///     type: LElementType.primary,
  ///   ),
  /// ...
  /// ```
  /// See Also:
  ///   * [LOutlineButton.icon], [LOutlineButton.text]
  const LOutlineButton({
    Key key,
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    Widget child,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    LElementSize size,
  })  : assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        super(
          key: key,
          type: type,
          buttonShape: buttonShape,
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
          size: size,
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
  ///     type: LElementType.light,
  ///     direction: Axis.vertical,
  ///     fillMode: FillMode.transparent,
  ///   ),/// ...
  /// ```
  ///See Also:
  /// * [LOutlineButton], [LOutlineButton.text]
  factory LOutlineButton.icon({
    Key key,
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
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
    LElementSize size,
    double spacing,
  }) =>
      LOutlineButton(
        type: type,
        shape: shape,
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
        buttonShape: buttonShape,
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
            SizedBox(width: spacing ?? 5.0),
            label,
          ],
        ),
        onPressed: onPressed,
        constraints: constraints,
        size: size,
      );

  ///[LOutlineButton] with text
  ///
  ///Example:
  ///```
  ///...
  /// LOutlineButton.text(
  ///   text: 'heee',
  /// ),
  /// ...
  /// ```
  ///
  ///See Also:
  /// * [LOutlineButton], [LOutlineButton.icon]
  factory LOutlineButton.text({
    Key key,
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required String text,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    LElementSize size,
  }) =>
      LOutlineButton(
        type: type,
        buttonShape: buttonShape,
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
        child: Text(text),
        onPressed: onPressed,
        constraints: constraints,
        size: size,
      );

  @override
  LOutlineButton copyWith({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BoxConstraints constraints,
    ShapeBorder buttonShape,
    MaterialTapTargetSize materialTapTargetSize,
    LElementShape shape,
    LElementSize size,
  }) =>
      LOutlineButton(
        type: this.type,
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
        size: size ?? this.size,
      );
}

enum LRaisedButtonPushAction { pushDown, elevate }

/// [LButton] with elevation
class LRaisedButton extends LButton {
  final LRaisedButtonPushAction pushAction;

  /// [LButton] with elevation
  ///
  ///Example:
  ///```
  ///...
  /// LRaisedButton(
  ///    child: Text("hello"),
  ///    onPressed: () {},
  ///    type: LElementType.danger,
  ///  ),
  /// ...
  /// ```
  ///See Also:
  /// * [LRaisedButton.icon], [LRaisedButton.text]
  const LRaisedButton({
    Key key,
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    Widget child,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    LElementSize size,
    this.pushAction = LRaisedButtonPushAction.elevate,
  })  : assert(animationDuration != null),
        assert(clipBehavior != null),
        assert(autofocus != null),
        assert(pushAction != null),
        super(
          key: key,
          type: type,
          buttonShape: buttonShape,
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
          size: size,
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
  ///    type: LElementType.light,
  ///    buttonShape: LElementShape.pill,
  ///  ),
  /// ...
  /// ```
  ///See Also:
  /// * [LRaisedButton], [LRaisedButton.text]
  factory LRaisedButton.icon({
    Key key,
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
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
    LElementSize size,
    double spacing,
    LRaisedButtonPushAction pushAction = LRaisedButtonPushAction.elevate,
  }) =>
      LRaisedButton(
        type: type,
        buttonShape: buttonShape,
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
            SizedBox(width: spacing ?? 5.0),
            label,
          ],
        ),
        onPressed: onPressed,
        constraints: constraints,
        size: size,
        pushAction: pushAction,
      );

  ///[LRaisedButton] with `text`
  ///
  ///Example:
  ///```
  ///...
  ///LRaisedButton.text(
  ///   text: "First",
  ///   onPressed: () {},
  ///),
  /// ...
  /// ```
  ///See Also:
  /// * [LRaisedButton], [LRaisedButton.icon]
  factory LRaisedButton.text({
    Key key,
    LElementType type,
    LElementShape shape = LElementShape.standard,
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
    ShapeBorder buttonShape,
    Duration animationDuration = kThemeChangeDuration,
    Clip clipBehavior = Clip.none,
    FocusNode focusNode,
    bool autofocus = false,
    @required String text,
    bool enableFeedback = true,
    void Function() onPressed,
    MaterialTapTargetSize materialTapTargetSize,
    LElementSize size,
    LRaisedButtonPushAction pushAction = LRaisedButtonPushAction.elevate,
  }) =>
      LRaisedButton(
        type: type,
        buttonShape: buttonShape,
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
        child: Text(text),
        onPressed: onPressed,
        constraints: constraints,
        size: size,
        pushAction: pushAction,
      );

  @override
  LRaisedButton copyWith({
    EdgeInsetsGeometry padding,
    EdgeInsetsGeometry margin,
    BoxConstraints constraints,
    ShapeBorder buttonShape,
    MaterialTapTargetSize materialTapTargetSize,
    LElementShape shape,
    LElementSize size,
  }) =>
      LRaisedButton(
        type: this.type,
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
        size: size ?? this.size,
        pushAction: this.pushAction,
      );
}

/// [LButton] with `icon`
class LIconButton extends StatelessWidget {
  final Icon icon;

  /// default: `24`
  final double iconSize;
  final Color disabledColor;

  /// Extra Splash length around the `icon`
  ///
  /// default: `10`
  final double splashThickness;
  final Color splashColor;
  final Color color;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color fillColor;
  final double radius;
  final EdgeInsetsGeometry margin;
  final void Function() onPressed;
  final void Function() onLongPress;
  final void Function() onDoubleTap;

  bool get enabled =>
      onPressed != null || onLongPress != null || onDoubleTap != null;

  /// [LButton] with `icon`
  ///
  /// Change the splash radius with `splashThickness`
  ///
  ///Example:
  ///```
  ///...
  ///LIconButton(
  ///  icon: Icon(Icons.ac_unit),
  ///  color: Colors.green,
  ///  onPressed: () {},
  ///  splashThickness: 10.0,
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
    this.fillColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.margin = EdgeInsets.zero,
    this.radius,
  })  : assert(splashThickness != null),
        assert(margin != null),
        assert(iconSize != null),
        assert(icon != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      alignment: Alignment.center,
      child: Material(
        borderRadius:
            BorderRadius.circular(radius ?? iconSize + splashThickness),
        type: MaterialType.button,
        color: fillColor ?? Colors.transparent,
        child: IconTheme(
          data: IconThemeData.fallback().copyWith(
              size: iconSize,
              color: enabled ? color : (disabledColor ?? Colors.grey)),
          child: InkWell(
            borderRadius:
                BorderRadius.circular(radius ?? iconSize + splashThickness),
            onTap: onPressed,
            onLongPress: onLongPress,
            onDoubleTap: onDoubleTap,
            splashColor:
                splashColor ?? (color ?? Colors.black).withOpacity(0.2),
            focusColor: focusColor,
            hoverColor: hoverColor,
            highlightColor: highlightColor,
            child: Padding(
              padding: EdgeInsets.all(splashThickness),
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
