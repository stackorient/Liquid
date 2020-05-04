import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class ScrollSpyController extends ScrollController {
  final Duration duration;
  final Curve curve;
  double Function(int) _lengthHandler;
  List<String> _uniqueIdList;

  List<double> _heightList;

  String _activeId;

  String get activeID => _activeId;

  ScrollSpyController({
    this.duration = const Duration(milliseconds: 350),
    this.curve = Curves.fastLinearToSlowEaseIn,
    double initialScrollOffset = 0.0,
    bool keepScrollOffset = true,
    String debugLabel,
  })  : assert(initialScrollOffset != null),
        assert(keepScrollOffset != null),
        assert(duration != null),
        assert(curve != null),
        super(
            initialScrollOffset: initialScrollOffset,
            keepScrollOffset: keepScrollOffset,
            debugLabel: debugLabel);

  void _generateHeightList() {
    double _offset = 0;
    _heightList = [];
    for (int i = 0; i < _uniqueIdList.length; i++) {
      _heightList.add(_offset);
      _offset += _lengthHandler(i);
    }
  }

  void scrollTo(String id) {
    final _stopIndex = _uniqueIdList.indexOf(id);
    final _offset = _heightList[_stopIndex];
    animateTo(_offset, duration: duration, curve: curve);
  }

  bool _onScroll(ScrollNotification notification) {
    final _offset = notification.metrics.pixels + 20.0;

    for (int i = 0; i < _heightList.length; i++) {
      final _firstOffset = _heightList[i];
      final _nextIndex = (i + 1) == _heightList.length ? i : (i + 1);
      final _secondOffset = _heightList[_nextIndex];

      if (_firstOffset == _secondOffset ||
          _offset >= _firstOffset && _offset <= _secondOffset) {
        _activeId = _uniqueIdList[i];
        break;
      }
    }
    return false;
  }
}

class ScrollSpy extends StatelessWidget {
  final Duration duration;
  final Curve curve;
  final ScrollSpyController controller;
  final List<String> uniqueIdList;
  final double itemExtent;
  final double Function(int) itemLengthBuilder;
  final Widget Function(BuildContext, int) itemBuilder;
  final int itemCount;
  final bool addAutomaticKeepAlives;
  final bool addRepaintBoundaries;
  final bool addSemanticIndexes;
  final double cacheExtent;
  final int semanticChildCount;
  final Axis scrollDirection;
  final bool reverse;
  final bool primary;
  final ScrollPhysics physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry padding;

  final DragStartBehavior dragStartBehavior;

  const ScrollSpy({
    Key key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    @required this.controller,
    this.duration,
    this.curve,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.dragStartBehavior = DragStartBehavior.start,
    @required this.uniqueIdList,
    this.itemExtent,
    @required this.itemBuilder,
    @required this.itemLengthBuilder,
    @required this.itemCount,
    this.addAutomaticKeepAlives = true,
    this.addRepaintBoundaries = true,
    this.addSemanticIndexes = true,
    this.cacheExtent,
    this.semanticChildCount,
  })  : assert(uniqueIdList != null),
        assert(itemCount != null),
        assert(uniqueIdList.length == itemCount),
        assert(controller != null),
        super(key: key);

  Widget _builder(BuildContext context, int index) {
    final _length = itemLengthBuilder(index);

    return Container(
      height: scrollDirection == Axis.vertical ? _length : null,
      width: scrollDirection == Axis.horizontal ? _length : null,
      child: itemBuilder(context, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller._lengthHandler = itemLengthBuilder;
    controller._uniqueIdList = uniqueIdList;
    controller._generateHeightList();

    return NotificationListener<ScrollNotification>(
      onNotification: controller._onScroll,
      child: ListView.builder(
        controller: controller,
        scrollDirection: scrollDirection,
        reverse: reverse,
        shrinkWrap: shrinkWrap,
        primary: primary,
        physics: physics,
        padding: padding,
        dragStartBehavior: dragStartBehavior,
        itemExtent: itemExtent,
        itemBuilder: _builder,
        itemCount: itemCount,
        addAutomaticKeepAlives: addAutomaticKeepAlives,
        addRepaintBoundaries: addRepaintBoundaries,
        addSemanticIndexes: addSemanticIndexes,
        cacheExtent: cacheExtent,
        semanticChildCount: semanticChildCount,
      ),
    );
  }
}
