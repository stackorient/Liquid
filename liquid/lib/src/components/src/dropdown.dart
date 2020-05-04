import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../../base/base.dart';

class _LDropdownItemRaw extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Function onLongPress;
  final bool forText;
  final bool header;
  final EdgeInsets padding;
  final Color splashColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color background;
  final TextStyle textStyle;
  final TextStyle disabledTextStyle;

  const _LDropdownItemRaw({
    Key key,
    @required this.child,
    @required this.forText,
    this.onTap,
    this.onLongPress,
    this.padding,
    this.splashColor,
    this.focusColor,
    this.hoverColor,
    this.highlightColor,
    this.background,
    this.header,
    this.textStyle,
    this.disabledTextStyle,
  })  : assert(child != null),
        assert(forText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context).dropdownTheme.itemTheme;

    return forText ? _buildForText(theme) : _buildForChild(theme);
  }

  Widget _buildForText(LiquidDropdownItemTheme theme) {
    if (header ?? false) {
      return AbsorbPointer(
        child: Material(
          color: background ?? Colors.transparent,
          textStyle: textStyle ?? theme.headerTextStyle,
          child: Padding(
            padding: padding ?? theme.headerPadding,
            child: child,
          ),
        ),
      );
    }

    return InkWell(
      canRequestFocus: true,
      splashColor: splashColor ?? theme.splashColor,
      focusColor: focusColor ?? theme.focusColor,
      hoverColor: hoverColor ?? theme.hoverColor,
      highlightColor: highlightColor ?? theme.highlightColor,
      onTap: onTap,
      onLongPress: onLongPress,
      child: Material(
        color: background ?? Colors.transparent,
        textStyle: (onTap != null || onLongPress != null)
            ? textStyle ?? theme.textStyle
            : disabledTextStyle ?? theme.disabledTextStyle,
        child: Padding(
          padding: padding ?? theme.padding,
          child: child,
        ),
      ),
    );
  }

  Widget _buildForChild(LiquidDropdownItemTheme theme) {
    return Material(
      color: background ?? Colors.transparent,
      child: Padding(
        padding: padding ?? theme.padding,
        child: child,
      ),
    );
  }
}

class LDropdownItem extends _LDropdownItemRaw {
  /// [LDropdown] menu contents.
  ///
  /// Example:
  /// ```
  /// ...
  ///
  /// LDropdownItem(
  ///     text: "Item",
  ///     onTap: () {
  ///       print("pressed");
  ///     },
  ///     onLongPress: () {},
  ///   ),
  /// ...
  ///
  /// ```
  /// See Also:
  /// * [LDropdownItem.divider], [LDropdownItem.header], [LDropdownItem.withChild]
  LDropdownItem({
    Key key,
    Function onTap,
    @required String text,
    TextStyle style,
    TextStyle disabledStyle,
    Function onLongPress,
    EdgeInsets padding,
    Color splashColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color background,
  }) : super(
          key: key,
          child: Text(text),
          textStyle: style,
          disabledTextStyle: disabledStyle,
          onTap: onTap,
          onLongPress: onLongPress,
          forText: true,
          padding: padding,
          splashColor: splashColor,
          focusColor: focusColor,
          hoverColor: hoverColor,
          highlightColor: highlightColor,
          background: background,
        );

  /// Add custom widget as `child`.
  ///
  /// Example:
  /// ```
  /// ...
  /// LDropdownItem.withChild(
  ///     child: Row(
  ///   // mainAxisSize: MainAxisSize.min,
  ///   children: <Widget>[
  ///     LIconButton(
  ///       icon: Icon(Icons.ac_unit),
  ///       onPressed: () {},
  ///     ),
  ///     LIconButton(
  ///       icon: Icon(Icons.ac_unit),
  ///       onPressed: () {},
  ///     ),
  ///     LIconButton(
  ///       icon: Icon(Icons.ac_unit),
  ///       onPressed: () {},
  ///     ),
  ///   ],
  /// )
  ///),
  /// ...
  /// ```
  ///
  /// See:
  /// * [LDropdownItem], [LDropdownItem.divider], [LDropdownItem.header]
  LDropdownItem.withChild({
    Key key,
    Widget child,
    EdgeInsets padding,
    Color background,
  }) : super(
          key: key,
          child: child,
          forText: false,
          padding: padding,
          background: background,
        );

  /// Add custom widget as `child`.
  ///
  /// Example:
  /// ```
  /// ...
  /// LDropdownItem.header(text: "Header"),
  /// ...
  /// ```
  ///
  /// See:
  /// * [LDropdownItem], [LDropdownItem.divider], [LDropdownItem.withChild]

  LDropdownItem.header({
    Key key,
    @required String text,
    TextStyle style,
    TextStyle disabledStyle,
    EdgeInsets padding,
    Color color = Colors.black45,
    Color background,
  }) : super(
          key: key,
          child: Text(text),
          textStyle: style,
          disabledTextStyle: disabledStyle,
          forText: true,
          header: true,
          padding: padding,
          background: background,
        );

  /// Add custom widget as `child`.
  ///
  /// Example:
  /// ```
  /// ...
  ///LDropdownItem.divider(
  /// thickness: 2,
  ///),
  /// ...
  /// ```
  ///
  /// See:
  /// * [LDropdownItem], [LDropdownItem.withChild], [LDropdownItem.header]

  LDropdownItem.divider({
    Key key,
    double height,
    double thickness,
    double indent,
    double endIndent,
    Color color,
    Color background,
  }) : super(
          key: key,
          child: Divider(
            height: height,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
            color: color,
          ),
          forText: false,
          padding: EdgeInsets.zero,
          background: background,
        );
}

enum DropdownPosition { left, center, right }

class LDropdown extends StatefulWidget {
  /// Hide the dropdown when this much offset remains from the top
  ///
  /// generally used to hide dropdown when trigger hide under the
  /// [AppBar]
  ///
  /// default: [kToolbarHeight] i.e. `56`
  final double hideOnTopOffset;

  /// Alignment of dropdown with respect to trigger
  ///
  /// default: `center`
  final DropdownPosition position;

  /// Shift the dropdown by this offset to left
  ///
  /// default: `0.0`
  final double leftOffset;

  /// Shift the dropdown by this offset to right
  ///
  /// default: `0.0`
  final double rightOffset;

  /// Create widget to initiate [LDropdownItem]
  final Widget trigger;

  /// Customize shape of the [LDropdown]
  final ShapeBorder shape;

  /// Spacing inside dropdown body
  final EdgeInsets padding;

  /// Background color of dropdown body
  final Color background;

  /// Elevates the [LDropdown]
  final double elevation;

  /// List of [LDropdownItem] items
  final List<LDropdownItem> items;

  /// Lazily build dropdown items
  final List<LDropdownItem> Function(BuildContext context) itemBuilder;

  /// Whether [LDropdown] should follow `trigger` when
  /// `trigger` change its positon.
  ///
  /// If your trigger is in a [Scrollable] like [ListView], [SingleChildScrollView], etc
  /// and `scrollable` is `true` then [LDropdown] will follow trigger on scroll
  ///
  /// default: `true`
  final bool scrollable;

  /// Whether [LDropdown] should close when a trigger changes its
  /// position
  final bool scrollToClose;

  /// Whether the [LDropdown] defaults to being displayed below the `trigger`.
  /// Defaults to `true`. If there is insufficient space to display the tooltip in the preferred direction,
  /// the tooltip will be displayed in the opposite direction.
  final bool preferBelow;

  ///The vertical gap between the `trigger` and the displayed [LDropdown].
  ///
  /// When [preferBelow] is set to true and [LDropdown] have sufficient space to display themselve,
  /// this property defines how much vertical space [LDropdown] will position themselve under their
  /// corresponding `trigger`. Otherwise, [LDropdown] will position themselve above their corresponding
  /// `trigger` with the given offset.
  final double verticalOffset;

  /// when `scrollable` is `false`, the dropdown will show a backdrop
  /// which on tap event, dismisses the active dropdown
  ///
  /// default is Black with opacity 26%
  final Color backdrop;

  ///Toggle contextual overlays for displaying lists of links and
  /// more with the Liquid dropdown plugin [LDropdown].
  /// Dropdowns are toggleable, contextual overlays for displaying lists of links and more.
  ///
  /// Example:
  ///
  /// ```
  ///
  /// final GlobalKey<LDropdownState> _dropdown = GlobalKey<LDropdownState>();
  /// ...
  /// LDropdown(
  ///     key: _dropdown,
  ///     scrollToClose: false,
  ///     scrollable: true,
  ///     // backdrop: Colors.red.withOpacity(0.4),
  ///     predictiveHeight: 250.0,
  ///     predictiveWidth: 150.0,
  ///     elevation: 10.0,
  ///     trigger: LFlatButton.text(
  ///               small: true,
  ///               text: "Dropdown",
  ///               onPressed: () {
  ///
  ///               },
  ///               type: ButtonType.warning,
  ///             ),
  ///             itemBuilder: (context) => [
  ///               LDropdownItem.header(text: "Option 1"),
  ///               LDropdownItem(
  ///                 text: "First Item",
  ///                 onTap: () {},
  ///               ),
  ///               LDropdownItem(
  ///                 text: "Second Item",
  ///                 onTap: () {
  ///                   print("pressed");
  ///                 },
  ///                 onLongPress: () {
  ///                   print("long pressed");
  ///
  ///                 },
  ///               ),
  ///               LDropdownItem(
  ///                 text: "Third Item",
  ///                 onTap: () {},
  ///        ),
  ///        LDropdownItem.divider(
  ///          thickness: 2,
  ///        ),
  ///        LDropdownItem.header(text: "Options"),
  ///        LDropdownItem.withChild(
  ///            child: Row(
  ///          // mainAxisSize: MainAxisSize.min,
  ///          children: <Widget>[
  ///            LIconButton(
  ///              icon: Icon(Icons.ac_unit),
  ///              onPressed: () {},
  ///            ),
  ///            LIconButton(
  ///              icon: Icon(Icons.ac_unit),
  ///              onPressed: () {},
  ///            ),
  ///            LIconButton(
  ///              icon: Icon(Icons.ac_unit),
  ///              onPressed: () {},
  ///            ),
  ///          ],
  ///        )),
  ///      ],
  ///    ),
  ///
  /// ...
  ///
  /// _dropdown.currentState.toggleDropdown(); // toggle dropdown
  /// ```
  /// See:
  /// * [LDropdown], [LDropdownItem], [LDropdownItem.divider], [LDropdownItem.header], [LDropdownItem.withChild]
  LDropdown({
    @required Key key,
    @required this.trigger,
    this.shape,
    this.padding,
    this.background,
    this.hideOnTopOffset = kToolbarHeight,
    this.leftOffset = 0.0,
    this.rightOffset = 0.0,
    this.position = DropdownPosition.center,
    this.elevation,
    this.items,
    this.itemBuilder,
    this.scrollable = true,
    this.scrollToClose = true,
    this.preferBelow = true,
    this.verticalOffset = 0.0,
    this.backdrop = Colors.black26,
  })  : assert(key != null),
        assert(backdrop != null),
        assert(scrollable != null),
        assert(scrollToClose != null),
        assert(trigger != null),
        assert((scrollToClose && scrollable) || !scrollToClose,
            "for scrollToClose you need scrollable to be true"),
        assert(
            (items != null && itemBuilder == null) ||
                (items == null && itemBuilder != null),
            "need item or itembuilder for dropdown"),
        assert(verticalOffset != null),
        assert(preferBelow != null),
        assert(leftOffset != null && rightOffset != null),
        assert(position != null),
        super(key: key);

  @override
  LDropdownState createState() => LDropdownState();
}

class LDropdownState extends State<LDropdown> with WidgetsBindingObserver {
  GlobalKey _triggerKey;
  OverlayEntry _dropdown;
  bool _opened;
  ScrollPosition _position;
  Widget _dropdownContent;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _triggerKey = GlobalKey();
    _opened = false;
  }

  /// Is [LDropdown] visible on screen
  bool get isOpened => _opened;

  /// set dropdown items for rendering on an overlay
  _setupDropdownItems() {
    final theme = LiquidTheme.of(context).dropdownTheme;

    _dropdownContent = GestureDetector(
      onTap: () {},
      child: Material(
        color: widget.background ?? theme.background,
        elevation: widget.elevation ?? theme.elevation,
        shape: widget.shape ??
            (theme.shape ??
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(
                    color: Colors.black.withOpacity(0.15),
                  ),
                )),
        child: Padding(
          padding: widget.padding ?? theme.padding,
          child: IntrinsicWidth(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: widget.items ?? widget.itemBuilder(context),
            ),
          ),
        ),
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _setupDropdownItems();
    return Container(
      key: _triggerKey,
      child: widget.trigger,
    );
  }

  @override
  void didChangeMetrics() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _rebuildDropdown(force: true);
    });
  }

  /// toggles the dropdown
  void toggleDropdown() => _showDropdown();

  /// Show the dropdown on screen
  /// if it isn't on screen else close active dropdown
  void _showDropdown() {
    if (!_opened && _dropdown == null) {
      setState(() {
        _opened = true;
        _dropdown = OverlayEntry(
          builder: (context) => _buildDropdown(context),
        );
        _position = Scrollable.of(context)?.position;
        _position?.addListener(_rebuildDropdown);
      });
      Overlay.of(context).insert(_dropdown);
    } else {
      closeDropdown();
    }
  }

  /// try to close the opened dropdown
  void closeDropdown() {
    _dropdown.remove();
    setState(() {
      _opened = false;
      _dropdown = null;
    });
  }

  /// rebuilds dropdown when screen is scrolled
  /// if [LDropdown] is present in a [Scrollable] widget
  ///
  /// or when called with `force` parameter
  void _rebuildDropdown({bool force = false}) {
    if (widget.scrollable || force) {
      if (_opened) {
        setState(() {
          _dropdown.remove();
          _dropdown = OverlayEntry(
            builder: (context) => _buildDropdown(context),
          );
        });

        Overlay.of(context).insert(_dropdown);
      }
    }
    if (widget.scrollToClose) {
      _position?.removeListener(_rebuildDropdown);
      closeDropdown();
    }
  }

  /// This method returns the [RenderBox]
  /// of the `trigger` element
  RenderBox _getBox() {
    final _box = _triggerKey.currentContext.findRenderObject() as RenderBox;
    return _box;
  }

  /// This method will check if
  /// dropdown should be repainted
  bool _canPrint(RenderBox box) {
    final pos = box.localToGlobal(Offset.zero);
    if (pos.dy < widget.hideOnTopOffset) {
      return false;
    }
    return true;
  }

  /// Where should dropdown position itself with respect to `trigger`
  Offset _getOffsetPositon(Size size) {
    if (widget.position == DropdownPosition.center)
      return size.center(Offset.zero);
    if (widget.position == DropdownPosition.left)
      return size.centerLeft(Offset.zero);
    if (widget.position == DropdownPosition.right)
      return size.centerRight(Offset.zero);

    return Offset.zero;
  }

  /// actual method that builds Dropdown
  Widget _buildDropdown(BuildContext context) {
    final _box = _getBox();
    final size = _box.size;
    final _pos = _box.localToGlobal(_getOffsetPositon(size));
    final can = _canPrint(_box);

    final _dropdown = CustomSingleChildLayout(
      delegate: _DropdownDelegate(
        preferBelow: widget.preferBelow,
        target: _pos,
        verticalOffset: widget.verticalOffset,
      ),
      child: Container(
        margin: EdgeInsets.only(
          top: size.height / 2,
          bottom: size.height / 2,
          left: widget.rightOffset,
          right: widget.leftOffset,
        ),
        child: _dropdownContent,
      ),
    );
    return can
        ? (widget.scrollable
            ? _dropdown
            : GestureDetector(
                onTap: closeDropdown,
                child: Material(
                  color: widget.backdrop,
                  child: _dropdown,
                ),
              ))
        : Container();
  }

  @override
  void dispose() {
    _dropdown?.remove();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}

class _DropdownDelegate extends SingleChildLayoutDelegate {
  final Offset target;
  final double verticalOffset;
  final bool preferBelow;

  _DropdownDelegate({
    @required this.target,
    @required this.verticalOffset,
    @required this.preferBelow,
  })  : assert(target != null),
        assert(verticalOffset != null),
        assert(preferBelow != null);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) =>
      constraints.loosen();

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    return positionDependentBox(
      size: size,
      childSize: childSize,
      target: target,
      verticalOffset: verticalOffset,
      preferBelow: preferBelow,
    );
  }

  @override
  bool shouldRelayout(_DropdownDelegate oldDelegate) {
    return target != oldDelegate.target ||
        verticalOffset != oldDelegate.verticalOffset ||
        preferBelow != oldDelegate.preferBelow;
  }
}
