import 'dart:async';
import 'package:flutter/material.dart';

import '../../base/base.dart';

enum LCarouselAnimation { slide, fade }

class LCarouselCaption extends StatelessWidget {
  final String titleText;
  final String subTitleText;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;
  final Widget title;
  final Widget subTitle;
  final List<Widget> actions;

  const LCarouselCaption({
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

class LCarouselItem extends StatelessWidget {
  final double height;
  final LCarouselCaption caption;
  final Function onTap;
  final Widget child;

  const LCarouselItem({
    Key key,
    this.height,
    this.caption = const LCarouselCaption(),
    this.onTap,
    @required this.child,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final corousel = LCarousel.of(context);

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

class LCarousel extends StatefulWidget {
  final double height;
  final double width;
  final bool autoScroll;
  final Duration interval;
  final bool withControls;
  final bool canScroll;
  final bool showIndicator;
  final bool enableIndicatorTapControl;
  final bool withCaption;
  final List<LCarouselItem> items;
  final PageController controller;
  final Widget Function(BuildContext context, int activeIndex) indicatorBuilder;

  const LCarousel({
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
    this.items = const <LCarouselItem>[],
    this.indicatorBuilder,
  }) : super(key: key);

  @override
  _LCarouselState createState() => _LCarouselState();

  static LCarousel of(BuildContext context) {
    return context.findAncestorWidgetOfExactType<LCarousel>();
  }
}

class _LCarouselState extends State<LCarousel> {
  Timer _timer;
  PageController _controller;
  int _currentPageValue = 0;

  @override
  void initState() {
    super.initState();
    _controller = (widget.controller ?? PageController())
      ..addListener(
        () => setState(() {
          _currentPageValue = _getIndex(_controller.page.floor());
        }),
      );
    if (widget.autoScroll) {
      _timer = Timer.periodic(widget.interval, _initAutoRun);
    }
  }

  _initAutoRun(Timer _) {
    _gotoPage(pageNo: _getIndex(_currentPageValue + 1));
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
    _gotoPage(pageNo: _getIndex(_currentPageValue - 1));
  }

  _nextPage() {
    _timer.cancel();
    setState(() {
      _timer = Timer.periodic(widget.interval, _initAutoRun);
    });
    _gotoPage(pageNo: _getIndex(_currentPageValue + 1));
  }

  int _getIndex(int i) {
    if (i > widget.items.length - 1) {
      return 0;
    }
    if (i < 0) {
      return widget.items.length - 1;
    }
    return i;
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
            child: PageView.builder(
              pageSnapping: true,
              controller: _controller,
              physics: widget.canScroll
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return widget.items[_getIndex(index)];
              },
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
                      child: IconButton(
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
                      child: IconButton(
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
                          _currentPageValue,
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
