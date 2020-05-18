import 'package:flutter/widgets.dart';
import 'parsers/parsers.dart';

class LTextStyleProvider extends InheritedWidget {
  final Map<String, LTextStyle> _styleMap;

  LTextStyleProvider({
    Key key,
    @required Map<String, LTextStyle> styleMap,
    @required Widget child,
  })  : assert(styleMap != null),
        _styleMap = styleMap,
        super(key: key, child: child);

  static Map<String, LTextStyle> of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<LTextStyleProvider>()
      ._styleMap;

  @override
  bool updateShouldNotify(LTextStyleProvider oldWidget) {
    return oldWidget._styleMap != _styleMap;
  }
}
