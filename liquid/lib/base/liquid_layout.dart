import 'package:flutter/material.dart';

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

class ResponsiveBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) onXS;
  final Widget Function(BuildContext context) onSM;
  final Widget Function(BuildContext context) onMD;
  final Widget Function(BuildContext context) onLG;
  final Widget Function(BuildContext context) onXL;

  const ResponsiveBuilder(
      {Key key,
      @required this.onXS,
      this.onSM,
      this.onMD,
      this.onLG,
      this.onXL})
      : assert(onXS != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (onXL != null && constraints.maxWidth >= 1200) return onXL(context);
        if (onLG != null && constraints.maxWidth >= 992) return onLG(context);
        if (onMD != null && constraints.maxWidth >= 768) return onMD(context);
        if (onSM != null && constraints.maxWidth >= 576) return onSM(context);
        return onXS(context);
      },
    );
  }
}

enum BreakPoint { xs, sm, md, lg, xl }

class LColumn extends StatelessWidget {
  final int xs, sm, md, lg, xl;
  final List<Widget> children;
  final bool flexible;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection = VerticalDirection.down;
  final TextBaseline textBaseline;

  const LColumn({
    Key key,
    this.xs,
    this.sm = 1,
    this.md = 1,
    this.lg = 1,
    this.xl = 1,
    this.children,
    this.flexible = true,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.max,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.textDirection,
    this.textBaseline,
  })  : assert(xs == null || (xs <= 12 && xs >= 1)),
        assert(sm <= 12 && sm >= 1),
        assert(md <= 12 && md >= 1),
        assert(lg <= 12 && lg >= 1),
        assert(xl <= 12 && xl >= 1),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return LColumnRaw(children: _buildChildren(context));
  }

  List<Widget> _buildChildren(context) {
    if (flexible) {
      return children
          .map((e) => Flexible(
                fit: FlexFit.loose,
                child: e,
              ))
          .toList();
    }
    return children;
  }
}

class LRow extends StatelessWidget {
  final int columnCount = 12;
  final List<LColumn> children;

  // TODO: work on this
  final int cols;
  final MainAxisAlignment mainAxisAlignment;
  final MainAxisSize mainAxisSize;
  final CrossAxisAlignment crossAxisAlignment;
  final TextDirection textDirection;
  final VerticalDirection verticalDirection;
  final TextBaseline textBaseline;

  const LRow({
    Key key,
    this.children = const <LColumn>[],
    this.cols,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.mainAxisSize = MainAxisSize.min,
    this.crossAxisAlignment = CrossAxisAlignment.stretch,
    this.textDirection,
    this.verticalDirection = VerticalDirection.down,
    this.textBaseline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      onXS: (context) => _buildChildrens(context, BreakPoint.xs),
      onSM: (context) => _buildChildrens(context, BreakPoint.sm),
      onMD: (context) => _buildChildrens(context, BreakPoint.md),
      onLG: (context) => _buildChildrens(context, BreakPoint.lg),
      onXL: (context) => _buildChildrens(context, BreakPoint.xl),
    );
  }

  int _getFlex(LColumn child, BreakPoint breakPoint) {
    switch (breakPoint) {
      case BreakPoint.xs:
        return child.xs ?? -1;
        break;

      case BreakPoint.sm:
        return child.sm ?? -1;
        break;

      case BreakPoint.md:
        return child.md ?? -1;
        break;

      case BreakPoint.lg:
        return child.lg ?? -1;
        break;

      case BreakPoint.xl:
        return child.xl ?? -1;
        break;

      default:
        return child.xs ?? -1;
        break;
    }
  }

  List<dynamic> _preProcess(BreakPoint breakPoint) {
    final List<int> bp = [];
    bool _ = false;
    children.forEach((element) {
      bp.add(_getFlex(element, breakPoint));
      if (!_) _ = element.xs != null;
    });

    return [bp, _];
  }

  List<int> _fillEmpty(List<int> bps) {
    final List<int> _calBps = [];
    int totalCol = 0;
    int nullCols = 0;

    if (bps.length > columnCount) {
      print("More than 12 colums not suitable for row");
    }

    for (final val in bps) {
      totalCol += (val > 0 ? val : 0);
      if (val == -1) nullCols++;
    }

    final remaining = columnCount - totalCol;

    final colFlex = remaining ~/ (nullCols > 0 ? nullCols : 1);

    for (final val in bps) {
      if (val != -1)
        _calBps.add(val);
      else
        _calBps.add(colFlex);
    }

    return _calBps;
  }

  Widget _buildChildrens(BuildContext context, BreakPoint breakPoint) {
    int currentIndex = 0;
    final _processed = _preProcess(breakPoint);
    final _flexes = _fillEmpty(_processed[0] as List<int>);

    return LRowRaw(
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      crossAxisAlignment: crossAxisAlignment,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      textBaseline: textBaseline,
      direction: _processed[1]
          ? Axis.horizontal
          : (breakPoint == BreakPoint.xs ? Axis.vertical : Axis.horizontal),
      children: children.map(
        (child) {
          final flex = _flexes[currentIndex];
          currentIndex++;

          return Expanded(
            child: child,
            flex: flex,
          );
        },
      ).toList(),
    );
  }
}
