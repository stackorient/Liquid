import 'package:flutter/material.dart';

abstract class LOverlayManager<T extends State<StatefulWidget>> {
  final OverlayEntry _entry;
  final GlobalKey<T> key;

  const LOverlayManager(OverlayEntry entry, this.key)
      : assert(entry != null),
        _entry = entry;

  OverlayEntry get entry => _entry;

  Future<void> close();
}

class LiquidStates {
  final List<LOverlayManager> _modelManagers = [];

  void pushModel(LOverlayManager manager) {
    _modelManagers.add(manager);
  }

  Future<T> popModel<T>([T result]) async {
    final _ = _modelManagers.length > 0 ? _modelManagers.removeLast() : null;
    await _?.close();
    return result;
  }
}

class LiquidStateManager extends InheritedWidget {
  final Widget child;
  final LiquidStates _states;

  LiquidStateManager({Key key, @required this.child})
      : _states = LiquidStates(),
        super(key: key, child: child);

  static LiquidStates of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<LiquidStateManager>()
        ._states;
  }

  @override
  bool updateShouldNotify(LiquidStateManager oldWidget) {
    return oldWidget._states != _states;
  }
}
