import 'package:flutter/material.dart';

class LListItem extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Color textColor;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color disabledBackgroundColor;
  final Color selectedTextColor;
  final bool dense;
  final bool enabled;
  final bool selected;
  final bool isThreeLine;
  final EdgeInsets contentPadding;
  final void Function() onTap;
  final void Function() onLongPress;

  const LListItem({
    Key key,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.isThreeLine = false,
    this.dense,
    this.contentPadding,
    this.enabled = true,
    this.onTap,
    this.onLongPress,
    this.selected = false,
    this.selectedTextColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.textColor,
    this.disabledBackgroundColor,
  })  : assert(isThreeLine != null),
        assert(enabled != null),
        assert(selected != null),
        assert(!isThreeLine || subtitle != null),
        super(key: key);

  LListItem copyWith({
    Color textColor,
    Color backgroundColor,
    Color selectedBackgroundColor,
    Color disabledBackgroundColor,
    Color selectedTextColor,
    bool dense,
    EdgeInsets padding,
  }) =>
      LListItem(
        key: this.key,
        leading: this.leading,
        title: this.title,
        subtitle: this.subtitle,
        trailing: this.trailing,
        isThreeLine: this.isThreeLine,
        dense: dense ?? this.dense,
        contentPadding: padding ?? this.contentPadding,
        enabled: this.enabled,
        onTap: this.onTap,
        onLongPress: this.onLongPress,
        selected: this.selected,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        textColor: textColor ?? this.textColor,
        selectedBackgroundColor:
            selectedBackgroundColor ?? this.selectedBackgroundColor,
        disabledBackgroundColor:
            disabledBackgroundColor ?? this.disabledBackgroundColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
      );

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled
          ? (selected ? selectedBackgroundColor : backgroundColor)
          : disabledBackgroundColor,
      child: ListTileTheme(
        selectedColor: selectedTextColor,
        textColor: textColor,
        child: ListTile(
          leading: leading,
          title: title,
          subtitle: subtitle,
          trailing: trailing,
          isThreeLine: isThreeLine,
          dense: dense,
          contentPadding: contentPadding,
          enabled: enabled,
          onTap: onTap,
          onLongPress: onLongPress,
          selected: selected,
        ),
      ),
    );
  }
}

class LListGroup extends StatelessWidget {
  final List<LListItem> children;
  final Color borderColor;
  final EdgeInsets margin;
  final Color focusColor;
  final Color highlightColor;
  final Color hoverColor;
  final Axis direction;
  final double radius;
  final double borderWidth;
  final bool flush;
  final Color textColor;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color disabledBackgroundColor;
  final Color selectedTextColor;
  final EdgeInsets itemContentPadding;
  final bool dense;

  const LListGroup({
    Key key,
    @required this.children,
    this.borderColor,
    this.margin,
    this.focusColor,
    this.highlightColor,
    this.hoverColor,
    this.direction = Axis.vertical,
    this.radius = 3.0,
    this.borderWidth = 1.0,
    this.flush = false,
    this.textColor,
    this.backgroundColor,
    this.selectedBackgroundColor,
    this.disabledBackgroundColor,
    this.selectedTextColor,
    this.itemContentPadding,
    this.dense,
  })  : assert(radius != null && radius > -1),
        assert(borderWidth != null && borderWidth > -1),
        assert(flush != null),
        assert(children != null && children.length >= 2),
        assert(direction != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(flush ? 0 : radius),
        side: flush
            ? BorderSide.none
            : BorderSide(width: borderWidth, color: borderColor),
      ),
      child: Flex(
        children: _buildListItems(),
        direction: direction,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: direction == Axis.vertical
            ? CrossAxisAlignment.stretch
            : CrossAxisAlignment.center,
      ),
    );
  }

  List<Widget> _buildListItems() {
    final first = _buildFirstListItem();
    final List<Widget> mid = _buildMidListItem();
    final last = _buildLastListItem();

    final List<Widget> _groups = [];
    _groups.add(first);
    _groups.addAll(mid);
    _groups.add(last);

    return _groups;
  }

  Widget _applyBottomBorder({
    @required LListItem child,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: direction == Axis.vertical
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide.none,
          right: direction == Axis.horizontal
              ? BorderSide(color: borderColor, width: borderWidth)
              : BorderSide.none,
        ),
      ),
      child: child.copyWith(
        textColor: textColor,
        backgroundColor: backgroundColor,
        selectedBackgroundColor: selectedBackgroundColor,
        disabledBackgroundColor: disabledBackgroundColor,
        selectedTextColor: selectedTextColor,
        padding: itemContentPadding,
        dense: dense,
      ),
    );
  }

  Widget _buildFirstListItem() {
    final firstItem = children.first;
    final _borderRadius = BorderRadius.only(
      topRight: Radius.circular(direction == Axis.vertical ? radius : 0),
      topLeft: Radius.circular(radius),
      bottomLeft: Radius.circular(direction == Axis.vertical ? 0 : radius),
    );
    return Flexible(
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: _applyBottomBorder(child: firstItem),
      ),
    );
  }

  Widget _buildLastListItem() {
    final lastItem = children.last;
    final _borderRadius = BorderRadius.only(
      topRight: Radius.circular(direction == Axis.vertical ? 0 : radius),
      bottomRight: Radius.circular(radius),
      bottomLeft: Radius.circular(direction == Axis.vertical ? radius : 0),
    );
    return Flexible(
      child: ClipRRect(
        borderRadius: _borderRadius,
        child: lastItem.copyWith(
          textColor: textColor,
          backgroundColor: backgroundColor,
          selectedBackgroundColor: selectedBackgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          selectedTextColor: selectedTextColor,
          padding: itemContentPadding,
          dense: dense,
        ),
      ),
    );
  }

  List<Widget> _buildMidListItem() {
    final List<Widget> _listItems = [];

    for (int i = 1; i < children.length - 1; i++) {
      final item = Flexible(child: _applyBottomBorder(child: children[i]));
      _listItems.add(item);
    }

    return _listItems;
  }
}
