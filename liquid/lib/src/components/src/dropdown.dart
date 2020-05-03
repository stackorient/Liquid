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

class LDropdown extends StatefulWidget {
  final double hideOnTopOffset;

  /// Declare the expected height for the [LDropdown] contents
  final double predictiveHeight;

  /// Declare the expected width for the [LDropdown] contents
  final double predictiveWidth;

  /// Create widget to initiate [LDropdownItem]
  final Widget trigger;

  /// Customize shape of the [LDropdown]
  final ShapeBorder shape;
  final EdgeInsets padding;
  final Color background;

  /// Elevates the [LDropdown]
  final double elevation;
  final List<LDropdownItem> items;
  final List<LDropdownItem> Function(BuildContext context) itemBuilder;

  /// Customize shape of the `trigger`
  final ShapeBorder triggerShape;
  final bool scrollable;
  final bool scrollToClose;

  /// Add [LDropdown] background color
  final Color backdrop;

  ///Toggle contextual overlays for displaying lists of links and
  /// more with the Bootstrap dropdown plugin.
  /// Dropdowns are toggleable, contextual overlays for displaying lists of links and more.
  ///
  /// Example:
  ///
  /// ```
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
  /// ```
  /// See:
  /// * [LDropdown], [LDropdownItem], [LDropdownItem.divider], [LDropdownItem.header], [LDropdownItem.withChild]
  LDropdown({
    @required Key key,
    @required this.trigger,
    this.shape,
    this.padding,
    this.background,
    this.hideOnTopOffset = 50.0,
    this.predictiveHeight = 10.0,
    this.predictiveWidth = 100.0,
    this.elevation,
    this.items,
    this.itemBuilder,
    this.triggerShape,
    this.scrollable = true,
    this.scrollToClose = true,
    this.backdrop = Colors.black26,
  })  : assert(key != null),
        assert(backdrop != null),
        assert(scrollable != null),
        assert(scrollToClose != null),
        assert(trigger != null),
        assert(predictiveHeight != null && predictiveWidth != null),
        assert(predictiveHeight >= 0 && predictiveWidth >= 0),
        assert((scrollToClose && scrollable) || !scrollToClose,
            "for scrollToClose you need scrollable to be true"),
        assert(
            (items != null && itemBuilder == null) ||
                (items == null && itemBuilder != null),
            "need item or itembuilder for dropdown"),
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

  bool get isOpened => _opened;

  _setupDropdownItems() {
    final theme = LiquidTheme.of(context).dropdownTheme;

    _dropdownContent = GestureDetector(
      onTap: () {},
      child: Container(
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
      ),
    );

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _setupDropdownItems();
    return Material(
      key: _triggerKey,
      shape: widget.triggerShape,
      type: MaterialType.transparency,
      child: widget.trigger,
    );
  }

  @override
  void didChangeMetrics() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _rebuildDropdown(force: true);
    });
  }

  void toggleDropdown() => _showDropdown();

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

  void closeDropdown() {
    _dropdown.remove();
    setState(() {
      _opened = false;
      _dropdown = null;
    });
  }

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

  RenderBox _getBox() {
    final _box = _triggerKey.currentContext.findRenderObject() as RenderBox;

    return _box;
  }

  bool _canPrint(RenderBox box) {
    final pos = box.localToGlobal(Offset.zero);
    if (pos.dy < widget.hideOnTopOffset) {
      return false;
    }
    return true;
  }

  Widget _buildDropdown(BuildContext context) {
    final _box = _getBox();
    final size = _box.size;
    final _pos = _box.localToGlobal(Offset.zero);
    final can = _canPrint(_box);

    return can
        ? (widget.scrollable
            ? _buildPositioned(_pos, size)
            : GestureDetector(
                onTap: closeDropdown,
                child: Material(
                    color: widget.backdrop,
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: <Widget>[_buildPositioned(_pos, size)],
                    )),
              ))
        : Container();
  }

  Positioned _buildPositioned(Offset _offset, Size size) {
    final _mqSize = MediaQuery.of(context).size;
    final _verticalOffset = _mqSize.height - (_offset.dy + size.height);
    final _horizontalOffset = _mqSize.width - (_offset.dx + size.width);

    double _top, _right, _bottom, _left;
    if (_verticalOffset < widget.predictiveHeight) {
      _bottom = _verticalOffset + size.height;
    } else {
      _top = _offset.dy + size.height;
    }

    if (_horizontalOffset < widget.predictiveWidth) {
      _right = _horizontalOffset;
    } else {
      _left = _offset.dx;
    }

    return Positioned(
      right: _right,
      bottom: _bottom,
      top: _top,
      left: _left,
      child: _dropdownContent,
    );
  }

  @override
  void dispose() {
    _dropdown?.remove();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
