// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:flutter/material.dart';
import 'ltext/ltext.dart';

import 'liquid_state_manager.dart';
import 'liquid_theme.dart';

class LiquidApp extends StatelessWidget {
  const LiquidApp({
    Key key,
    this.liquidTheme = const LiquidThemeData(),
    @required this.materialApp,
    this.styleSheet = const {},
  })  : assert(materialApp != null),
        assert(styleSheet != null),
        assert(liquidTheme != null),
        super(key: key);

  /// Material App
  final MaterialApp materialApp;

  /// change look and feel of your app
  /// from changing `colors` to individual components style
  ///
  /// NOTE: Liquid doesn't come with a dark theme you have to manage it manually.
  final LiquidThemeData liquidTheme;

  /// App wide StyleSheet for [LText]
  ///
  ///**By Default Liquid provides some common styleClasses**
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
  ///* `h1`
  ///* `h2`
  ///* `h3`
  ///* `h4`
  ///* `h5`
  ///* `h6`
  ///* `small`
  ///* `p`
  ///* `display1`
  ///* `display2`
  ///* `display3`
  ///* `display4`
  ///* `lead`
  ///* `blockquote`
  ///* `bullet` i.e. `○`
  /// **Example:** Hello, World with `World` in `bold` and `dodgerblue color`
  /// ```dart
  ///  LText("Hello, \l.bold.color(hex=#0980ff){Liquid}")
  /// ```
  final Map<String, LStyleBlock> styleSheet;

  @override
  Widget build(BuildContext context) {
    return LiquidStateManager(
      child: LTextStyleProvider(
        styleMap: {
          ...kLiquidDefaultStyleSheet,
          ...buildTypographyStyleBlocks(liquidTheme.typographyTheme),
          ...styleSheet,
        },
        child: LiquidTheme(
          theme: liquidTheme,
          child: materialApp,
        ),
      ),
    );
  }
}
