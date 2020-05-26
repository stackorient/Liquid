// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../../base/base.dart';

/// An expansion panel. It has a `title`, `leading`, `subtitle`, `caption`  and a `collapseChild` and can be either
/// expanded or collapsed. The body of the panel is only visible when it is
/// expanded.
///
/// [LExpansionPanel] is built using [LCollapse] and [ListTile]
///
/// See Also:
/// * [LCollapse], A Collapsable widget that is hidden when collapsed
class LExpansionPanel extends StatefulWidget {
  /// Collapsing duration
  final Duration duration = const Duration(milliseconds: 200);

  /// A widget that should be render on top left corner of
  /// [LExpansionPanel] body or above `leading`/ `title`
  ///
  /// Generally an [LBadge]
  ///
  final Widget caption;

  /// Add widget at the left-most position of [LExpansionPanel]
  final Widget leading;

  /// text widget for the `title` position
  final Widget title;

  /// style for the `title`
  ///
  /// default: [LiquidCollapseTheme.titleStyle] of [LiquidTheme]
  final TextStyle titleStyle;

  /// A widget for the `subtitle` position
  final Widget subtitle;

  /// text style for the `subtitle`
  ///
  /// default: [LiquidCollapseTheme.subtitleStyle] of [LiquidTheme]
  final TextStyle subTitleStyle;

  /// Spacing inside the [LExpansionPanel]
  final EdgeInsets padding;

  /// Background color of [LExpansionPanel]
  final Color background;

  /// [LExpansionPanel]'s radius
  final double radius;

  /// A child which is collapsable
  final Widget collapseChild;

  /// background color of the collapsable child body
  final Color collapseBackground;

  /// Shadow below the [LExpansionPanel]
  final double elevation;

  /// Whether this [LExpansionPanel] initially collapsed
  ///
  /// default: `true`
  final bool initiallyCollapsed;

  /// Border around the [LExpansionPanel]
  final BorderSide borderSide;

  /// An expansion panel. It has a `title`, `leading`, `subtitle`, `caption`  and a `collapseChild` and can be either
  /// expanded or collapsed. The body of the panel is only visible when it is
  /// expanded.
  ///
  /// ### Example
  /// ```dart
  /// LExpansionPanel(
  ///   caption: LBadge.icon(
  ///     icon: Icon(Icons.warning),
  ///     label: Text("Latest"),
  ///     type: LElementType.warning,
  ///     size: LElementSize.small,
  ///   ),
  ///   leading: CircleAvatar(
  ///     backgroundColor: Colors.black45,
  ///   ),
  ///   title: Text("Liquid for flutter"),
  ///   subtitle: Text("Get the latest information"),
  ///   collapseChild: Center(
  ///     child: LFlatButton.text(text: "This was collapsed."),
  ///   ),
  /// ),
  /// ```
  ///
  /// [LExpansionPanel] is built using [LCollapse] and [ListTile]
  ///
  /// See Also:
  /// * [LCollapse], A Collapsable widget that is hidden when collapsed
  const LExpansionPanel({
    Key key,
    this.padding,
    this.caption,
    this.leading,
    @required this.title,
    this.titleStyle,
    this.subtitle,
    this.subTitleStyle,
    this.background = Colors.white,
    this.radius,
    this.elevation = 3.0,
    @required this.collapseChild,
    this.collapseBackground = Colors.white,
    this.initiallyCollapsed,
    this.borderSide,
  })  : assert(collapseChild != null),
        assert(title != null),
        super(key: key);

  @override
  _LExpansionPanelState createState() => _LExpansionPanelState();
}

class _LExpansionPanelState extends State<LExpansionPanel>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isCollapsed;
  GlobalKey<LCollapseState> _collapseKey = GlobalKey<LCollapseState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _isCollapsed = widget.initiallyCollapsed ?? true;
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final collapseTheme = theme.collapseTheme;

    return Material(
      elevation: widget.elevation ?? 5.0,
      color: widget.collapseBackground,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(widget.radius ?? 10.0),
        side: widget.borderSide ?? BorderSide.none,
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: toggle,
            child: AnimatedContainer(
              duration: widget.duration,
              decoration: BoxDecoration(
                color: widget.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(widget.radius ?? 10.0),
                  topRight: Radius.circular(widget.radius ?? 10.0),
                  bottomLeft: Radius.circular(
                      isCollapsed ? (widget.radius ?? 10.0) : 0.0),
                  bottomRight: Radius.circular(
                      isCollapsed ? (widget.radius ?? 10.0) : 0.0),
                ),
              ),
              child: Padding(
                padding: widget.padding ??
                    const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    widget.caption ?? Container(),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: widget.leading,
                      title: DefaultTextStyle.merge(
                        style: widget.titleStyle ?? collapseTheme.titleStyle,
                        child: widget.title,
                      ),
                      subtitle: DefaultTextStyle.merge(
                        style:
                            widget.subTitleStyle ?? collapseTheme.subtitleStyle,
                        child: widget.subtitle ?? Container(),
                      ),
                      trailing: RotationTransition(
                        turns: Tween(begin: 0.0, end: 0.5).animate(
                          CurvedAnimation(
                            parent: _animationController,
                            curve: Curves.fastOutSlowIn,
                          ),
                        ),
                        child: Icon(Icons.keyboard_arrow_down),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          LCollapse(
            key: _collapseKey,
            duration: widget.duration,
            padding: widget.padding,
            background: widget.collapseBackground,
            child: widget.collapseChild,
            radius: widget.radius,
          ),
        ],
      ),
    );
  }

  bool get isCollapsed => _isCollapsed;

  void toggle() {
    if (isCollapsed)
      open();
    else
      close();
  }

  void open() {
    _collapseKey.currentState.open();
    _animationController.forward();
    setState(() {
      _isCollapsed = false;
    });
  }

  void close() {
    _collapseKey.currentState.close();
    _animationController.reverse();
    setState(() {
      _isCollapsed = true;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}

/// A widget that can toggle the visibility of content/child
/// and can be controlled programmatically
///
/// See Also:
/// * [LExpansionPanel], An expansion panel built using [LCollapse]
class LCollapse extends StatefulWidget {
  /// Collapsing animation duration
  final Duration duration;

  /// Collapsing animation curve
  final Curve curve;

  /// Spacing around the child of [LCollapse]
  final EdgeInsets padding;

  /// Note: this is a utility for decoration border radius
  final double radius;

  /// widget that can be collapsed
  final Widget child;

  /// background color of the collapsable
  ///
  /// Note: this is a utility for decoration color
  final Color background;

  /// decoration for the [LCollapse]
  final Decoration decoration;

  /// A widget that can toggle the visibility of content
  /// and can be controlled programmatically
  ///
  /// ### Example:
  /// A collapsable section which can be collapse/uncollapse
  /// using a button press
  ///
  /// ```dart
  /// final GlobalKey<LCollapseState> _collapseKey = GlobalKey<LCollapseState>();
  ///
  /// LFlatButton.text(
  ///   text: "Toggle Collapse",
  ///   onPressed: () {
  ///     if (_collapseKey.currentState.isCollapsed)
  ///       _collapseKey.currentState.open();
  ///     else
  ///       _collapseKey.currentState.close();
  ///   }
  /// )
  ///
  /// ...
  ///
  /// child: LCollapse(
  ///   key: _collapseKey,
  ///   // duration: Duration(seconds: 10),
  ///   child: Center(
  ///     child: LText("Hey I am \l.uppercase.bold{visible} now...")
  ///   ),
  ///   background: Colors.green[300],
  /// ),
  ///
  /// ```
  ///
  /// See Also:
  /// * [LExpansionPanel], An expansion panel built using [LCollapse]
  const LCollapse({
    @required Key key,
    this.padding,
    this.radius,
    this.duration = const Duration(milliseconds: 200),
    this.curve,
    @required this.child,
    this.background,
    this.decoration,
  })  : assert(
            decoration == null ||
                decoration != null && background == null && radius == null,
            "do not provide background or radius along with decoration"),
        assert(key != null),
        assert(child != null),
        assert(duration != null),
        super(key: key);

  @override
  LCollapseState createState() => LCollapseState();
}

class LCollapseState extends State<LCollapse>
    with SingleTickerProviderStateMixin {
  bool _isCollapsed = true;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      axis: Axis.vertical,
      axisAlignment: 1.0,
      sizeFactor: CurvedAnimation(
          parent: _controller, curve: widget.curve ?? Curves.fastOutSlowIn),
      child: Container(
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
        decoration: widget.decoration ??
            BoxDecoration(
              borderRadius: BorderRadius.circular(widget.radius ?? 10.0),
              color: widget.background,
            ),
        child: widget.child,
      ),
    );
  }

  /// check if [LCollapse] is currently in collapsed state
  bool get isCollapsed => _isCollapsed;

  /// uncollapse the associated [LCollapse]
  open() {
    setState(() {
      _isCollapsed = false;
    });
    _controller.forward();
  }

  /// collapse the associated [LCollapse]
  close() {
    setState(() {
      _isCollapsed = true;
    });
    _controller.reverse();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
