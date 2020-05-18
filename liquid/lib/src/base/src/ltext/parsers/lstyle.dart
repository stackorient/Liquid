import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class LTextStyle {
  final TextStyle style;
  final GestureRecognizer Function(Map<String, String> attrs) recognizerHandler;
  final String semanticsLabel;

  const LTextStyle({
    this.style,
    this.recognizerHandler,
    this.semanticsLabel,
  });

  LTextStyle operator +(LTextStyle other) {
    final GestureRecognizer Function(Map<String, String>) _rec =
        other.recognizerHandler != null
            ? other.recognizerHandler
            : recognizerHandler;

    final TextStyle _style = style.copyWith(
      inherit: other.style.inherit ?? style.inherit,
      color: other.style.color ?? style.color,
      backgroundColor: other.style.backgroundColor ?? style.backgroundColor,
      fontFamily: other.style.fontFamily ?? style.fontFamily,
      fontFamilyFallback:
          other.style.fontFamilyFallback ?? style.fontFamilyFallback,
      fontSize: other.style.fontSize ?? style.fontSize,
      fontWeight: other.style.fontWeight ?? style.fontWeight,
      fontStyle: other.style.fontStyle ?? style.fontStyle,
      letterSpacing: other.style.letterSpacing ?? style.letterSpacing,
      wordSpacing: other.style.wordSpacing ?? style.wordSpacing,
      textBaseline: other.style.textBaseline ?? style.textBaseline,
      height: other.style.height ?? style.height,
      locale: other.style.locale ?? style.locale,
      foreground: other.style.foreground ?? style.foreground,
      background: other.style.background ?? style.background,
      shadows: other.style.shadows ?? style.shadows,
      fontFeatures: other.style.fontFeatures ?? style.fontFeatures,
      decoration: other.style.decoration ?? style.decoration,
      decorationColor: other.style.decorationColor ?? style.decorationColor,
      decorationStyle: other.style.decorationStyle ?? style.decorationStyle,
      decorationThickness:
          other.style.decorationThickness ?? style.decorationThickness,
      debugLabel: other.style.debugLabel ?? style.debugLabel,
    );

    final _semanticsLabel = other.semanticsLabel ?? semanticsLabel;

    return LTextStyle(
      style: _style,
      recognizerHandler: _rec,
      semanticsLabel: _semanticsLabel,
    );
  }
}

class LSpanData {
  final String _className;
  final Map<String, String> _arguments;

  const LSpanData(this._className, this._arguments);

  String get className => _className;
  Map<String, String> get arguments => _arguments;

  @override
  String toString() => "$_className($_arguments)";
}

class LTextSpanBuilder {
  final Iterable<LSpanData> styles;
  final String text;

  const LTextSpanBuilder(this.styles, this.text);

  InlineSpan toTextSpan(Map<String, LTextStyle> styleMap) {
    LTextStyle effectiveStyle;
    Map<String, String> args;

    if (styles != null) {
      for (final style in styles) {
        if (!styleMap.containsKey(style.className))
          throw AssertionError(
              "The class ${style.className} not fount in StyleMap");

        if (effectiveStyle == null)
          effectiveStyle = styleMap[style.className];
        else
          effectiveStyle += styleMap[style.className];

        if (style.arguments != null) {
          if (args == null) {
            args = style.arguments;
          } else {
            args.addAll(style.arguments);
          }
        }
      }
    }

    final _span = TextSpan(
      text: text,
      style: effectiveStyle?.style,
      recognizer: effectiveStyle?.recognizerHandler(args),
      semanticsLabel: effectiveStyle?.semanticsLabel,
    );

    return _span;
  }

  @override
  String toString() {
    return "$styles $text";
  }
}
