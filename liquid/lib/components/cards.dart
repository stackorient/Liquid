part of 'components.dart';

class LCard extends StatelessWidget {
  final LCardImage image;
  final LCardBody body;
  final LCardHeader header;
  final LCardFooter footer;
  final double height;
  final double width;

  final Color color;
  final double radius;
  final BoxBorder border;
  final double elevation;
  const LCard(
      {Key key,
      this.image,
      this.body,
      this.header,
      this.footer,
      this.height,
      this.width,
      this.color,
      this.radius,
      this.border,
      this.elevation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius ?? 5.0),
      child: Material(
        elevation: elevation ?? 0.0,
        borderRadius: BorderRadius.circular(radius ?? 5.0),
        child: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 5.0),
            border: border ?? Border.all(color: Colors.black12, width: 1.0),
            color: color,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              header ?? Container(),
              image ?? Container(),
              body ?? Container(),
              footer ?? Container(),
            ],
          ),
        ),
      ),
    );
  }
}

class LCardFooter extends StatelessWidget {
  final List<Widget> actions;
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool showSeperator;

  const LCardFooter({
    Key key,
    this.actions = const [],
    this.padding = const EdgeInsets.all(12.0),
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.showSeperator = true,
  })  : assert(actions != null),
        assert(padding != null),
        assert(showSeperator != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(
          top: showSeperator
              ? BorderSide(color: Colors.black12)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: actions,
      ),
    );
  }
}

class LCardHeader extends StatelessWidget {
  final String title;

  final EdgeInsets padding;
  final bool showSeperator;

  const LCardHeader({
    Key key,
    @required this.title,
    this.padding = const EdgeInsets.all(16.0),
    this.showSeperator = true,
  })  : assert(title != null),
        assert(padding != null),
        assert(showSeperator != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context).typographyTheme;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(
          bottom: showSeperator
              ? BorderSide(color: Colors.black12)
              : BorderSide.none,
        ),
      ),
      child: Text(title, style: theme.h5),
    );
  }
}

class LCardImage extends StatelessWidget {
  final ImageProvider image;
  final double height;
  final double width;
  final Widget child;
  final void Function(dynamic, StackTrace) onError;
  final ColorFilter colorFilter;
  final BoxFit fit;
  final AlignmentGeometry alignment;
  final Rect centerSlice;
  final ImageRepeat repeat;
  final bool matchTextDirection;

  LCardImage(
      {Key key,
      @required this.image,
      this.child,
      this.height = 180.0,
      this.width = 286.0,
      this.onError,
      this.colorFilter,
      this.fit,
      this.alignment,
      this.centerSlice,
      this.repeat,
      this.matchTextDirection})
      : assert(image != null),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: child ?? Container(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          colorFilter: colorFilter,
          fit: fit ?? BoxFit.fill,
          alignment: alignment ?? Alignment.topCenter,
          centerSlice: centerSlice,
          repeat: repeat ?? ImageRepeat.noRepeat,
          matchTextDirection: matchTextDirection ?? true,
        ),
      ),
    );
  }
}

class LCardBody extends StatelessWidget {
  final String title;
  final Widget child;
  final String subTitle;
  final TextStyle titleStyle;
  final EdgeInsets padding;
  final EdgeInsets titleMargin;
  const LCardBody(
      {Key key,
      this.title,
      this.child,
      this.subTitle,
      this.titleStyle,
      this.padding,
      this.titleMargin})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    return Container(
      padding: padding ?? EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          title != null
              ? Padding(
                  padding: titleMargin ?? const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    title,
                    style: titleStyle ?? theme.typographyTheme.h5,
                  ),
                )
              : Container(),
          subTitle != null
              ? Padding(
                  padding: titleMargin ?? const EdgeInsets.only(bottom: 6.0),
                  child: Text(
                    subTitle,
                    style: titleStyle ?? theme.typographyTheme.p,
                  ),
                )
              : Container(),
          child ?? Container()
        ],
      ),
    );
  }
}
