import 'package:flutter/material.dart';

import '../../base/base.dart';

/// Create a single Item of the BreadCrumb widget
class LBreadCrumbItem extends StatelessWidget {
  /// It indicates the current active selection
  final bool active;

  /// OnTapCallback
  final Function onTap;

  /// text Color
  final Color color;

  /// To display the active breadCrumbs with required color
  final Color activeColor;

  /// To display widget ahead of other
  final Widget leading;

  final String text;

  /// Create a single Item of the BreadCrumb widget
  ///
  ///
  ///Example:
  ///```
  ///...
  /// LBreadCrumbItem(
  ///       "Data",
  ///       active: true,
  ///       onTap:(){}
  ///     ),
  ///...
  ///```
  ///
  ///
  const LBreadCrumbItem(
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
    final _baseStyle = DefaultTextStyle.of(context).style;
    return GestureDetector(
      onTap: active ? null : onTap,
      child: _buildChild(theme, _baseStyle),
    );
  }

  Widget _buildChild(LiquidThemeData theme, TextStyle style) {
    final _text = Text(
      text,
      style: (active
          ? style.withColor(activeColor ?? theme.colors.secondary)
          : style.withColor(color ?? theme.colors.primary)),
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

/// Create a BreadCrumb widget
class LBreadCrumbs extends StatelessWidget {
  /// Holds list of items of type [LBreadCrumbItem]
  final List<LBreadCrumbItem> items;

  /// To show a [Widget] type `seperator` betwwen [LBreadCrumbItem]
  final Widget seperator;

  /// To display space or gap between `seperator` and `widget`
  final double spacing;

  /// Create a BreadCrumb widget
  ///
  ///
  ///Example:
  ///```
  ///...
  ///LBreadCrumbs(
  ///   items: [
  ///     LBreadCrumbItem(
  ///       "Home",
  ///       onTap: () {},
  ///     ),
  ///     LBreadCrumbItem(
  ///       "Library",
  ///       onTap: () {},
  ///     ),
  ///     LBreadCrumbItem(
  ///       "Data",
  ///       active: true,
  ///     ),
  ///   ],
  /// ),
  ///
  ///...
  ///```
  ///
  ///

  const LBreadCrumbs({
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
