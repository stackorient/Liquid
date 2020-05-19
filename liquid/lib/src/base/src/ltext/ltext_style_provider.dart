import 'package:flutter/widgets.dart';
import 'parsers/parsers.dart';

class LTextStyleProvider extends InheritedWidget {
  final Map<String, LStyleBlock> _styleMap;

  LTextStyleProvider({
    Key key,
    @required Map<String, LStyleBlock> styleMap,
    @required Widget child,
  })  : assert(styleMap != null),
        _styleMap = styleMap,
        super(key: key, child: child);

  static Map<String, LStyleBlock> of(BuildContext context) =>
      context
          .dependOnInheritedWidgetOfExactType<LTextStyleProvider>()
          ?._styleMap ??
      {};

  @override
  bool updateShouldNotify(LTextStyleProvider oldWidget) {
    return oldWidget._styleMap != _styleMap;
  }
}
