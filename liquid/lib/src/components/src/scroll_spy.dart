import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

/// A Controller for [LScrollSpy] which is necessary to handle scroll
/// position or scrolling to a particular child id
class LScrollSpyController extends ScrollController {
  /// Duration in which [ScrollSpy] move from one child to another
  final Duration duration;

  /// Scroll animation curve
  final Curve curve;

  /// [ScrollSpy] child height
  double Function(int index, String id) _lengthHandler;

  /// [ScrollSpy] childs ids for determinig child position
  List<String> _uniqueIdList;

  List<double> _heightList;

  String _activeId;

  /// The minimum distance from the next
  /// child for which `activeID` should be updated
  ///
  /// default: `20.0`
  final double activeCheckOffset;

  /// Currently active [ScrollSpy]'s child id
  String get activeID => _activeId;

  /// A Controller for [LScrollSpy] which is necessary to handle scroll
  /// position or scrolling to a particular child id
  LScrollSpyController({
    this.duration = const Duration(milliseconds: 350),
    this.curve = Curves.fastLinearToSlowEaseIn,
    double initialScrollOffset = 0.0,
    bool keepScrollOffset = true,
    String debugLabel,
    this.activeCheckOffset = 20.0,
  })  : assert(initialScrollOffset != null),
        assert(keepScrollOffset != null),
        assert(duration != null),
        assert(curve != null),
        assert(activeCheckOffset != null),
        super(
          initialScrollOffset: initialScrollOffset,
          keepScrollOffset: keepScrollOffset,
          debugLabel: debugLabel,
        );

  void _generateHeightList() {
    double _offset = 0;
    _heightList = [];
    for (int i = 0; i < _uniqueIdList.length; i++) {
      _heightList.add(_offset);
      _offset += _lengthHandler(i, _uniqueIdList[i]);
    }
  }

  /// scroll to the child which has the provided id
  void scrollTo(String id) {
    final _stopIndex = _uniqueIdList.indexOf(id);
    final _offset = _heightList[_stopIndex];
    animateTo(_offset, duration: duration, curve: curve);
  }

  bool _onScroll(ScrollNotification notification) {
    final _offset = notification.metrics.pixels + activeCheckOffset;

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

typedef ItemExtentBuilder = double Function(int, String);

/// [LScrollSpy] can help in tracking certain elements and
/// which element the user's screen is currently centered on.
///
/// ### Example
/// In this example we will update the button color when a
///  certain element comes in view
///
/// ```dart
///  ScrollSpyController _controller;
///  List<String> ids = ["0", "1", "2", "3", "4", "5"];
///  String activeId;
///
///  initState() {
///     _controller = ScrollSpyController(activeCheckOffset: 150.0)
///        ..addListener(() {
///          setState(() {
///            activeId = _controller.activeID;
///          });
///        },
///     );
///
///     activeId = _controller.activeID ?? ids.first;
///  }
///
///...
///
///child: LCard(
///  width: 450.0,
///  body: LCardBody(
///    child: LRow(
///      useMediaQuery: false,
///      axis: LRowAxis(xs: Axis.horizontal),
///      columns: [
///        LColumn(
///          xs: 3,
///          children: [
///            for (final id in ids)
///              LFlatButton.text(
///                text: (int.parse(id) + 1).toString(),
///                type: activeId == id
///                    ? LElementType.warning
///                    : LElementType.primary,
///                onPressed: () => _controller.scrollTo(id),
///              )
///          ],
///        ),
///        LColumn(
///          children: [
///            Container(
///              height: 270.0,
///              child: LScrollSpy(
///                 controller: _controller,
///                 uniqueIdList: ids,
///                 itemBuilder: (context, index) => Container(
///                       color: Colors.blue[(index + 2) * 100],
///                       alignment: Alignment.center,
///                       child: LText(" \l.h1{ ${index + 1} }"),
///                     ),
///                 itemExtentBuilder: (index, id) => 270.0,
///                 itemCount: ids.length),
///            ),
///          ],
///        ),
///      ],
///    ),
///  ),
///),
///
///...
/// ```
///
/// See Also:
/// * [LScrollSpyController], A Controller for [LScrollSpy] which is necessary
///  to handle scroll position or scrolling to a particular child id
class LScrollSpy extends StatelessWidget {
  /// [LScrollSpyController] will handle the state of
  /// [LScrollSpy], listen to this to get `activeID` (child's id)
  ///
  /// * use `scrollTo` method to scroll to a particular child
  final LScrollSpyController controller;

  /// Each child in [LScrollSpy] is uniquely determined by these `id`
  ///
  /// Note: if duplicate ids found in list it can cause errors
  final List<String> uniqueIdList;

  /// Default item height for all the children
  ///
  /// **NOTE** set `itemExtentBuilder` = null when `itemExtent` is not null
  final double itemExtent;

  /// Different height of child based on their `uniqueId` or `index`
  ///
  /// **NOTE** don't provide `itemExtent` when using `itemExtentBuilder`
  final ItemExtentBuilder itemExtentBuilder;

  double _defaultExtentBuilder(_, __) => itemExtent;

  /// Creates a ScrollSpy, linear array of widgets that are created on demand.
  final Widget Function(BuildContext, int) itemBuilder;

  /// Providing a non-null itemCount which should match the length of `uniqueIdList`.
  final int itemCount;

  /// The addAutomaticKeepAlives argument corresponds to
  /// the [SliverChildBuilderDelegate.addAutomaticKeepAlives] property.
  final bool addAutomaticKeepAlives;

  ///The addRepaintBoundaries argument corresponds to
  ///the [SliverChildBuilderDelegate.addRepaintBoundaries] property.
  final bool addRepaintBoundaries;

  ///The addSemanticIndexes argument corresponds to the
  ///[SliverChildBuilderDelegate.addSemanticIndexes] property.
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

  const LScrollSpy({
    Key key,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    @required this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.dragStartBehavior = DragStartBehavior.start,
    @required this.uniqueIdList,
    this.itemExtent,
    @required this.itemBuilder,
    @required this.itemExtentBuilder,
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
        assert(
          itemExtentBuilder != null ||
              itemExtent == null && itemExtentBuilder == null ||
              itemExtent != null,
          "Provide either itemExtent or itemExtentBuilder",
        ),
        super(key: key);

  Widget _builder(BuildContext context, int index) {
    final _length = itemExtent ?? itemExtentBuilder(index, uniqueIdList[index]);

    return Container(
      height: scrollDirection == Axis.vertical ? _length : null,
      width: scrollDirection == Axis.horizontal ? _length : null,
      child: itemBuilder(context, index),
    );
  }

  @override
  Widget build(BuildContext context) {
    controller._lengthHandler =
        itemExtent != null ? _defaultExtentBuilder : itemExtentBuilder;
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
