part of 'components.dart';

class LExpansionPanel extends StatefulWidget {
  final Duration duration = const Duration(milliseconds: 200);
  final Widget caption;
  final Widget leading;
  final Widget title;
  final TextStyle titleStyle;
  final Widget subtitle;
  final TextStyle subTitleStyle;
  final EdgeInsets padding;
  final Color background;
  final double radius;
  final double collapseHeight;
  final Widget collapseChild;
  final Color collapseBackground;
  final double elevation;

  const LExpansionPanel({
    Key key,
    this.padding,
    this.caption,
    this.leading,
    this.title,
    this.titleStyle,
    this.subtitle,
    this.subTitleStyle,
    this.background = Colors.white,
    this.radius,
    this.elevation = 6.0,
    @required this.collapseHeight,
    @required this.collapseChild,
    this.collapseBackground = Colors.white,
  })  : assert(collapseHeight != null),
        assert(collapseChild != null),
        super(key: key);

  @override
  _LExpansionPanelState createState() => _LExpansionPanelState();
}

class _LExpansionPanelState extends State<LExpansionPanel>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  bool _isCollapsed = true;
  GlobalKey<LCollapseState> _collapseKey = GlobalKey<LCollapseState>();

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
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
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if (isCollapsed)
                open();
              else
                close();
            },
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
                      title: AnimatedDefaultTextStyle(
                        duration: widget.duration,
                        style: widget.titleStyle ?? collapseTheme.titleStyle,
                        child: widget.title,
                      ),
                      subtitle: AnimatedDefaultTextStyle(
                        duration: widget.duration,
                        style:
                            widget.subTitleStyle ?? collapseTheme.subtitleStyle,
                        child: widget.subtitle,
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
            height: widget.collapseHeight,
            radius: widget.radius,
          ),
        ],
      ),
    );
  }

  bool get isCollapsed => _isCollapsed;

  open() {
    _collapseKey.currentState.open();
    _animationController.forward();
    setState(() {
      _isCollapsed = false;
    });
  }

  close() {
    _collapseKey.currentState.close();
    _animationController.reverse();
    setState(() {
      _isCollapsed = true;
    });
  }
}

class LCollapse extends StatefulWidget {
  final Duration duration;
  final Curve curve;
  final EdgeInsets padding;
  final double radius;
  final double height;
  final Widget child;
  final Color background;
  final Decoration decoration;

  const LCollapse({
    @required Key key,
    this.padding,
    this.radius,
    this.duration = const Duration(milliseconds: 200),
    this.curve,
    @required this.height,
    @required this.child,
    this.background,
    this.decoration,
  })  : assert(
            decoration == null ||
                decoration != null && background == null && radius == null,
            "do not provide background or radius along with decoration"),
        assert(key != null),
        assert(height != null),
        assert(child != null),
        assert(duration != null),
        super(key: key);

  @override
  LCollapseState createState() => LCollapseState();
}

class LCollapseState extends State<LCollapse> {
  bool _isCollapsed = true;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: widget.duration,
      curve: widget.curve ?? Curves.fastLinearToSlowEaseIn,
      height: _isCollapsed ? 0.0 : widget.height,
      padding: widget.padding ??
          const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
      decoration: widget.decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radius ?? 10.0),
            color: widget.background,
          ),
      child: FlexibleSpaceBarSettings(
          toolbarOpacity: 1.0,
          minExtent: 0.0,
          maxExtent: widget.height,
          currentExtent: widget.height,
          child: FlexibleSpaceBar(
            background: widget.child,
          )),
    );
  }

  bool get isCollapsed => _isCollapsed;

  open() {
    setState(() {
      _isCollapsed = false;
    });
  }

  close() {
    setState(() {
      _isCollapsed = true;
    });
  }
}
