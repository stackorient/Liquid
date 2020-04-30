import 'package:flutter/material.dart';

import '../../base/base.dart';
import 'buttons.dart';
import 'theme/liquid_theme_extension.dart';

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
  final Axis direction;
  final List<LButton> children;
  final ButtonShape buttonShape;
  final double _radius;

  LButtonGroup({
    Key key,
    this.direction = Axis.horizontal,
    this.children,
    this.buttonShape,
    double radius = 3.0,
  })  : assert(children != null && children.length >= 2),
        assert(radius != null),
        _radius = buttonShape == ButtonShape.pill ? 1000 : radius,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final buttonTheme = LiquidTheme.of(context).buttonTheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(_radius),
      child: IntrinsicWidth(
        child: Flex(
          children: _buildButtons(buttonTheme),
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: direction == Axis.vertical
              ? CrossAxisAlignment.stretch
              : CrossAxisAlignment.center,
        ),
      ),
    );
  }

  List<Widget> _buildButtons(LiquidButtonTheme buttonTheme) {
    final first = _buildFirstButton(buttonTheme);
    final List<Widget> mid = _buildMidbuttons(buttonTheme);
    final last = _buildLastButton(buttonTheme);

    final List<Widget> _groups = [];
    _groups.add(first);
    _groups.addAll(mid);
    _groups.add(last);

    return _groups;
  }

  Widget _buildFirstButton(LiquidButtonTheme buttonTheme) {
    final button = children.first;

    return button.copyWith(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(direction == Axis.vertical ? _radius : 0),
          topLeft: Radius.circular(_radius),
          bottomLeft: Radius.circular(direction == Axis.vertical ? 0 : _radius),
        ),
        side: BorderSide.none,
      ),
      materialTapTargetSize: button is LRaisedButton
          ? MaterialTapTargetSize.padded
          : MaterialTapTargetSize.shrinkWrap,
      buttonShape: ButtonShape.standard,
    );
  }

  Widget _buildLastButton(LiquidButtonTheme buttonTheme) {
    final button = children.last;
    return button.copyWith(
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(direction == Axis.vertical ? 0 : _radius),
          bottomRight: Radius.circular(_radius),
          bottomLeft: Radius.circular(direction == Axis.vertical ? _radius : 0),
        ),
        side: BorderSide.none,
      ),
      materialTapTargetSize: button is LRaisedButton
          ? MaterialTapTargetSize.padded
          : MaterialTapTargetSize.shrinkWrap,
      buttonShape: ButtonShape.standard,
    );
  }

  List<Widget> _buildMidbuttons(LiquidButtonTheme buttonTheme) {
    final List<Widget> _buttons = [];

    for (int i = 1; i < children.length - 1; i++) {
      final button = children[i].copyWith(
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide.none,
        ),
        materialTapTargetSize: children[i] is LRaisedButton
            ? MaterialTapTargetSize.padded
            : MaterialTapTargetSize.shrinkWrap,
        buttonShape: ButtonShape.standard,
      );
      _buttons.add(button);
    }

    return _buttons;
  }
}
