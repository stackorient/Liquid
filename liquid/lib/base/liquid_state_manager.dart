import 'package:flutter/material.dart';

class LModelManager {
  final OverlayEntry _entry;

  const LModelManager(OverlayEntry entry)
      : assert(entry != null),
        _entry = entry;

  void close() {
    _entry.remove();
  }
}

class LiquidStates {
  final List<LModelManager> _modelManagers = [];

  void pushModel(LModelManager manager) {
    _modelManagers.add(manager);
  }

  void popModel() {
    final _ = _modelManagers.length > 0 ? _modelManagers.removeLast() : null;
    _?.close();
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
