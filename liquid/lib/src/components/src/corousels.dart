import 'dart:async';
import 'package:flutter/material.dart';
import 'buttons.dart';
import '../../base/base.dart';

// enum LCarouselAnimation { slide, fade }

///Add captions to your slides easily with the [LCarouselCaption] element
class LCarouselCaption extends StatelessWidget {
  /// Add `title` to the Carousel
  final String titleText;

  /// Add `subTitle` to the Carousel
  final String subTitleText;
  final TextStyle titleTextStyle;
  final TextStyle subTitleTextStyle;

  /// Add custom widget at `title`'s position
  final Widget title;

  ///Add custom widget at `subTitle`'s position
  final Widget subTitle;

  /// List of widget type
  final List<Widget> actions;

  ///Add captions to your slides easily with the [LCarouselCaption] element
  ///
  ///Example:
  ///```
  ///...
  ///
  ///caption: LCarouselCaption(
  ///          titleText: "First Slide",
  ///          subTitleText: "Cool Work by @heypnd and @heyrjs",
  ///          actions: <Widget>[
  ///            LFlatButton.text(
  ///              text: "Accept",
  ///              onPressed: _showModel,
  ///              margin: const EdgeInsets.only(top: 10.0),
  ///              small: true,
  ///            ),
  ///          ],
  ///        ),
  ///
  /// ...
  /// ```
  /// See:
  /// * [LCarousel], [LCarouselItem]
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

///  Add a new Slide or item to [LCarousel]
class LCarouselItem extends StatelessWidget {
  final double height;

  /// Add caption to the [LCarousel] by [LCarouseCaption]
  final LCarouselCaption caption;
  final Function onTap;

  //Add Widget.
  final Widget child;

  ///  Add a new Slide or item to [LCarousel]
  ///
  /// Example:
  /// ```
  /// ...
  /// LCarouselItem(
  ///     child: Image.network(
  ///       "https://source.unsplash.com/random/",
  ///       fit: BoxFit.cover,
  ///     ),
  ///     caption: LCarouselCaption(
  ///       titleText: "First Slide",
  ///       subTitleText: "Hello Liquid!",
  ///       actions: <Widget>[
  ///         LFlatButton.text(
  ///           text: "Accept",
  ///           onPressed: (){},
  ///           margin: const EdgeInsets.only(top: 10.0),
  ///           small: true,
  ///         ),
  ///       ],
  ///     ),
  ///   ),
  /// ...
  /// ```
  /// See:
  /// * [LCarousel], [LCarouselCaption]
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

const _maxPreviousPages = 1200000;

/// A slideshow component for cycling through elements—images
/// or slides of text—like a carousel.
///
/// Adding in the previous and next controls.
///
/// You can also add the indicators to the carousel, alongside the controls, too.
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
  final Duration duration;
  final Curve curve;
  final Widget Function(BuildContext context, int activeIndex) indicatorBuilder;

  final Color controlIconColor;
  final Color controlColor;

  ///
  ///A slideshow component for cycling through elements—images
  /// or slides of text—like a carousel.
  ///
  /// Carousels don’t automatically normalize slide dimensions.
  ///  As such, you may need to use additional utilities or custom styles to appropriately size content.
  ///  While carousels support previous/next controls and indicators, they’re not explicitly required.
  ///  Add and customize as you see fit.
  ///
  /// Example:
  ///
  /// ```
  /// ...
  /// LCarousel(
  ///    withCaption: true,
  ///    autoScroll: true,
  ///    withControls: true,
  ///    canScroll: true,
  ///    showIndicator: true,
  ///    enableIndicatorTapControl: true,
  ///    items: [
  ///      LCarouselItem(
  ///        child: Image.network(
  ///          "https://source.unsplash.com/random/?mountain",
  ///          fit: BoxFit.cover,
  ///        ),
  ///        caption: LCarouselCaption(
  ///          titleText: "First Slide",
  ///          subTitleText: "By @heypnd and @heyrjs",
  ///          actions: <Widget>[
  ///            LFlatButton.text(
  ///          text: "Accept",
  ///          onPressed: (){},
  ///          margin: const EdgeInsets.only(top: 10.0),
  ///          small: true,
  ///        ),
  ///        ],
  ///      ),
  ///    ),
  ///    LCarouselItem(
  ///      child: Image.network(
  ///        "https://source.unsplash.com/random/?mountain,sunset",
  ///        fit: BoxFit.cover,
  ///      ),
  ///    ),
  ///    LCarouselItem(
  ///      child: Image.network(
  ///        "https://source.unsplash.com/random/?sunrise",
  ///        fit: BoxFit.cover,
  ///      ),
  ///    ),
  ///  ],
  ///),
  /// ...
  /// ```
  const LCarousel({
    Key key,
    this.height,
    this.width,
    this.autoScroll = true,
    this.interval = const Duration(seconds: 8),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.fastLinearToSlowEaseIn,
    this.withControls = false,
    this.canScroll = true,
    this.showIndicator = false,
    this.enableIndicatorTapControl = false,
    this.withCaption = false,
    this.items = const <LCarouselItem>[],
    this.indicatorBuilder,
    this.controlIconColor,
    this.controlColor,
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
  int _currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: _maxPreviousPages);

    if (widget.autoScroll) {
      _timer = Timer.periodic(widget.interval, _initAutoRun);
    }
  }

  _initAutoRun(Timer _) {
    _controller.nextPage(
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  int _getPage(int index) {
    return _controller.page.floor() + (index - _currentPageIndex);
  }

  _gotoPage({int pageNo, bool reset = false}) {
    if (pageNo == _currentPageIndex) return;

    final _fakepage = _getPage(pageNo);

    if (reset) {
      _timer.cancel();
      setState(() {
        _timer = Timer.periodic(widget.interval, _initAutoRun);
      });
    }

    _controller.animateToPage(
      _fakepage ?? 0,
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  _previousPage() {
    _timer.cancel();
    setState(() {
      _timer = Timer.periodic(widget.interval, _initAutoRun);
    });
    _controller.previousPage(
      duration: widget.duration,
      curve: widget.curve,
    );
  }

  _nextPage() {
    _timer.cancel();
    setState(() {
      _timer = Timer.periodic(widget.interval, _initAutoRun);
    });
    _controller.nextPage(
      duration: widget.duration,
      curve: widget.curve,
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
            child: PageView.builder(
              pageSnapping: true,
              controller: _controller,
              onPageChanged: (int page) {
                setState(() {
                  _currentPageIndex = page % widget.items.length;
                });
              },
              physics: widget.canScroll
                  ? const AlwaysScrollableScrollPhysics()
                  : const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return widget.items[index % widget.items.length];
              },
            ),
          ),
          widget.withControls
              ? Positioned(
                  left: 0,
                  bottom: 0,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: LIconButton(
                      icon: Icon(Icons.chevron_left),
                      onPressed: _previousPage,
                      iconSize: 26.0,
                      color: widget.controlIconColor ?? Colors.white,
                      fillColor: widget.controlColor,
                    ),
                  ),
                )
              : Container(),
          widget.withControls
              ? Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: LIconButton(
                      icon: Icon(Icons.chevron_right),
                      onPressed: _nextPage,
                      iconSize: 26.0,
                      color: widget.controlIconColor ?? Colors.white,
                      fillColor: widget.controlColor,
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
                          _currentPageIndex,
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
          color: i == _currentPageIndex ? Colors.white : Colors.grey,
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
