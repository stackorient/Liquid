import 'package:flutter/widgets.dart';

extension TextStyleExtension on TextStyle {
  TextStyle weight(FontWeight weight) => copyWith(fontWeight: weight);
  TextStyle withColor(Color color) => copyWith(color: color);
  TextStyle family(String family) => copyWith(fontFamily: family);
  TextStyle size(double size) => copyWith(fontSize: size);
  TextStyle highlight(Color color) => copyWith(backgroundColor: color);
  TextStyle italic() => copyWith(fontStyle: FontStyle.italic);
  TextStyle normal() => copyWith(fontStyle: FontStyle.normal);
}
