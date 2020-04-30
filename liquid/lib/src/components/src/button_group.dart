import 'package:flutter/material.dart';

import '../../base/base.dart';
import 'buttons.dart';

class LGroupButton {
  final Color textColor;
  final Color color;
  final String text;
  final ButtonType type;
  final Widget child;
  final Function onPressed;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final Color focusColor;
  final FocusNode focusNode;
  final Color highlightColor;
  final Color hoverColor;
  final Function onFocusChange;
  final Function onHighlightChanged;
  final Function onHover;

  /// create an outline button
  final bool outline;

  LGroupButton({
    this.textColor,
    this.color,
    this.text,
    this.type,
    this.child,
    this.onPressed,
    this.enableFeedback,
    this.excludeFromSemantics,
    this.focusColor,
    this.focusNode,
    this.highlightColor,
    this.hoverColor,
    this.onFocusChange,
    this.onHighlightChanged,
    this.onHover,
    this.outline,
  });
}

class LButtonGroup extends StatelessWidget {
  final Color textColor;
  final Color color;
  final ButtonType type;
  final ButtonShape shape;
  final double elevation;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final bool enableFeedback;
  final bool excludeFromSemantics;
  final Color focusColor;
  final Color highlightColor;
  final Color hoverColor;
  final bool small;
  final Axis direction;
  final List<LGroupButton> children;
  final double radius;
  final double borderThickness;
  final bool outline;

  const LButtonGroup({
    Key key,
    this.textColor,
    this.color,
    this.type,
    this.shape,
    this.elevation,
    this.margin,
    this.padding,
    this.enableFeedback,
    this.excludeFromSemantics,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.small = false,
    this.direction = Axis.horizontal,
    this.children,
    this.radius = 3.0,
    this.borderThickness = 0.0,
    this.outline = false,
  })  : assert(children != null && children.length >= 2),
        super(key: key);

  Color _getColor(LiquidThemeData themeData) {
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

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final _color = _getColor(theme);

    return Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(width: borderThickness, color: _color),
      ),
      child: IntrinsicWidth(
        child: Flex(
          children: _buildButtons(),
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: direction == Axis.vertical
              ? CrossAxisAlignment.stretch
              : CrossAxisAlignment.center,
        ),
      ),
    );
  }

  List<Widget> _buildButtons() {
    final first = _buildFirstButton();
    final List<Widget> mid = _buildMidbuttons();
    final last = _buildLastButton();

    final List<Widget> _groups = [];
    _groups.add(first);
    _groups.addAll(mid);
    _groups.add(last);

    return _groups;
  }

  Widget _applyStyle(LGroupButton defination, int position) {
    BorderRadius _r;

    if (position == 0) {
      if (direction == Axis.horizontal) {
        _r = BorderRadius.only(
          topLeft:
              Radius.circular(shape == ButtonShape.circular ? 1000 : radius),
          bottomLeft:
              Radius.circular(shape == ButtonShape.circular ? 1000 : radius),
        );
      } else {
        _r = BorderRadius.only(
          topLeft:
              Radius.circular(shape == ButtonShape.circular ? 1000 : radius),
          topRight:
              Radius.circular(shape == ButtonShape.circular ? 1000 : radius),
        );
      }
    } else if (position == -1) {
      if (direction == Axis.horizontal) {
        _r = BorderRadius.only(
          topRight:
              Radius.circular(shape == ButtonShape.circular ? 1000 : radius),
          bottomRight:
              Radius.circular(shape == ButtonShape.circular ? 1000 : radius),
        );
      } else {
        _r = BorderRadius.only(
          bottomRight:
              Radius.circular(shape == ButtonShape.circular ? 1000 : radius),
          bottomLeft:
              Radius.circular(shape == ButtonShape.circular ? 1000 : radius),
        );
      }
    } else {
      _r = BorderRadius.zero;
    }

    if (defination.outline ?? outline) {
      return LOutlineButton(
        textColor: textColor,
        color: defination.color ?? color,
        text: defination.text,
        type: defination.type ?? type,
        child: defination.child,
        onPressed: defination.onPressed,
        enableFeedback: enableFeedback,
        excludeFromSemantics: excludeFromSemantics,
        focusColor: focusColor,
        focusNode: defination.focusNode,
        highlightColor: defination.highlightColor ?? highlightColor,
        hoverColor: defination.hoverColor ?? hoverColor,
        onFocusChange: defination.onFocusChange,
        onHighlightChanged: defination.onHighlightChanged,
        onHover: defination.onHover,
        padding: padding,
        margin: EdgeInsets.zero,
        small: small,
        borderRadius: _r,
        borderThickness: borderThickness / 2,
      );
    } else {
      return LButton(
        textColor: textColor,
        color: defination.color ?? color,
        text: defination.text,
        type: defination.type ?? type,
        child: defination.child,
        onPressed: defination.onPressed,
        enableFeedback: enableFeedback,
        excludeFromSemantics: excludeFromSemantics,
        focusColor: focusColor,
        focusNode: defination.focusNode,
        highlightColor: defination.highlightColor ?? highlightColor,
        hoverColor: defination.hoverColor ?? hoverColor,
        onFocusChange: defination.onFocusChange,
        onHighlightChanged: defination.onHighlightChanged,
        onHover: defination.onHover,
        padding: padding,
        margin: EdgeInsets.zero,
        small: small,
        borderRadius: _r,
        borderThickness: borderThickness,
      );
    }
  }

  Widget _buildFirstButton() {
    final firstItem = children.first;
    return _applyStyle(firstItem, 0);
  }

  Widget _buildLastButton() {
    final lastItem = children.last;
    return _applyStyle(lastItem, -1);
  }

  List<Widget> _buildMidbuttons() {
    final List<Widget> _buttons = [];

    for (int i = 1; i < children.length - 1; i++) {
      final button = _applyStyle(children[i], i);
      _buttons.add(button);
    }

    return _buttons;
  }
}
