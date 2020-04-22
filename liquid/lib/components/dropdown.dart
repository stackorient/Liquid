part of 'components.dart';

class _LDropdownItemRaw extends StatelessWidget {
  final Widget child;
  final Function onTap;
  final Function onLongPress;
  final bool forText;
  final EdgeInsets padding;
  final Color splashColor;
  final Color focusColor;
  final Color hoverColor;
  final Color highlightColor;
  final Color background;

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
  })  : assert(child != null),
        assert(forText != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context).dropdownTheme.itemTheme;

    return forText ? _buildForText(theme) : _buildForChild(theme);
  }

  Widget _buildForText(LiquidDropdownItemTheme theme) {
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
  LDropdownItem({
    Key key,
    Function onTap,
    @required String text,
    TextStyle style,
    Function onLongPress,
    EdgeInsets padding,
    Color splashColor,
    Color focusColor,
    Color hoverColor,
    Color highlightColor,
    Color background,
  }) : super(
          key: key,
          child: Text(text, style: style),
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
}

class LDropdown extends StatefulWidget {
  final double top;
  final Widget trigger;
  final ShapeBorder shape;
  final EdgeInsets padding;
  final Color background;
  final double elevation;
  final List<LDropdownItem> items;
  final List<LDropdownItem> Function(BuildContext context) itemBuilder;
  final Color triggerSplashColor;
  final Color triggerFocusColor;
  final Color triggerHoverColor;
  final Color triggerHighlightColor;
  final ShapeBorder triggerShape;

  LDropdown({
    Key key,
    @required this.trigger,
    this.shape,
    this.padding,
    this.background,
    this.top = 50.0,
    this.elevation,
    this.items,
    this.itemBuilder,
    this.triggerSplashColor,
    this.triggerFocusColor,
    this.triggerHoverColor,
    this.triggerHighlightColor,
    this.triggerShape,
  })  : assert(trigger != null),
        assert(
            (items != null && itemBuilder == null) ||
                (items == null && itemBuilder != null),
            "need item or itembuilder for dropdown"),
        super(key: key);

  @override
  _LDropdownState createState() => _LDropdownState();
}

class _LDropdownState extends State<LDropdown> with WidgetsBindingObserver {
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

  _setupDropdownItems() {
    final theme = LiquidTheme.of(context).dropdownTheme;

    _dropdownContent = Container(
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
    return Material(
      shape: widget.triggerShape,
      type: MaterialType.transparency,
      child: InkWell(
        key: _triggerKey,
        onTap: _showDropdown,
        splashColor: widget.triggerSplashColor,
        focusColor: widget.triggerFocusColor,
        hoverColor: widget.triggerHoverColor,
        highlightColor: widget.triggerHighlightColor,
        child: widget.trigger,
      ),
    );
  }

  @override
  void didChangeMetrics() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      _rebuildDropdown();
    });
  }

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
      _dropdown.remove();
      setState(() {
        _opened = false;
        _dropdown = null;
      });
    }
  }

  void _rebuildDropdown() {
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

  RenderBox _getBox() {
    final _box = _triggerKey.currentContext.findRenderObject() as RenderBox;

    return _box;
  }

  bool _canPrint(RenderBox box) {
    if (box.localToGlobal(Offset.zero).dy < widget.top) {
      return false;
    }
    // print(box.localToGlobal(Offset.zero));
    return true;
  }

  Widget _buildDropdown(BuildContext context) {
    final _box = _getBox();
    final size = _box.size;
    final _pos = _box.localToGlobal(Offset.zero);
    final can = _canPrint(_box);

    return can
        ? Positioned(
            top: _pos.dy + size.height,
            left: _pos.dx,
            child: _dropdownContent,
          )
        : Container();
  }

  @override
  void dispose() {
    _dropdown?.remove();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
