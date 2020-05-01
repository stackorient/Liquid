import 'package:flutter/material.dart';
import 'package:liquid/liquid.dart';

class LListItem extends StatelessWidget {
  final double height;
  final double width;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Decoration decoration;
  final Widget child;

  const LListItem(
      {Key key,
      this.height,
      this.width,
      this.padding,
      this.margin,
      this.decoration,
      this.child})
      : assert(child != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 40.0,
      width: width ?? 200,
      padding: padding ?? EdgeInsets.all(10.0),
      margin: margin ?? EdgeInsets.all(10.0),
      decoration: decoration ??
          BoxDecoration(
              border: Border.all(
                color: Colors.black12,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0)),
      child: child ?? Text('hello'),
    );
  }
}

class LListGroup extends StatelessWidget {
  final List<LListItem> children;
  final Color textColor;
  final Color color;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final Color focusColor;
  final Color highlightColor;
  final Color hoverColor;
  final Axis direction;
  final double radius;
  final double borderThickness;
  final bool outline;
  const LListGroup(
      {Key key,
      this.children,
      this.textColor,
      this.color,
      this.margin,
      this.padding,
      this.focusColor,
      this.highlightColor,
      this.hoverColor,
      this.direction,
      this.radius = 10.0,
      this.borderThickness,
      this.outline})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
        side: BorderSide(width: borderThickness, color: color),
      ),
      child: IntrinsicWidth(
        child: Flex(
          children: _buildListItems(),
          direction: direction,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: direction == Axis.vertical
              ? CrossAxisAlignment.stretch
              : CrossAxisAlignment.center,
        ),
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

  Widget _applyStyle(int position) {
    BorderRadius _r;

    if (position == 0) {
      if (direction == Axis.horizontal) {
        _r = BorderRadius.only(
          topLeft: Radius.circular(radius ?? 10.0),
          bottomLeft: Radius.circular(radius ?? 10.0),
        );
      } else {
        _r = BorderRadius.only(
          topLeft: Radius.circular(radius ?? 10.0),
          topRight: Radius.circular(radius ?? 10.0),
        );
      }
    } else if (position == -1) {
      if (direction == Axis.horizontal) {
        _r = BorderRadius.only(
          topRight: Radius.circular(radius),
          bottomRight: Radius.circular(radius),
        );
      } else {
        _r = BorderRadius.only(
          bottomRight: Radius.circular(radius),
          bottomLeft: Radius.circular(radius),
        );
      }
    } else {
      _r = BorderRadius.zero;
    }
    return LListItem(
      decoration: BoxDecoration(
        borderRadius: _r,
      ),
      child: Text('hello'),
      height: 40,
      width: 100,
    );
  }

  Widget _buildFirstListItem() {
    return _applyStyle(0);
  }

  Widget _buildLastListItem() {
    return _applyStyle(-1);
  }

  List<Widget> _buildMidListItem() {
    final List<Widget> _listItems = [];

    for (int i = 1; i < children.length - 1; i++) {
      final item = _applyStyle(i);
      _listItems.add(item);
    }

    return _listItems;
  }
}
