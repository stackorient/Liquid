// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import '../../base/base.dart';

/// A Wrapper around [ListTile] to get additional features
class LListItem extends StatelessWidget {
  ///Add widget at the left-most position of [LListItem].
  final Widget leading;

  /// Add widget at `title` position.
  final Widget title;

  /// Add widget at `subTitle` position
  final Widget subtitle;

  /// Add widget to the right-most position of [LListItem]
  final Widget trailing;
  final Color textColor;

  /// Add background color to [LListItem]
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

  ///The most basic list group is an unordered list with list items [LListItem]
  /// and the proper classes.
  ///
  /// Example:
  ///
  /// ```
  /// ...
  /// LListItem(
  ///     title: Text("Item 1"),
  ///     trailing: LBadge.text("45"),
  ///     onTap: () {},
  ///  ),
  /// ...
  /// ```
  /// See:
  /// * [LListGroup]
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
    final _theme = LiquidTheme.of(context).colors;

    return Material(
      color: enabled
          ? (selected
              ? (selectedBackgroundColor ?? _theme.primary)
              : (backgroundColor ?? _theme.white))
          : disabledBackgroundColor,
      child: ListTileTheme(
        selectedColor: selectedTextColor ?? _theme.white,
        textColor: textColor ?? Colors.black,
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

/// List groups are a flexible and powerful component for displaying a series of content.
///  Modify and extend them to support just about any content within.
class LListGroup extends StatelessWidget {
  /// List of [LListItem]
  final List<LListItem> children;

  /// Add border color to [LListGroup]
  final Color borderColor;

  final EdgeInsets margin;

  /// Display color on focus
  final Color focusColor;

  /// Display color on highlight
  final Color highlightColor;

  /// Display color on hover
  final Color hoverColor;

  final Axis direction;
  final double radius;
  final double borderWidth;

  /// Removes border to the list group except the seperating border
  final bool flush;

  final Color textColor;
  final Color backgroundColor;
  final Color selectedBackgroundColor;
  final Color disabledBackgroundColor;
  final Color selectedTextColor;
  final EdgeInsets itemContentPadding;
  final bool dense;

  /// List groups are a flexible and powerful component for displaying a series of content.
  ///  Modify and extend them to support just about any content within.
  ///
  /// Example:
  /// ```
  /// ...
  /// LListGroup(
  ///   borderColor: Colors.black12,
  ///   borderWidth: 1,
  ///   direction: Axis.vertical,
  ///   selectedTextColor: Colors.white,
  ///   selectedBackgroundColor: Colors.blue[700],
  ///   disabledBackgroundColor: Colors.grey[300],
  ///   dense: true,
  ///   children: [
  ///     LListItem(
  ///       title: Text("Item 1"),
  ///       selected: true,
  ///     ),
  ///     LListItem(
  ///       title: Text("Item 1"),
  ///       trailing: LBadge.text("45"),
  ///       onTap: () {},
  ///     ),
  ///     LListItem(
  ///       title: Text("Item 2"),
  ///     ),
  ///   ],
  /// ),
  /// ...
  /// ```
  ///
  /// See:
  /// * [LListItem]
  ///

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
            : BorderSide(
                width: borderWidth,
                color: (borderColor ?? Colors.black12),
              ),
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
              ? BorderSide(
                  color: (borderColor ?? Colors.black12), width: borderWidth)
              : BorderSide.none,
          right: direction == Axis.horizontal
              ? BorderSide(
                  color: (borderColor ?? Colors.black12), width: borderWidth)
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
