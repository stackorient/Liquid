// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'ltext_style_provider.dart';
import 'parsers/parsers.dart';

/// A helper class that helps in disposing of [GestureRecognizer]
/// if present in [LText]
class _LTextBuilder extends StatefulWidget {
  /// List of all the [GestureRecognizer] present in child
  final List<GestureRecognizer> _recognizers;
  final Widget child;

  const _LTextBuilder({
    Key key,
    @required List<GestureRecognizer> recognizers,
    @required this.child,
  })  : assert(child != null),
        assert(recognizers != null),
        _recognizers = recognizers,
        super(key: key);

  @override
  _LTextBuilderState createState() => _LTextBuilderState();
}

class _LTextBuilderState extends State<_LTextBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void dispose() {
    widget._recognizers.forEach((recognizer) {
      recognizer.dispose();
    });
    super.dispose();
  }
}

/// The [LText] widget displays text that uses multiple different styles. The
/// text to display is described using a series of styleClass, and each of
/// which has an associated style [LStyleBlock] that is used for parsing of associated style.
/// The text might break across multiple lines or might all be displayed on the same line
/// depending on the layout constraints.
///
/// Example: The below example will create a text with bold, italic and underline style applied
///  to `World`
///
/// ```dart
/// ...
/// child: LText("Hello \l.bold.italic.underline{World}")
/// ```
///
/// See Also:
///   * [LStyleBlock], A StyleWrapper for building [LSpanStyle] Lazily or Eagerly
///   * [LSpanStyle], A StyleWrapper class for applying `styles`, `tranformation`,
///     `events` or `semanticsLabel`
class LText extends StatelessWidget {
  ///The text to display in [LText].
  final String text;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  ///The directionality of the text.
  ///
  ///This decides how [textAlign] values like [TextAlign.start] and [TextAlign.end] are interpreted.
  final TextDirection textDirection;

  ///Whether the text should break at soft line breaks.
  ///
  ///If false, the glyphs in the text will be positioned as if there was
  /// unlimited horizontal space.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  ///The number of font pixels for each logical pixel.
  ///
  ///For example, if the text scale factor is 1.5, text will
  /// be 50% larger than the specified font size.
  final double textScaleFactor;

  ///An optional maximum number of lines for the text to span, wrapping if necessary.
  ///If the text exceeds the given number of lines, it will be truncated according to [overflow].
  ///If this is 1, text will not wrap. Otherwise, text will be wrapped at the edge of the box.
  final int maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle strutStyle;

  /// {@macro flutter.widgets.text.DefaultTextStyle.textWidthBasis}
  final TextWidthBasis textWidthBasis;

  /// {@macro flutter.dart:ui.textHeightBehavior}
  final TextHeightBehavior textHeightBehavior;

  /// Parser for the [LText] text
  final SpanParser parser;

  /// The Style that should be applied to all
  /// the non parsed text
  final TextStyle baseStyle;

  /// The recognizer for whole [LText]
  ///
  /// Note: It will be overrided by recognizers
  /// of styleClasses
  final GestureRecognizer baseRecognizer;

  /// If not semantic label is provided to styleClasses
  /// use this
  final String baseSemanticsLabel;

  /// Added custom inline styleClasses
  ///
  /// Example:
  /// ```dart
  ///
  /// LText(
  ///   "\l.pinkText.superBold{@heyrjs}",
  ///
  ///   inlineStyleSheet: <String, LStyleBlock>{
  ///     "pinkText": LStyleBlock(
  ///       style: LSpanStyle(
  ///         style: TextStyle(color: Colors.pink),
  ///       ),
  ///     ),
  ///     "superBold": LStyleBlock(
  ///       style: LSpanStyle(
  ///         style: TextStyle(fontWeight: FontWeight.w700),
  ///       ),
  ///     )
  ///   },
  /// )
  /// ```
  final Map<String, LStyleBlock> inlineStyleSheet;

  /// Creates a paragraph of rich text.
  ///
  /// The [text] arguments must not be null.
  ///
  /// The [maxLines] property may be null (and indeed defaults to null), but if
  /// it is not null, it must be greater than zero.
  ///
  /// The [textDirection], if null, defaults to the ambient [Directionality],
  /// which in that case must not be null.
  ///
  /// **Example 1**: Create a paragraph with `@heyrjs` and `@heypnd` in bold and highlighted
  ///
  /// ```dart
  ///  LText("Hello, \l.bold.highlight{@heyrjs} and \l.bold.highlight(hex=#CCFCD4){@heypnd}"
  /// ```
  /// *Important*
  /// * here `.bold`, `.highlight` are the styleClasses defined in `kLiquidDefaultStyleSheet`
  ///
  ///---
  ///
  /// **Example 2**: Create a paragraph with `@heyrjs` and `@heypnd` in `green` and `blue` color
  /// respectively using inline styleSheet [inlineStyleSheet]
  ///
  /// ```dart
  /// LText("Hello, \l.green{@heyrjs} and \l.blue{heypnd}",
  ///
  ///   inlineStyleSheet: <String, LStyleBlock>{
  ///     "green": LStyleBlock(
  ///       style: LSpanStyle(
  ///         style: TextStyle(color: Colors.green),
  ///       ),
  ///     ),
  ///     "blue": LStyleBlock(
  ///       style: LSpanStyle(
  ///         style: TextStyle(color: Colors.blue),
  ///       ),
  ///     )
  ///   },
  /// )
  /// ```
  ///
  ///---
  ///
  ///**Example 3**: Create a paragraph with `@heyrjs` with variable `fontSize`
  /// based on arguments passed to styleClass using inline styleSheet [inlineStyleSheet]
  ///
  /// ```dart
  /// LText("Hello, \l.size(s=24.0){@heyrjs}",
  ///
  ///   inlineStyleSheet: <String, LStyleBlock>{
  ///     "size": LStyleBlock(
  ///       lazyStyle: (args) {
  ///         return LSpanStyle(
  ///           style: TextStyle(
  ///             fontSize: double.parse(args.get('s', '14.0' /* default */)),
  ///           ),
  ///         );
  ///       }
  ///     ),
  ///   },
  /// )
  /// ```
  /// ---
  ///
  /// **`PRO Tip`**: For App wide `StyleSheet` use [LiquidApp.styleSheet]
  ///
  /// See Also:
  /// * [LiquidApp.styleSheet], App wide StyleSheet for [LText]
  LText(
    this.text, {
    Key key,
    this.textAlign,
    this.textDirection,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis,
    this.textHeightBehavior,
    this.baseStyle,
    this.baseRecognizer,
    this.baseSemanticsLabel,
    this.inlineStyleSheet,
  })  : assert(text != null),
        parser = SpanParser(text),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, LStyleBlock> _styleMap = LTextStyleProvider.of(context);
    if (inlineStyleSheet != null) {
      _styleMap.addAll(inlineStyleSheet);
    }
    final _baseStyle =
        baseStyle ?? DefaultTextStyle.of(context).style.copyWith(height: 1.5);
    final _spanWrappers = _getSpans(_styleMap, _baseStyle);

    final RichText child = RichText(
      text: TextSpan(
        children: _spanWrappers.first,
        style: _baseStyle,
        recognizer: baseRecognizer,
        semanticsLabel: baseSemanticsLabel,
      ),
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection,
      softWrap: softWrap ?? true,
      overflow: overflow ?? TextOverflow.clip,
      textScaleFactor: textScaleFactor ?? 1.0,
      maxLines: maxLines,
      locale: locale,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis ?? TextWidthBasis.parent,
      textHeightBehavior: textHeightBehavior,
    );
    if (_spanWrappers.last != null) {
      return _LTextBuilder(recognizers: _spanWrappers.last, child: child);
    }
    return child;
  }

  List<dynamic> _getSpans(
      Map<String, LStyleBlock> styleMap, TextStyle baseTextStyle) {
    List<TextSpan> _spans = [];
    List<GestureRecognizer> _recs;

    for (final styledText in parser.getSpans()) {
      final _spanWrapper = styledText.toTextSpanWrap(styleMap, baseTextStyle);
      _spans.add(_spanWrapper.span);

      if (_recs != null && _spanWrapper.recognizer != null)
        _recs.add(_spanWrapper.recognizer);
      else if (_spanWrapper.recognizer != null)
        _recs = [_spanWrapper.recognizer];
    }

    return [_spans, _recs];
  }
}
