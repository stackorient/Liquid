import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'ltext_style_provider.dart';
import 'parsers/parsers.dart';

class LText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextDirection textDirection;
  final bool softWrap;
  final TextOverflow overflow;
  final double textScaleFactor;
  final int maxLines;
  final Locale locale;
  final StrutStyle strutStyle;
  final TextWidthBasis textWidthBasis;
  final TextHeightBehavior textHeightBehavior;
  final SpanParser parser;
  final TextStyle baseStyle;
  final GestureRecognizer baseRecognizer;
  final String baseSemanticsLabel;

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
    this.baseStyle = const TextStyle(
      color: const Color(0xFF000000),
      height: 1.5,
      fontSize: 14.0,
    ),
    this.baseRecognizer,
    this.baseSemanticsLabel,
  })  : assert(text != null),
        parser = SpanParser(text),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final Map<String, LTextStyle> _styleMap = LTextStyleProvider.of(context);

    return RichText(
      text: TextSpan(
        children: _getSpans(_styleMap).toList(),
        style: baseStyle,
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
  }

  Iterable<TextSpan> _getSpans(Map<String, LTextStyle> styleMap) sync* {
    for (final styledText in parser.getSpans()) {
      yield styledText.toTextSpan(styleMap);
    }
  }
}
