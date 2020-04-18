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

  const LModelFooter({
    Key key,
    this.actions = const [],
    this.padding = const EdgeInsets.all(12.0),
  })  : assert(actions != null),
        assert(padding != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
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
          bottom: BorderSide(color: Colors.black12),
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
              onTap: onClose,
            ),
          ),
        ],
      ),
    );
  }
}

class LModel extends StatelessWidget {
  final LModelHeader header;
  final LModelBody body;
  final LModelFooter footer;

  const LModel({Key key, this.header, this.body, this.footer})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: Colors.black12),
      ),
      child: LModelDialog(
        header: header,
        body: body,
        footer: footer,
      ),
    );
  }
}

class LModelManager {
  const LModelManager();
}

class _LModelWrapper extends StatelessWidget {
  final OverlayEntry entry;
  final LModelManager _manager = const LModelManager();

  const _LModelWrapper({Key key, @required this.entry})
      : assert(entry != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void showLModel(BuildContext context) {
  final overlay = Overlay.of(context);
  final model = OverlayEntry(
      builder: (context) {
        return LModel();
      },
      opaque: true);

  overlay.insert(model);
}
