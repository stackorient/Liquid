import 'package:flutter/material.dart';
import 'buttons.dart';

import '../../base/base.dart';

/// Heading for [LAlert]
class LAlertHeading extends StatelessWidget {
  final String text;
  final TextStyle style;
  final EdgeInsets padding;
  final Function onClose;

  const LAlertHeading({
    Key key,
    this.text,
    this.style,
    this.padding,
    this.onClose,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final alert = LAlert.of(context);
    final _sizeFactor =
        theme.getElementSizeFactor(alert.size ?? LElementSize.normal);

    final _textStyle = theme.typographyTheme.h6
        .weight(FontWeight.w700)
        .withColor(Colors.white);

    final _text = LText(
      text,
      baseStyle: style ??
          _textStyle.copyWith(fontSize: _textStyle.fontSize * _sizeFactor),
    );

    return Container(
      padding: padding ?? theme.alertTheme.headingPadding * _sizeFactor,
      decoration: BoxDecoration(
        color: theme.getTypeColor(alert?.type ?? LElementType.dark),
      ),
      child: onClose != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _text,
                LIconButton(
                  icon: Icon(Icons.close),
                  onPressed: onClose,
                  iconSize: 20.0 * _sizeFactor,
                  color: Colors.white,
                  fillColor: Colors.black12,
                  margin: EdgeInsets.zero,
                  splashThickness: 1.0,
                ),
              ],
            )
          : _text,
    );
  }
}

/// Create an alert box
class LAlert extends StatelessWidget {
  /// defines alert type
  final LElementType type;

  /// defines alert description text
  final String text;

  final Widget child;

  /// defines alert heading
  ///
  /// generally [LAlertHeading]
  final Widget heading;

  /// list of url
  final List<Uri> urls;

  final EdgeInsets margin;
  final EdgeInsets contentPadding;

  /// To style the alert description text
  final TextStyle style;

  final BorderRadius radius;

  final LElementSize size;

  /// Create an alert box
  ///
  /// example:
  /// ```
  /// ...
  ///
  /// LAlert(
  ///    "Aww yeah, you successfully read this important alert message.",
  ///    heading: "Well done!, @heyrjs and @heypnd",
  ///    type: LElementType.success,
  ///  ),
  ///...
  ///
  ///```
  ///See Also:
  ///* different type of `LElementType`
  ///
  ///     * `primary`
  ///     * `secondary`
  ///     * `success`
  ///     * `warning`
  ///     * `danger`
  ///     * `info`
  ///     * `light`
  ///     * `dark`
  ///
  ///

  const LAlert({
    Key key,
    this.text,
    this.child,
    this.heading,
    this.type = LElementType.primary,
    this.urls,
    this.margin,
    this.style,
    this.radius,
    this.size = LElementSize.normal,
    this.contentPadding,
  })  : assert(
          (text != null && child == null) || (text == null && child != null),
          "either text or child is required",
        ),
        assert(size != null),
        super(key: key);

  static LAlert of(BuildContext context) {
    final _ = context.findAncestorWidgetOfExactType<LAlert>();

    return _;
  }

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    final _color = theme.getTypeColor(type);
    return ClipRRect(
      borderRadius: radius ??
          BorderRadius.circular(5.0) * theme.getElementSizeFactor(size),
      child: Container(
        decoration: BoxDecoration(
          color: _color.withOpacity(0.1),
          border: Border(
              left: heading != null
                  ? BorderSide.none
                  : BorderSide(width: 5.0, color: _color)),
        ),
        child: _buildChild(theme),
      ),
    );
  }

  Widget _buildChild(LiquidThemeData theme) {
    final _color = theme.getTypeColor(type).darken(0.1);
    final _textStyle = theme.typographyTheme.p.withColor(_color);
    final _sizeFactor = theme.getElementSizeFactor(size);

    final _child = Container(
      padding: contentPadding ?? theme.alertTheme.padding * _sizeFactor,
      child: DefaultTextStyle.merge(
        style: style ??
            _textStyle.copyWith(
              fontSize: _textStyle.fontSize * _sizeFactor,
            ),
        child: child ?? LText(text),
      ),
    );

    if (heading != null) {
      final _childrens = <Widget>[
        heading,
        _child,
      ];

      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _childrens,
      );
    } else {
      return _child;
    }
  }
}
