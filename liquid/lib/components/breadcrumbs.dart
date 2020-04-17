import 'package:flutter/material.dart';
import 'package:liquid/base/base.dart';

class BreadCrumbItem extends StatelessWidget {
  final bool active;
  final Function onTap;
  final Color color;
  final Color activeColor;
  final Widget leading;
  final String text;

  const BreadCrumbItem(
    this.text, {
    Key key,
    this.active = false,
    this.onTap,
    this.color,
    this.activeColor,
    this.leading,
  })  : assert((!active && onTap != null) || (active),
            "For inactive items onTap Callback is required"),
        assert(text != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    return GestureDetector(
      onTap: active ? null : onTap,
      child: _buildChild(theme),
    );
  }

  Widget _buildChild(LiquidThemeData theme) {
    final _text = Text(
      text,
      style: active
          ? LTextStyle().withColor(color ?? theme.textColors.secondaryColor)
          : LTextStyle()
              .withColor(activeColor ?? theme.textColors.primaryColor),
    );

    if (leading != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          leading,
          SizedBox(width: 4),
          _text,
        ],
      );
    } else
      return _text;
  }
}

class BreadCrumbs extends StatelessWidget {
  final List<BreadCrumbItem> items;
  final Widget seperator;
  final double spacing;

  const BreadCrumbs({
    Key key,
    this.items = const [],
    this.spacing = 8.0,
    this.seperator = const Icon(
      Icons.chevron_right,
      size: 18.0,
    ),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _joinItems(),
      spacing: spacing,
      runSpacing: spacing,
      crossAxisAlignment: WrapCrossAlignment.center,
    );
  }

  List<Widget> _joinItems() {
    final List<Widget> _joinedItems = [];

    for (final item in items) {
      _joinedItems..add(item)..add(seperator);
    }

    _joinedItems.removeLast();

    return _joinedItems;
  }
}
