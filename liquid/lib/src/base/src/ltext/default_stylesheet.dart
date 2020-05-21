import 'package:flutter/widgets.dart';
import '../liquid_theme.dart';

import '../extensions/lextensions.dart';
import 'parsers/lstyle.dart';
import 'transformer.dart';

///Default Style Sheet for general usecases
///
///**Available styleClasses**
///* `bold`
///* `italic`
///* `underline`
///* `strikethrough`
///* `overline`
///* `capitalize`
///* `uppercase`
///* `lowercase`
///* `trim`
///* `trim-left`
///* `trim-right`
///* `color(hex=hex_color)`
///* `highlight(hex=hex_color)`
final Map<String, LStyleBlock> kLiquidDefaultStyleSheet = {
  "bold": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
  ),
  "italic": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(
      style: TextStyle(fontStyle: FontStyle.italic),
    ),
  ),
  "underline": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(
      style: TextStyle(decoration: TextDecoration.underline),
    ),
  ),
  "strikethrough": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(
      style: TextStyle(decoration: TextDecoration.lineThrough),
    ),
  ),
  "overline": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(
      style: TextStyle(decoration: TextDecoration.overline),
    ),
  ),
  "capitalize": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(textTransformers: [textCapitalize]),
  ),
  "uppercase": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(textTransformers: [(_) => _.toUpperCase()]),
  ),
  "lowercase": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(textTransformers: [(_) => _.toLowerCase()]),
  ),
  "trim": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(textTransformers: [(_) => _.trim()]),
  ),
  "trim-left": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(textTransformers: [(_) => _.trimLeft()]),
  ),
  "trim-right": LStyleBlock(
    lazyStyle: (_) => LSpanStyle(textTransformers: [(_) => _.trimRight()]),
  ),
  "color": LStyleBlock(
    lazyStyle: (args) {
      final hex = args.get("hex", "#000000");
      int code;

      switch (hex.length) {
        case 7:
          code = int.tryParse(hex.replaceFirst("#", "0xFF"));
          break;
        case 9:
          code = int.tryParse(hex.replaceFirst("#", "0x"));
          break;
      }

      return LSpanStyle(
        style: TextStyle(color: Color(code)),
      );
    },
  ),
  "highlight": LStyleBlock(
    lazyStyle: (args) {
      final hex = args.get("hex", "#fcf8e3");
      int code;

      switch (hex.length) {
        case 7:
          code = int.tryParse(hex.replaceFirst("#", "0xFF"));
          break;
        case 9:
          code = int.tryParse(hex.replaceFirst("#", "0x"));
          break;
      }

      return LSpanStyle(
        style: TextStyle(backgroundColor: Color(code)),
      );
    },
  )
};

/// typography styleSheet builder based on [LiquidTypography]
/// **Generates below styleClasses**
/// * `h1`
/// * `h2`
/// * `h3`
/// * `h4`
/// * `h5`
/// * `h6`
/// * `small`
/// * `p`
/// * `display1`
/// * `display2`
/// * `display3`
/// * `display4`
/// * `lead`
/// * `blockquote`
Map<String, LStyleBlock> buildTypographyStyleBlocks(
    LiquidTypography typography) {
  return {
    "h1": LStyleBlock(
      style: LSpanStyle(style: typography.h1),
    ),
    "h2": LStyleBlock(
      style: LSpanStyle(style: typography.h2),
    ),
    "h3": LStyleBlock(
      style: LSpanStyle(style: typography.h3),
    ),
    "h4": LStyleBlock(
      style: LSpanStyle(style: typography.h4),
    ),
    "h5": LStyleBlock(
      style: LSpanStyle(style: typography.h5),
    ),
    "h6": LStyleBlock(
      style: LSpanStyle(style: typography.h6),
    ),
    "small": LStyleBlock(
      style: LSpanStyle(style: typography.small),
    ),
    "p": LStyleBlock(
      style: LSpanStyle(style: typography.p),
    ),
    "display1": LStyleBlock(
      style: LSpanStyle(style: typography.display1),
    ),
    "display2": LStyleBlock(
      style: LSpanStyle(style: typography.display2),
    ),
    "display3": LStyleBlock(
      style: LSpanStyle(style: typography.display3),
    ),
    "display4": LStyleBlock(
      style: LSpanStyle(style: typography.display4),
    ),
    "lead": LStyleBlock(
      style: LSpanStyle(style: typography.lead),
    ),
    "blockquote": LStyleBlock(
      style: LSpanStyle(style: typography.quote),
    ),
  };
}
