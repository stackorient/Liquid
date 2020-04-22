part of 'components.dart';

enum LCorouselAnimation { slide, fade }

class LCorouselCaption extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final Widget title;
  final Widget subTitle;
  final List<Widget> actions;

  const LCorouselCaption({
    Key key,
    this.title,
    this.subTitle,
    this.titleText,
    this.subTitleText,
    this.subTitleTextStyle,
    this.titleTextStyle,
    this.actions = const [],
  })  : assert(
            (title != null && titleText == null) ||
                (title == null && titleText != null) ||
                (title == null && titleText == null),
            "use either title or titleText"),
        assert(
            (subTitle != null && subTitleText == null) ||
                (subTitle == null && subTitleText != null) ||
                (subTitle == null && subTitleText == null),
            "use either subTitle or subTitleText"),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          title ?? Container(),
          subTitle ?? Container(),
          titleText != null
              ? Text(
                  titleText,
                  style: this.titleTextStyle ??
                      theme.typographyTheme.h4.withColor(Colors.white),
                )
              : Container(),
          subTitleText != null
              ? Text(
                  subTitleText,
                  style: this.subTitleTextStyle ??
                      theme.typographyTheme.p.withColor(Colors.white),
                )
              : Container(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: actions,
          ),
        ],
      ),
    );
  }
}

class LCorouselItem extends StatelessWidget {
  final double height;
  final LCorouselCaption caption;
  final Function onTap;
  final Widget child;

  const LCorouselItem({
    Key key,
    this.height,
    this.caption = const LCorouselCaption(),
    this.onTap,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final corousel = LCorousel.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned.fill(child: child),
            corousel.withCaption
                ? Positioned.fill(
                    child: caption,
                    bottom: corousel.showIndicator ? 20.0 : 10.0,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}

class LCorousel extends StatefulWidget {
  final double height;
  final double width;
  final bool autoScroll;
  final Duration interval;
  final bool withControls;
  final bool canScroll;
  final bool showIndicator;
  final bool enableIndicatorTapControl;
  final bool withCaption;
  final List<LCorouselItem> items;
  final PageController controller;
  final Widget Function(BuildContext context, int activeIndex) indicatorBuilder;

  const LCorousel({
    Key key,
    this.height,
    this.width,
    this.autoScroll = true,
    this.interval = const Duration(seconds: 6),
    this.withControls = false,
    this.canScroll = true,
    this.showIndicator = false,
    this.enableIndicatorTapControl = false,
    this.controller,
    this.withCaption = false,
    this.items = const <LCorouselItem>[],
    this.indicatorBuilder,
  }) : super(key: key);

  @override
  _LCorouselState createState() => _LCorouselState();

  static LCorousel of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<LCorousel>();
  }
}

class _LCorouselState extends State<LCorousel> {
  Timer _timer;
  PageController _controller;
  int _currentPageValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = (widget.controller ?? PageController())
      ..addListener(
        () => setState(() {
          _currentPageValue = _controller.page.round();
        }),
      );
    if (widget.autoScroll) {
      _timer = Timer.periodic(widget.interval, _initAutoRun);
    }
  }

  _initAutoRun(Timer _) {
    final _totalPage = widget.items.length;

    if (_currentPageValue == _totalPage - 1) {
      _gotoPage();
    } else {
      _controller.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      );
    }
  }

  _gotoPage({int pageNo, bool reset = false}) {
    if (reset) {
      _timer.cancel();
      setState(() {
        _timer = Timer.periodic(widget.interval, _initAutoRun);
      });
    }

    _controller.animateToPage(
      pageNo ?? 0,
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  _previousPage() {
    _timer.cancel();
    setState(() {
      _timer = Timer.periodic(widget.interval, _initAutoRun);
    });
    _controller.previousPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  _nextPage() {
    _timer.cancel();
    setState(() {
      _timer = Timer.periodic(widget.interval, _initAutoRun);
    });
    _controller.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Positioned.fill(
            child: PageView(
              pageSnapping: true,
              controller: _controller,
              physics: widget.canScroll
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              children: widget.items,
            ),
          ),
          widget.withControls
              ? Positioned(
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: _currentPageValue.floor() == 0
                          ? Container()
                          : IconButton(
                              icon: Icon(Icons.chevron_left),
                              onPressed: _previousPage,
                              iconSize: 26.0,
                              color: Colors.white,
                            ),
                    ),
                  ),
                )
              : Container(),
          widget.withControls
              ? Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child:
                          _currentPageValue.floor() == widget.items.length - 1
                              ? Container()
                              : IconButton(
                                  icon: Icon(Icons.chevron_right),
                                  onPressed: _nextPage,
                                  iconSize: 26.0,
                                  color: Colors.white,
                                ),
                    ),
                  ),
                )
              : Container(),
          widget.showIndicator
              ? Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: widget.indicatorBuilder != null
                      ? widget.indicatorBuilder(
                          context,
                          _currentPageValue.floor(),
                        )
                      : buildIndicator(),
                )
              : Container()
        ],
      ),
    );
  }

  Widget buildIndicator() {
    final List<Widget> _ = [];
    for (int i = 0; i < widget.items.length; i++) {
      final indicator = InkWell(
        onTap: widget.enableIndicatorTapControl
            ? () => _gotoPage(pageNo: i, reset: true)
            : null,
        child: Container(
          height: 3.0,
          width: 100 / widget.items.length,
          margin: EdgeInsets.symmetric(
              vertical: widget.enableIndicatorTapControl ? 10.0 : 0.0),
          color: i == _currentPageValue.round() ? Colors.white : Colors.grey,
        ),
      );

      _.add(indicator);
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 10.0,
          vertical: widget.enableIndicatorTapControl ? 0.0 : 10.0),
      child: Wrap(
        children: _,
        spacing: 4.0,
        alignment: WrapAlignment.center,
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }
}
