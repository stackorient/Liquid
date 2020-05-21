import 'package:flutter/material.dart';

import '../../base/base.dart';

/// A card is a flexible and extensible content container.
/// It includes options for header [LCardHeader] and footer [LCardFooter], [LCardBody],
/// contextual background colors, and powerful display options.
///
class LCard extends StatelessWidget {
  /// Allows to give [image] in the body of the card.
  final LCardImage image;

  /// Widget type to add to the body of the card [LCardBody]
  ///
  /// See:
  ///  *  title
  ///  *  child
  ///  *  subTitle
  ///  *  titleStyle
  ///  *  padding
  ///  *  titleMargin
  ///
  final LCardBody body;

  /// Widget type to add to [header] part of card
  ///
  /// See:
  ///  *  title
  ///  *  padding
  ///  *  showSeperator
  final LCardHeader header;

  /// Widget type to add to [footer] part of card
  ///
  /// See:
  ///   *  actions
  ///   *  padding
  ///   *  mainAxisAlignment
  ///   *  crossAxisAlignment
  ///   *  showSeperator
  final LCardFooter footer;

  /// Card height
  final double height;

  /// Card width
  final double width;

  /// Card background color
  final Color color;

  /// Card border radius
  final double radius;

  /// Card Border `color`, `type` and `borderWidth`
  final BoxBorder border;

  /// Card Elevation
  final double elevation;

  /// A card is a flexible and extensible content container.
  /// It includes options for header [LCardHeader] and footer [LCardFooter], [LCardBody],
  /// contextual background colors, and powerful display options.
  ///
  /// Example:
  ///
  /// ```
  /// ...
  /// LCard(
  ///   elevation: 10.0,
  ///   header: LCardHeader(title: "title"),
  ///   footer: LCardFooter(
  ///     actions: <Widget>[Text('Footer')],
  ///   ),
  ///   color: Colors.white,
  ///   image: LCardImage(
  ///     image: NetworkImage(
  ///       'https://source.unsplash.com/random/',
  ///     ),
  ///   ),
  ///   body: LCardBody(
  ///     subTitle:
  ///         "hi how are you? @heyrjs and @heypnd ",
  ///     title: "Hello",
  ///     child: LOutlineButton.text(
  ///       text: "welcome",
  ///       type: ButtonType.dark,
  ///     ),
  ///   ),
  /// ),
  /// ...
  /// ```
  const LCard(
      {Key key,
      this.image,
      this.body,
      this.header,
      this.footer,
      this.height,
      this.width = 288.0,
      this.color,
      this.radius,
      this.border,
      this.elevation})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: height ?? double.infinity,
        maxWidth: width ?? double.infinity,
      ),
      child: Material(
        elevation: elevation ?? 0.0,
        borderRadius: BorderRadius.circular(radius ?? 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(radius ?? 5.0),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius ?? 5.0),
              border: border,
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
      ),
    );
  }
}

/// [LCard]'s header
class LCardFooter extends StatelessWidget {
  /// List of widget
  final List<Widget> actions;

  /// Padding
  final EdgeInsets padding;

  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;

  /// If `true`, renders with a top border
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

/// [LCard]'s header
class LCardHeader extends StatelessWidget {
  final String title;

  final EdgeInsets padding;

  /// if `true`, renders with a bottom border
  final bool showSeperator;

  /// [LCard]'s header
  ///
  /// `showSeperator` should not be `null`
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

/// [LCard]'s image
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
    return AspectRatio(
      aspectRatio: 1280 / 960,
      child: Container(
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
      ),
    );
  }
}

/// Creates [LCard]'s body with `title`, `subTitle`, `titleStyle`, `padding`, `titlemargin`
class LCardBody extends StatelessWidget {
  final String title;
  final Widget child;
  final String subTitle;
  final TextStyle titleStyle;
  final EdgeInsets padding;
  final EdgeInsets titleMargin;

  /// Creates [LCard]'s body with `title`, `subTitle`, `titleStyle`, `padding`, `titlemargin`
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
