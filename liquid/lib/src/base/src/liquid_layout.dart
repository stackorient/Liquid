import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';
import 'env.dart';

/// No. of columns in each [LRow]
const _kColumnCount = 12;
const kXLBreakPoint = 1200.0;
const kLGBreakPoint = 992.0;
const kMDBreakPoint = 768.0;
const kSMBreakPoint = 576.0;

class LRowRaw extends Flex {
  final Axis direction;

  LRowRaw({
    Key key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline textBaseline,
    List<Widget> children = const <Widget>[],
    this.direction = Axis.horizontal,
  }) : super(
          children: children,
          key: key,
          direction: direction,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );
}

class LColumnRaw extends Flex {
  LColumnRaw({
    Key key,
    MainAxisAlignment mainAxisAlignment = MainAxisAlignment.start,
    MainAxisSize mainAxisSize = MainAxisSize.max,
    CrossAxisAlignment crossAxisAlignment = CrossAxisAlignment.center,
    TextDirection textDirection,
    VerticalDirection verticalDirection = VerticalDirection.down,
    TextBaseline textBaseline,
    List<Widget> children = const <Widget>[],
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
  }) : super(
          children: children,
          key: key,
          direction: Axis.vertical,
          mainAxisAlignment: mainAxisAlignment,
          mainAxisSize: mainAxisSize,
          crossAxisAlignment: crossAxisAlignment,
          textDirection: textDirection,
          verticalDirection: verticalDirection,
          textBaseline: textBaseline,
        );

  final int xs, sm, md, lg, xl;
}

class LResponsiveBuilder extends StatelessWidget {
  /// when `true`, [LResponsiveBuilder] will use Screen width instead of Parent Width
  /// for determining active [LBreakPoint]
  ///
  /// default: `false`
  ///
  /// See also:
  ///
  ///  * [LBox], a class which uses [LResponsiveBuilder]
  ///    to build its child on each [BreakPoint] with
  ///    `useMediaQuery = true` (default).
  ///
  final bool useMediaQuery;

  /// builder for `xs` [LBreakPoint]
  final Widget Function(BuildContext context) onXS;

  /// builder for `sm` [LBreakPoint]
  final Widget Function(BuildContext context) onSM;

  /// builder for `md` [LBreakPoint]
  final Widget Function(BuildContext context) onMD;

  /// builder for `lg` [LBreakPoint]
  final Widget Function(BuildContext context) onLG;

  /// builder for `xl` [LBreakPoint]
  final Widget Function(BuildContext context) onXL;

  /// Creates a widget that builds according to breakpoint.
  ///
  /// if `useMediaQuery` is `true`,
  /// Widget creation deferred until the layout.
  ///
  /// if `useMediaQuery` is `false`,
  /// Widget creation not deferred until the layout.
  ///
  /// **Note:** if builder is not defined for particular [BreakPoint]
  /// `onXS` builder will be used instead
  ///
  /// The `onXS` argument must not be null.
  ///
  /// =========================================
  ///
  /// `onXS` builder for `xs` [LBreakPoint]
  ///
  /// `onSM` builder for `sm` [LBreakPoint]
  ///
  /// `onMD` builder for `md` [LBreakPoint]
  ///
  /// `onLG` builder for `lg` [LBreakPoint]
  ///
  /// `onXL` builder for `xl` [LBreakPoint]
  ///
  /// See Also:
  ///
  /// * [LBox], a class which uses [LResponsiveBuilder]
  ///    to build its child on each [BreakPoint].
  const LResponsiveBuilder({
    Key key,
    @required this.onXS,
    this.onSM,
    this.onMD,
    this.onLG,
    this.onXL,
    this.useMediaQuery = false,
  })  : assert(onXS != null),
        assert(useMediaQuery != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    if (useMediaQuery) {
      final width = MediaQuery.of(context).size.width;
      return _build(context, width);
    } else {
      return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) =>
            _build(context, constraints.maxWidth),
      );
    }
  }

  Widget _build(BuildContext context, double width) {
    if (onXL != null && width >= kXLBreakPoint) return onXL(context);
    if (onLG != null && width >= kLGBreakPoint) return onLG(context);
    if (onMD != null && width >= kMDBreakPoint) return onMD(context);
    if (onSM != null && width >= kSMBreakPoint) return onSM(context);
    return onXS(context);
  }
}

class LBoxVisibility {
  final bool xs;
  final bool sm;
  final bool md;
  final bool lg;
  final bool xl;

  /// used in [LBox] and [LColumn] for `hiding (false)` or `showing(true)`
  /// of the child and children respectively
  /// on each [LBreakPoint]
  const LBoxVisibility({
    this.xs = true,
    this.sm = true,
    this.md = true,
    this.lg = true,
    this.xl = true,
  })  : assert(xs != null),
        assert(sm != null),
        assert(md != null),
        assert(lg != null),
        assert(xl != null);

  factory LBoxVisibility.all(bool value) => LBoxVisibility(
        xs: value,
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxVisibility.aboveXS(bool value) => LBoxVisibility(
        xs: !value,
        sm: value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxVisibility.aboveSM(bool value) => LBoxVisibility(
        xs: !value,
        sm: !value,
        md: value,
        lg: value,
        xl: value,
      );

  factory LBoxVisibility.aboveMD(bool value) => LBoxVisibility(
        xs: !value,
        sm: !value,
        md: !value,
        lg: value,
        xl: value,
      );

  factory LBoxVisibility.belowXL(bool value) => LBoxVisibility(
        xs: value,
        sm: value,
        md: value,
        lg: value,
        xl: !value,
      );
  factory LBoxVisibility.belowLG(bool value) => LBoxVisibility(
        xs: value,
        sm: value,
        md: value,
        lg: !value,
        xl: !value,
      );

  factory LBoxVisibility.belowMD(bool value) => LBoxVisibility(
        xs: value,
        sm: value,
        md: !value,
        lg: !value,
        xl: !value,
      );
}

/// BreakPoint
///
/// * `xs` : `width < 576px`
/// * `sm` : `width >= 576px`
/// * `md` : `width >= 768px`
/// * `lg` : `width >= 992px`
/// * `xl` : `width >= 1200px`
enum LBreakPoint {
  /// `width < 576px`
  xs,

  /// `width >= 576px`
  sm,

  /// `width >= 768px`
  md,

  /// `width >= 992px`
  lg,

  /// `width >= 1200px`
  xl,
}

class LColumn extends StatelessWidget {
  /// Control Visibility of [LColumn] on each breakpoint
  ///
  /// Below example, second column will be hidden in `md` and `xl` breakpoint
  ///
  /// example:
  /// ```dart
  /// LRow(
  ///   columns: [
  ///     LColumn(
  ///       children: <Widget>[
  ///         Container(height: 50.0, color: Colors.amber[800]),
  ///       ],
  ///     ),
  ///     LColumn(
  ///       visibility: LBoxVisibility(
  ///         md: false,
  ///         xl: false,
  ///       ),
  ///       children: <Widget>[
  ///         Container(height: 50.0, color: Colors.green[800]),
  ///       ],
  ///     ),
  ///   ],
  /// ),
  /// ```
  final LBoxVisibility visibility;

  /// Column span for breakpoint
  ///
  /// Note: if the total sum of spans in an [LRow] at any breakpoint is
  /// greater than 12 than an auto-calculated span will be 0.
  ///
  /// **NOTE:** To prevent this add a discrete column-span.
  final int xs, sm, md, lg, xl;

  final List<Widget> children;

  final bool _flexible;

  /// if `true`, Childrens will be wrapped in Flexible or Expanded
  ///
  /// if `expanded` is `true`, fit will be [FlexFit.tight] else [FlexFit.loose]
  bool get flexible => _flexible;

  final bool _expanded;

  /// if `expanded` is `true`, fit will be [FlexFit.tight] else [FlexFit.loose]
  ///
  /// for this to work `flexible` must be `true`
  bool get expanded => _expanded;

  /// How the children should be placed along the main axis in a column layout.
  ///
  /// default: `MainAxisAlignment.start`
  ///
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// default: `MainAxisSize.min`
  ///
  final MainAxisSize mainAxisSize;

  /// How the children should be placed along the cross axis in a column layout.
  ///
  ///default: `CrossAxisAlignment.center`
  ///
  final CrossAxisAlignment crossAxisAlignment;

  /// A direction in which text flows.
  final TextDirection textDirection;

  /// A horizontal line used for aligning text.
  final TextBaseline textBaseline;

  /// Creates a responsive column
  ///
  /// Generally, used in [LRow]
  ///
  /// Below example,
  /// * The columns will take `~8.33%` width of their parent in `xs` breakpoint.
  /// * The columns will take `~16.66%` and `~8.33%` width of their parent in each `sm` breakpoint.
  /// * The columns will take `~24.99%` width of their parent in each `md` breakpoint.
  /// * The columns will take `50%` width of their parent in each `lg` breakpoint.
  /// * The columns will take `~66.64%` and `~33.32%` width of their parent in each `xl` breakpoint.
  ///
  /// example:
  /// ```dart
  /// LRow(
  ///   columns: [
  ///     LColumn(
  ///       xs: 1,
  ///       sm: 2,
  ///       md: 3,
  ///       lg: 6,
  ///       xl: 8,
  ///       children: <Widget>[
  ///         Container(height: 50.0),
  ///       ],
  ///     ),
  ///     LColumn(
  ///       xs: 1,
  ///       sm: 1,
  ///       md: 3,
  ///       lg: 6,
  ///       xl: 4,
  ///       children: <Widget>[
  ///         Container(height: 50.0),
  ///       ],
  ///     )
  ///   ],
  /// ),
  /// ```
  ///
  /// #### NOTE:
  /// * By `default`, each breakpoint value will be auto determined to take equal width.
  /// * If any breakpoint not specified in [LColumn], `mode` is ignored for that breakpoint.
  /// * By `default`, columns are `vertical` on `xs` unless column has `xs` defined
  ///
  /// See Also:
  /// * [LRow], A Responsive Row that uses [LColumn] as its children
  LColumn({
    Key key,
    this.visibility = const LBoxVisibility(),
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    this.children = const [],
    bool flexible = true,
    bool expanded = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
  })  : assert(children != null),
        assert(xs == null || (xs <= 12 && xs >= 1)),
        assert(sm == null || sm <= 12 && sm >= 1),
        assert(md == null || md <= 12 && md >= 1),
        assert(lg == null || lg <= 12 && lg >= 1),
        assert(xl == null || xl <= 12 && xl >= 1),
        assert(expanded != null && flexible != null),
        _flexible = flexible,
        _expanded = expanded,
        super(key: key);

  /// [LColumn] for single child
  LColumn.child({
    Key key,
    this.visibility = const LBoxVisibility(),
    this.xs,
    this.sm,
    this.md,
    this.lg,
    this.xl,
    @required Widget child,
    bool flexible = true,
    bool expanded = false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
  })  : assert(child != null),
        assert(xs == null || (xs <= 12 && xs >= 1)),
        assert(sm == null || sm <= 12 && sm >= 1),
        assert(md == null || md <= 12 && md >= 1),
        assert(lg == null || lg <= 12 && lg >= 1),
        assert(xl == null || xl <= 12 && xl >= 1),
        assert(expanded != null && flexible != null),
        children = [child],
        _flexible = flexible,
        _expanded = expanded,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LColumnRaw(
        mainAxisAlignment: mainAxisAlignment,
        mainAxisSize: mainAxisSize,
        crossAxisAlignment: crossAxisAlignment,
        textDirection: textDirection,
        textBaseline: textBaseline,
        children: _buildChildren());
  }

  List<Widget> _buildChildren() {
    if (flexible) {
      return children
          .map((e) => Flexible(
                fit: expanded ? FlexFit.tight : FlexFit.loose,
                child: e,
              ))
          .toList();
    }
    return children;
  }
}

enum LGridMode {
  /// [LRow] will use ratio for calculating width of [LColumn]s
  ratio,

  /// [LRow] will use precise width for [LColumn]s
  fixedSize,
}

class LRow extends StatelessWidget {
  /// when `true`, [LResponsiveBuilder] will use Screen width instead of Parent Width
  /// for determining active [LBreakPoint]
  ///
  /// default: `false`
  ///
  final bool useMediaQuery;

  /// No. of columns allowed
  final int columnCount = _kColumnCount;

  /// List of [LColumn]
  final List<LColumn> columns;

  /// The width of the space between columns.
  /// [LRow] also applies a `vertical margin` equals to `gutter/2` by default.
  ///
  ///default: `5`
  ///
  /// To Remove default margin
  ///
  /// ```dart
  /// LRow(
  ///  ...
  ///   margin: EdgeInsets.zero,
  ///  ...
  /// )
  /// ```
  ///
  final double gutter;

  // TODO: work on this
  // final int cols;

  /// How the children should be placed along the main axis in layout.
  final MainAxisAlignment mainAxisAlignment;

  /// How much space should be occupied in the main axis.
  ///
  /// During a flex layout, available space along the main axis is allocated to
  /// children. After allocating space, there might be some remaining free space.
  /// This value controls whether to maximize or minimize the amount of free
  /// space, subject to the incoming layout constraints.
  ///
  /// if `null`, then it is determined based on the current
  /// breakpoint
  ///
  final MainAxisSize mainAxisSize;

  /// How the children should be placed along the cross axis in a flex layout.
  ///
  /// default: `CrossAxisAlignment.start`
  final CrossAxisAlignment crossAxisAlignment;

  /// Determines the order to lay children out horizontally and how to interpret
  /// `start` and `end` in the horizontal direction.
  ///
  /// Defaults to the ambient [Directionality].
  final TextDirection textDirection;

  /// If aligning items according to their baseline, which baseline to use.
  final TextBaseline textBaseline;

  /// Change the way columns are rendered
  ///
  /// default: `fixedSize` //LGridMode.fixedSize
  ///
  /// if `mode` is [LGridMode.fixedSize],
  /// columns with defined breakpoint will have precise width
  ///
  /// if `mode` is [LGridMode.ratio],
  /// columns with defined breakpoint will use ratio to
  /// calculate width
  final LGridMode mode;

  /// margin around the row
  final EdgeInsets margin;

  /// Creates a responsive Row
  ///
  /// Liquid's [LRow] is based on 12 column grid
  ///
  /// if `mode` is [LGridMode.fixedSize] [LColumn]s
  /// will take fixed size width for defined breakpoints.
  /// Below example, the column will take `~8.33%` width of their parent in each breakpoint.
  ///
  /// example:
  /// ```dart
  /// LRow(
  ///   mode: LGridMode.fixedSize, // default
  ///   columns: [
  ///     LColumn(
  ///       xs: 1,
  ///       sm: 1,
  ///       md: 1,
  ///       lg: 1,
  ///       xl: 1,
  ///       children: <Widget>[
  ///         Container(height: 50.0),
  ///       ],
  ///     ),
  ///     LColumn(
  ///       xs: 1,
  ///       sm: 1,
  ///       md: 1,
  ///       lg: 1,
  ///       xl: 1,
  ///       children: <Widget>[
  ///         Container(height: 50.0),
  ///       ],
  ///     )
  ///   ],
  /// ),
  /// ```
  ///
  /// if `mode` is [LGridMode.ratio] [LColumn]s will take width according to the ratio for defined breakpoints.
  /// Below example, the first column and second column
  /// will take `~16.66%` and `~83.33%` width respectively of their parent
  /// when breakpoint `lg` is triggered, otherwise by default
  /// each column will take equal spacing
  ///
  /// example:
  /// ```dart
  /// LRow(
  ///   mode: LGridMode.ratio,
  ///   columns: [
  ///     LColumn(
  ///       lg: 1,
  ///       children: <Widget>[
  ///         Container(height: 50.0),
  ///       ],
  ///     ),
  ///     LColumn(
  ///       lg: 5,
  ///       children: <Widget>[
  ///         Container(height: 50.0),
  ///       ],
  ///     )
  ///   ],
  /// ),
  /// ```
  /// #### NOTE:
  /// * By `default`, each column will take equal spacing if breakpoints are not specified.
  /// * If any breakpoint not specified in [LColumn], `mode` is ignored for that breakpoint.
  /// * By `default`, columns are `vertical` on `xs` unless at least one column has `xs` defined
  /// * If at any breakpoint, the total sum of breakpoint is greater than `12`,
  /// [LGridMode.ratio] will be used even if `mode` is set to other value
  ///
  ///
  const LRow({
    Key key,
    this.columns = const <LColumn>[],
    this.useMediaQuery = true,
    // this.cols,
    this.gutter,
    this.margin,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize,
    this.crossAxisAlignment,
    this.textDirection,
    this.textBaseline,
    this.mode = LGridMode.fixedSize,
  })  : assert(mode != null),
        assert(columns != null),
        assert(columns.length > 0,
            "You need to add atleast one column to the LRow"),
        assert(columns.length <= _kColumnCount,
            "Only $_kColumnCount Columns are allowed in each LRow"),
        assert(useMediaQuery != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? EdgeInsets.symmetric(vertical: (gutter ?? 5) / 2),
      child: LResponsiveBuilder(
        useMediaQuery: useMediaQuery,
        onXS: (context) => _buildChildrens(context, LBreakPoint.xs),
        onSM: (context) => _buildChildrens(context, LBreakPoint.sm),
        onMD: (context) => _buildChildrens(context, LBreakPoint.md),
        onLG: (context) => _buildChildrens(context, LBreakPoint.lg),
        onXL: (context) => _buildChildrens(context, LBreakPoint.xl),
      ),
    );
  }

  int _getFlex(LColumn child, LBreakPoint breakPoint) {
    switch (breakPoint) {
      case LBreakPoint.xl:
        return child.visibility.xl ? (child.xl ?? -1) : 0;
        break;

      case LBreakPoint.lg:
        return child.visibility.lg ? (child.lg ?? -1) : 0;
        break;

      case LBreakPoint.md:
        return child.visibility.md ? (child.md ?? -1) : 0;
        break;

      case LBreakPoint.sm:
        return child.visibility.sm ? (child.sm ?? -1) : 0;
        break;

      case LBreakPoint.xs:
      default:
        return child.visibility.xs ? (child.xs ?? -1) : 0;
        break;
    }
  }

  List<dynamic> _preProcess(LBreakPoint breakPoint) {
    final List<int> bp = [];
    bool _ = false;
    columns.forEach((element) {
      bp.add(_getFlex(element, breakPoint));
      if (!_) _ = element.xs != null;
    });

    return [bp, _];
  }

  List<int> _fillEmpty(List<int> bps) {
    final List<int> _calBps = [];
    int totalCol = 0;
    int nullCols = 0;

    for (final val in bps) {
      totalCol += (val > 0 ? val : 0);
      if (val == -1) nullCols++;
    }

    final remaining = columnCount - totalCol;

    final colFlex = remaining / (nullCols > 0 ? nullCols : 1);

    for (final val in bps) {
      if (val != -1)
        _calBps.add(val);
      else
        _calBps.add(colFlex.round());
    }

    int _colSum = _calBps.reduce((value, element) => value + element).round();

    if (mode == LGridMode.fixedSize && _colSum < columnCount) {
      _fillRemaining(_colSum);
      final diff = columnCount - _colSum;
      _calBps.add(diff);
      _colSum += diff;
    }

    if (lShowLogs && kDebugMode) {
      if (bps.length > columnCount) {
        print("Warning: More than $_kColumnCount colums not suitable for LRow");
      }

      if (_colSum > columnCount && mode == LGridMode.fixedSize) {
        print("Info: Changing LRow mode to LGridMode.ratio.");
        print(
            "Because LColums breakpoint sum is greater than $_kColumnCount!.");
      }
    }

    return _calBps;
  }

  void _fillRemaining(int totalFlex) {
    if (totalFlex < columnCount) {
      columns.add(LColumn());
    }
  }

  bool _isVisible(LColumn column, LBreakPoint breakPoint) {
    switch (breakPoint) {
      case LBreakPoint.xs:
        return column.visibility.xs;
        break;

      case LBreakPoint.sm:
        return column.visibility.sm;
        break;

      case LBreakPoint.md:
        return column.visibility.md;
        break;

      case LBreakPoint.lg:
        return column.visibility.lg;
        break;

      case LBreakPoint.xl:
        return column.visibility.xl;
        break;

      default:
        return column.visibility.xs;
        break;
    }
  }

  Widget _buildChildrens(BuildContext context, LBreakPoint breakPoint) {
    int currentIndex = 0;
    final _processed = _preProcess(breakPoint);
    final _flexes = _fillEmpty(_processed[0] as List<int>);

    final vertical =
        _processed[1] ? false : (breakPoint == LBreakPoint.xs ? true : false);
    final lastchild = columns.last;
    final firstChild = columns.first;
    return LRowRaw(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize:
          mainAxisSize ?? (vertical ? MainAxisSize.min : MainAxisSize.max),
      crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
      textDirection: textDirection,
      verticalDirection: VerticalDirection.down,
      textBaseline: textBaseline,
      direction: vertical ? Axis.vertical : Axis.horizontal,
      children: columns.map(
        (child) {
          final flex = _flexes[currentIndex];
          currentIndex++;

          if (_isVisible(child, breakPoint)) {
            if (!child.flexible && vertical) {
              return getPaddedChild(
                  flex, child, lastchild, vertical, firstChild);
            }
            return Flexible(
              fit: vertical ? FlexFit.loose : FlexFit.tight,
              child:
                  getPaddedChild(flex, child, lastchild, vertical, firstChild),
              flex: flex,
            );
          }
          return Container();
        },
      ).toList(),
    );
  }

  Padding getPaddedChild(int flex, LColumn child, LColumn lastchild,
      bool vertical, LColumn firstChild) {
    return Padding(
      padding: flex != 0
          ? EdgeInsets.only(
              right:
                  (child == lastchild || vertical) ? 0.0 : (gutter ?? 5.0) / 2,
              bottom: !vertical ? 0.0 : (gutter ?? 5.0),
              left:
                  (child == firstChild || vertical) ? 0.0 : (gutter ?? 5.0) / 2,
            )
          : EdgeInsets.zero,
      child: child,
    );
  }
}
