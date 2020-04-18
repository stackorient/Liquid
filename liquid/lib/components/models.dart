import 'package:flutter/material.dart';
import 'package:liquid/base/base.dart';

class LModelDialog extends StatelessWidget {
  final LModelHeader header;
  final LModelBody body;
  final LModelFooter footer;

  const LModelDialog({
    Key key,
    this.header,
    this.body,
    this.footer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          header ?? Container(),
          body ?? Container(),
          footer ?? Container(),
        ],
      ),
    );
  }
}

class LModelFooter extends StatelessWidget {
  final List<Widget> actions;
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final bool showSeperator;

  const LModelFooter({
    Key key,
    this.actions = const [],
    this.padding = const EdgeInsets.all(12.0),
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.showSeperator = true,
  })  : assert(actions != null),
        assert(padding != null),
        assert(showSeperator != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(
          top: showSeperator
              ? BorderSide(color: Colors.black12)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
        crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
        children: actions,
      ),
    );
  }
}

class LModelBody extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;

  const LModelBody({
    Key key,
    @required this.child,
    this.padding = const EdgeInsets.all(16.0),
  })  : assert(child != null),
        assert(padding != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: child,
    );
  }
}

class LModelHeader extends StatelessWidget {
  final String title;
  final Function onClose;
  final EdgeInsets padding;
  final bool showSeperator;

  const LModelHeader({
    Key key,
    @required this.title,
    this.onClose,
    this.padding = const EdgeInsets.all(16.0),
    this.showSeperator = true,
  })  : assert(title != null),
        assert(padding != null),
        assert(showSeperator != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context).typographyTheme;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        border: Border(
          bottom: showSeperator
              ? BorderSide(color: Colors.black12)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(title, style: theme.h5),
          Material(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.white,
            child: InkWell(
              borderRadius: BorderRadius.circular(20.0),
              child: Icon(Icons.close),
              onTap: () => _close(context),
            ),
          ),
        ],
      ),
    );
  }

  void _close(BuildContext context) async {
    if (onClose != null) onClose();

    await LAnimatedModel.of(context).closeModel();
  }
}

class LModel extends StatelessWidget {
  final LModelHeader header;
  final LModelBody body;
  final LModelFooter footer;
  final EdgeInsets margin;
  final MainAxisAlignment positon;
  final bool expand;

  // expand need to be true to use width
  final double width;

  LModel({
    Key key,
    this.header,
    this.body,
    this.footer,
    this.margin,
    this.positon,
    this.expand,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: positon ?? MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: (expand ?? false) ? width : 498.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4.0),
              border: Border.all(color: Colors.black12),
            ),
            margin: margin ?? const EdgeInsets.all(10.0),
            child: LModelDialog(
              header: header,
              body: body,
              footer: footer,
            ),
          ),
        ],
      ),
    );
  }
}

class LAnimatedModel extends StatefulWidget {
  final LModel model;
  final Tween<Offset> positionTween;
  final bool barrierDismissable;
  final Color backdropColor;

  const LAnimatedModel({
    Key key,
    @required this.model,
    this.positionTween,
    this.barrierDismissable,
    this.backdropColor,
  })  : assert(model != null),
        super(key: key);

  @override
  _LAnimatedModelState createState() => _LAnimatedModelState();

  static _LAnimatedModelState of(BuildContext context) {
    final _LAnimatedModelState animator =
        context.findAncestorStateOfType<_LAnimatedModelState>();

    return animator;
  }
}

class _LAnimatedModelState extends State<LAnimatedModel>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );
  }

  @override
  Widget build(BuildContext context) {
    _controller.forward();
    final size = MediaQuery.of(context).size;
    return Material(
      color: widget.backdropColor ?? Colors.black38,
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height,
          ),
          child: GestureDetector(
            onTap: widget.barrierDismissable
                ? () async => await closeModel()
                : null,
            child: SlideTransition(
              position: (widget.positionTween ??
                      Tween(begin: Offset(0.0, -10.0), end: Offset.zero))
                  .animate(
                CurvedAnimation(
                  parent: _controller,
                  curve: Curves.fastLinearToSlowEaseIn,
                ),
              ),
              child: FadeTransition(
                opacity: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _controller,
                    curve: Curves.ease,
                  ),
                ),
                child: Material(
                  color: widget.backdropColor ?? Colors.transparent,
                  child: GestureDetector(
                    onTap: () {}, // to prevent accidental closing
                    child: widget.model,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _close() async => await _controller.reverse();

  Future<void> closeModel() async {
    await _close();
    LiquidStateManager.of(context).popModel();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

void showLModel(
  BuildContext context, {
  @required LModel Function(BuildContext context) builder,
  Tween<Offset> positionTween,
  Color backdropColor,
  bool barrierDismissable,
}) {
  final overlay = Overlay.of(context);
  final model = OverlayEntry(
    builder: (context) => LAnimatedModel(
      model: builder(context),
      positionTween: positionTween,
      barrierDismissable: barrierDismissable,
      backdropColor: backdropColor,
    ),
  );
  overlay.insert(model);
  final _manager = LModelManager(model);
  LiquidStateManager.of(context).pushModel(_manager);
}
