import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';
import '../../extensions/lextensions.dart';

typedef RecognizerHandler = GestureRecognizer Function(
    Map<String, String> attrs);

typedef TextTransformer = String Function(String);

/// A StyleWrapper class for applying
/// `styles`, `tranformation`, `adding events` or `semanticsLabel`
///
/// Example: A basic H1 text style
/// ```dart
///
/// ```
///
/// See Also:
/// * [LStyleBlock], A Wrapping class for building
/// LSpanStyle Lazily or Eagerly
class LSpanStyle {
  ///List of [TextTransformer] for applying transformation before rendering text
  ///
  ///Example: Implementation of `uppercase` styleClass
  ///```dart
  ///"uppercase": LStyleBlock(
  ///  lazyStyle: (_) => LSpanStyle(textTransformers: [(_) => _.toUpperCase()]),
  ///),
  ///...
  ///
  ///
  ///child: LText("Hello \l.uppercase{World}") // output -> Hello WORLD
  ///
  ///```
  final List<TextTransformer> textTransformers;
  final TextStyle style;

  /// A Lazily loaded recognizer for with arguments
  /// from the parsed styleClasses
  ///
  /// Example: Implementation of `link` styleClass
  /// ```dart
  /// "link": LStyleBlock(lazyStyle: (args) {
  ///  return LSpanStyle(
  ///    style: TextStyle(
  ///      color: Colors.blue[800],
  ///      decoration: TextDecoration.underline,
  ///    ),
  ///    recognizerHandler: (attrs) => TapGestureRecognizer()
  ///      ..onTap = () {
  ///
  ///        final href = attrs.get("href", "https://default.com");
  ///        launch(href);
  ///      },
  ///  );
  ///}),
  ///...
  ///
  ///child: LText("for more information \l.link(href=https://example.com){click here}")
  ///```
  final RecognizerHandler recognizerHandler;

  /// An alternative semantics label for this [TextSpan].
  /// If present, the semantics of this span will contain this value instead of the actual text.
  /// This is useful for replacing abbreviations or shorthands with the full text value.
  ///
  /// **Note**: The styleClasses in [LText] are parsed from left to right
  /// and thus semanticsLabel will be used from the last parsed [LSpanStyle]
  /// with not null semanticsLabel.
  ///
  ///Example:
  ///```dart
  /// LText("Helo \l.class1.class2.class3{World},),
  ///```
  ///
  ///In above example, the semanticsLabel preference order will be
  ///`class3` -> `class2` -> `class1`
  final String semanticsLabel;

  const LSpanStyle({
    this.style,
    this.recognizerHandler,
    this.semanticsLabel,
    this.textTransformers = const [],
  });

  LSpanStyle operator +(LSpanStyle other) {
    final GestureRecognizer Function(Map<String, String>) _rec =
        other.recognizerHandler != null
            ? other.recognizerHandler
            : recognizerHandler;

    final TextStyle _style = other.style != null
        ? style?.copyWith(
              inherit: other.style.inherit ?? style.inherit,
              color: other.style.color ?? style.color,
              backgroundColor:
                  other.style.backgroundColor ?? style.backgroundColor,
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
              decorationColor:
                  other.style.decorationColor ?? style.decorationColor,
              decorationStyle:
                  other.style.decorationStyle ?? style.decorationStyle,
              decorationThickness:
                  other.style.decorationThickness ?? style.decorationThickness,
              debugLabel: other.style.debugLabel ?? style.debugLabel,
            ) ??
            other.style
        : style;

    final _semanticsLabel = other.semanticsLabel ?? semanticsLabel;

    return LSpanStyle(
      style: _style,
      recognizerHandler: _rec,
      semanticsLabel: _semanticsLabel,
      textTransformers: [...textTransformers, ...other.textTransformers],
    );
  }
}

typedef LTextStyleLazyBuilder = LSpanStyle Function(Map<String, String> args);

/// A StyleWrapper for building [LSpanStyle] Lazily or Eagerly
///
/// **NOTE:** You can provide either `style` (Eagerly) or `lazyStyle` (Lazily)
///
/// ### When to use what?
///
/// #### `style`
/// * Use `style` if you want to reuse the same style again and again.
///
///**Example:**
/// ```dart
///"dark_Text": LStyleBlock(
///   style: LSpanStyle(
///     style: TextStyle(
///       color: Colors.blue[900],
///     ),
///   ),
///),
///...
///
///
///LText("Liquid \l.dark_Text{Text}")
/// ```
///
/// #### `lazyStyle`
/// * Use `lazyStyle` if you want to build style based on `args` passed to styleClass
///
/// **Example:**
/// ```dart
///"blue_text_styleClass": LStyleBlock(
///   lazyStyle: (args) => LSpanStyle(
///     style: TextStyle(
///       color: Colors.blue[int.parse(args.get("code", "400" /*default*/))],
///     ),
///   ),
///),
///...
///
///LText("Liquid \l.blue_text_styleClass(code=800){Text}")
/// ```
///
/// When you want to access  `code` and `800` in above example
/// you should use `lazyStyle`
///
class LStyleBlock {
  final LTextStyleLazyBuilder lazyStyle;
  final LSpanStyle style;

  /// A StyleWrapper for building [LSpanStyle] Lazily or Eagerly
  ///
  /// **NOTE:** You can provide either `style` (Eagerly) or `lazyStyle` (Lazily)
  ///
  /// ### When to use what?
  ///
  /// #### `style`
  /// * Use `style` if you want to reuse the same style again and again.
  ///
  ///**Example:**
  /// ```dart
  ///"dark_Text": LStyleBlock(
  ///   style: LSpanStyle(
  ///     style: TextStyle(
  ///       color: Colors.blue[900],
  ///     ),
  ///   ),
  ///),
  ///...
  ///
  ///
  ///LText("Liquid \l.dark_Text{Text}")
  /// ```
  ///
  /// #### `lazyStyle`
  /// * Use `lazyStyle` if you want to build style based on `args` passed to styleClass
  ///
  /// **Example:**
  /// ```dart
  ///"blue_text_styleClass": LStyleBlock(
  ///   lazyStyle: (args) => LSpanStyle(
  ///     style: TextStyle(
  ///       color: Colors.blue[int.parse(args.get("code", "400" /*default*/))],
  ///     ),
  ///   ),
  ///),
  ///...
  ///
  ///LText("Liquid \l.blue_text_styleClass(code=800){Text}")
  /// ```
  ///
  /// When you want to access  `code` and `800` in above example
  /// you should use `lazyStyle`
  ///
  LStyleBlock({this.lazyStyle, this.style})
      : assert(
            lazyStyle != null && style == null ||
                lazyStyle == null && style != null,
            "Provide either lazyStyle or style.");

  LSpanStyle getStyle(Map<String, String> args) => style ?? lazyStyle(args);
}

/// Tokenized styleClass
///
/// See Also:
/// * [ClassParser], Used to tokenize the styleClass in parsed [LText] string
/// * [ArgumentParser], Used to parse the argument from styleClass
/// * [SpanParser], Used to parse [LText]'s text and tokenization of styleClass
///
class LSpanToken {
  /// tokenized name of the styleClass
  final String _className;

  /// tokenized arguments passed with styleClass
  final Map<String, String> _arguments;

  const LSpanToken(this._className, this._arguments);

  String get className => _className;
  Map<String, String> get arguments => _arguments;

  @override
  String toString() => "$_className($_arguments)";
}

/// A Helper class for accessing [InlineSpan] and
/// its associated [GestureRecognizer]
class _LTextSpanRecognizerWrapper {
  final InlineSpan span;
  final GestureRecognizer recognizer;

  /// A Helper class for accessing [InlineSpan] and
  /// its associated [GestureRecognizer]
  _LTextSpanRecognizerWrapper(this.span, this.recognizer);
}

/// Builder class that builds [LText] with all the applied styleClass
class LTextSpanBuilder {
  /// List of styleClass token [LSpanToken]
  final Iterable<LSpanToken> styles;

  /// text on which all the `styles` should be applid
  final String text;

  /// Builder class that builds [LText] with all the applied styleClass
  ///
  /// See Also:
  /// * [LSpanToken], Tokenized styleClass
  const LTextSpanBuilder(this.styles, this.text);

  /// get effective style by merging overlapping styles from
  /// left to right
  ///
  /// **Note**: [LText] parses from left to right
  /// thus each left styleClass is merged with the right styleClass
  /// because of this if classA has color property set to green and next
  /// classB has color property set to blue then LText will be in blue color
  ///
  /// Example:
  /// ```dart
  ///
  /// LText(
  ///   "\l.classA.classB{@heyrjs}"
  ///
  ///   inlineStyleSheet: <String, LStyleBlock>{
  ///     "classA": LStyleBlock(
  ///       style: LSpanStyle(
  ///         style: TextStyle(color: Colors.green, fontWeight: FontWeight.w700),
  ///       ),
  ///     ),
  ///     "classB": LStyleBlock(
  ///       style: LSpanStyle(
  ///         style: TextStyle(color: Colors.blue),
  ///       ),
  ///     )
  ///   },
  /// )
  /// ```
  ///
  /// In above example, [LText] will be in blue color and will have a fontWeight of 700
  ///
  _LTextSpanRecognizerWrapper toTextSpanWrap(
      Map<String, LStyleBlock> styleMap) {
    LSpanStyle effectiveStyle;
    Map<String, String> args;
    String effectiveText = text;

    if (styles != null) {
      for (final style in styles) {
        if (!styleMap.containsKey(style.className)) continue;

        if (effectiveStyle == null)
          effectiveStyle =
              styleMap.get(style.className).getStyle(style.arguments);
        else
          effectiveStyle +=
              styleMap.get(style.className).getStyle(style.arguments);

        if (style.arguments != null) {
          if (args == null) {
            args = style.arguments;
          } else {
            args.addAll(style.arguments);
          }
        }
      }
    }

    if (effectiveStyle?.textTransformers != null)
      for (final transformer in effectiveStyle.textTransformers)
        effectiveText = transformer(text);

    GestureRecognizer _recognizer;
    if (effectiveStyle?.recognizerHandler != null) {
      _recognizer = effectiveStyle?.recognizerHandler(args);
    }

    final _span = TextSpan(
      text: effectiveText,
      style: effectiveStyle?.style,
      recognizer: _recognizer,
      semanticsLabel: effectiveStyle?.semanticsLabel,
    );

    return _LTextSpanRecognizerWrapper(_span, _recognizer);
  }

  @override
  String toString() {
    return "$styles $text";
  }
}
