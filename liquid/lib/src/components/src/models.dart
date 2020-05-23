import 'package:flutter/material.dart';

import '../../base/base.dart';
import 'buttons.dart';

///Dialogs for lightboxes, user notifications, or completely custom content.
///
///**NOTE** : [LModelDialog] is a helper class for building [LModel]
class LModelDialog extends StatelessWidget {
  /// Dialog header which can be used for headings adding close callbacks
  final LModelHeader header;

  /// Dialogs content body
  final LModelBody body;

  /// Dialigs footer area for extra actions
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

/// A footer for [LModel] to include extra actions
///
/// See Also:
/// * [LModelHeader], display a header with `title` text and an optional `onClose` callback
/// on [LModel]
/// * [LModelBody], [LModel] body content
class LModelFooter extends StatelessWidget {
  /// List of widgets that should be represented
  /// in a Row
  final List<Widget> actions;
  final EdgeInsets padding;
  final MainAxisAlignment mainAxisAlignment;
  final CrossAxisAlignment crossAxisAlignment;
  final Color seperatorColor;
  final Color background;

  /// show the border seperator between [LDialogBody] and `this` footer
  final bool showSeperator;

  const LModelFooter({
    Key key,
    this.actions = const [],
    this.padding = const EdgeInsets.all(12.0),
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.showSeperator = true,
    this.seperatorColor,
    this.background,
  })  : assert(actions != null),
        assert(padding != null),
        assert(showSeperator != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        border: Border(
          top: showSeperator
              ? BorderSide(color: seperatorColor ?? Colors.black12)
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

/// [LModel] body content
///
/// See Also:
/// * [LModelFooter], A footer for [LModel] to include extra actions
/// * [LModelHeader], Display a header with `title` text and an optional `onClose` callback
/// on [LModel]
class LModelBody extends StatelessWidget {
  final Widget child;

  final Color background;

  /// Padding around the body child
  final EdgeInsets padding;

  const LModelBody({
    Key key,
    @required this.child,
    this.padding = const EdgeInsets.all(16.0),
    this.background,
  })  : assert(child != null),
        assert(padding != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      padding: padding,
      child: child,
    );
  }
}

/// [LModelHeader] display a header with `title` text and an optional `onClose` callback
/// on [LModel]
///
/// See Also:
/// * [LModelFooter], A footer for [LModel] to include extra actions
/// * [LModelBody], [LModel] body content
class LModelHeader extends StatelessWidget {
  /// title for the header
  ///
  /// cannot be `null`
  final String title;

  /// callback when this model is closed
  final VoidCallback onClose;

  /// space around the content of [LModelHeader]
  final EdgeInsets padding;

  /// if `true`, a border seperator will be drawn between [LModelBody]
  /// and [LModelHeader]
  final bool showSeperator;

  final Color seperatorColor;

  final Color background;
  final Color closeButtonColor;

  const LModelHeader({
    Key key,
    @required this.title,
    this.onClose,
    this.padding = const EdgeInsets.all(16.0),
    this.showSeperator = true,
    this.background,
    this.closeButtonColor,
    this.seperatorColor,
  })  : assert(title != null),
        assert(padding != null),
        assert(showSeperator != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context).typographyTheme;
    final _baseStyle = DefaultTextStyle.of(context).style;
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: background,
        border: Border(
          bottom: showSeperator
              ? BorderSide(color: seperatorColor ?? Colors.black12)
              : BorderSide.none,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          LText(title, baseStyle: _baseStyle.merge(theme.h5)),
          LIconButton(
            fillColor: closeButtonColor,
            icon: Icon(Icons.close),
            onPressed: () => _close(context),
            splashThickness: 0,
          ),
        ],
      ),
    );
  }

  void _close(BuildContext context) async {
    await LiquidStateManager.of(context).popModel();
    if (onClose != null) onClose();
  }
}

/// Add dialogs to your apps for lightboxes, user notifications, or completely custom content.
///
/// with [LModelHeader], [LModelBody] and [LModelFooter]
class LModel extends StatelessWidget {
  /// Model Dialog header which can be used for headings adding close callbacks
  ///
  /// See Also:
  /// * [LModelDialog], A helper class for building [LModel]
  final LModelHeader header;

  /// [LModel] body content
  ///
  /// See Also:
  /// * [LModelFooter], A footer for [LModel] to include extra actions
  /// * [LModelHeader], Display a header with `title` text and an optional `onClose` callback
  /// on [LModel]
  final LModelBody body;

  /// A footer for [LModel] to include extra actions
  ///
  /// See Also:
  /// * [LModelHeader], display a header with `title` text and an optional `onClose` callback
  /// on [LModel]
  /// * [LModelBody], [LModel] body content
  final LModelFooter footer;

  /// Space on the outside area of the model
  final EdgeInsets margin;

  /// Immutable [LModel] constraints.
  final BoxConstraints constraints;

  /// Where to show the [LModel] dialog on screen
  final AlignmentGeometry positon;

  /// custom width for [LModel]
  ///
  /// default: `498.0`
  final double width;

  /// Background color for the [LModel]
  ///
  /// for applying background on [LModelHeader], [LModelBody] or [LModelFooter],
  /// user there own `background` property
  final Color background;

  final double radius;
  final Color borderColor;
  final double borderWidth;

  LModel({
    Key key,
    this.header,
    this.body,
    this.footer,
    this.margin,
    this.positon,
    this.width,
    this.constraints,
    this.background,
    this.radius,
    this.borderColor,
    this.borderWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: margin ?? const EdgeInsets.all(10.0),
      child: Align(
        alignment: positon ?? Alignment.topCenter,
        child: Container(
          width: width ?? 498.0,
          constraints: constraints,
          decoration: BoxDecoration(
            color: background ?? Colors.white,
            borderRadius: BorderRadius.circular(radius ?? 4.0),
            border: Border.all(
              color: borderColor ?? Colors.black12,
              width: borderWidth ?? 1.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(radius ?? 4.0),
            child: LModelDialog(
              header: header,
              body: body,
              footer: footer,
            ),
          ),
        ),
      ),
    );
  }
}

/// A wrapper around [LModel] for showing `entry` and `exit` animation
class LAnimatedModel extends StatefulWidget {
  final LModel model;

  /// Tween Position for showing and hiding [LModel]
  final Tween<Offset> positionTween;

  /// if `true`, [LModel] will be dismissed by tapping outside the
  /// [LModel] area
  final bool barrierDismissable;

  /// when [LModel] is laid out on canvas
  /// the background will be change to this color
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
    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.ease,
        ),
      ),
      child: Material(
        color: widget.backdropColor ?? Colors.black54,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: size.height,
            ),
            child: GestureDetector(
              onTap: widget.barrierDismissable
                  ? () async => await LiquidStateManager.of(context).popModel()
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
                child: Material(
                  type: MaterialType.transparency,
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

  Future<void> close() async => await _controller.reverse();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

/// Model Handler is a Wrapper class for managing opened
/// [LModel], All [LModel]'s states are handle by [LiquidStateManager]
///
/// See Also:
/// * [LiquidStateManager], Handles all the internal states of [LiquidApp]
class ModelHandler extends LOverlayManager {
  ModelHandler(OverlayEntry entry, GlobalKey<_LAnimatedModelState> key)
      : super(entry, key);

  @override
  Future<void> close() async {
    await (key as GlobalKey<_LAnimatedModelState>).currentState.close();
    entry.remove();
  }
}

/// A utility function for displaying [LModel] on
/// the screen.
///
/// * provide `positionTween` to animate the entry and exit transition of the [LModel]
/// * if `barrierDismissable` is true, [LModel] will be closed when tap on
/// the outside area of [LModel]
///
/// **NOTE** Since All the Liquid Components uses [LiquidStateManager] to handle
/// Routes, States, etc. Navigator.pop() won't work to pop out model
///
/// To Pop Model from current context/Screen use [LiquidStateManager]'s `popModel` method
///
/// **Example 1**: How to close, opened model
///
/// ```dart
/// LiquidStateManager.of(context).popModel<String>("Output Data");
/// ```
///
///---
///
/// **Example 2**: Display [LModel] on far **bottomCenter** of the screen and will slide in from bottom to top on entry
/// and slide out from top to bottom on close.
///
///```dart
///void _showModel(BuildContext context) {
///   showLModel(
///     context,
///     positionTween: Tween(
///       begin: Offset(0.0, 10.0),
///       end: Offset.zero,
///     ),
///     barrierDismissable: true,
///     builder: (context) {
///       return LModel(
///         positon: Alignment.bottomCenter,
///         header: LModelHeader(
///           title: "Terms & Conditions",
///           onClose: () async {
///             print("Model Closed");
///             print("Terms Accepted: false");
///           },
///         ),
///         body: LModelBody(
///           child: Padding(
///             padding:
///                 const EdgeInsets.only(bottom: 16.0),
///             child: LText(
///               "Please Accept our \l.color(hex=#0000EE){Terms & Conditions}",
///             ),
///           ),
///         ),
///         footer: LModelFooter(
///           actions: <Widget>[
///             LFlatButton.text(
///               text: "Accept",
///               onPressed: () async {
///                 final _ =
///                     await LiquidStateManager.of(
///                             context)
///                         .popModel<bool>(true);
///                 print("Terms Accepted: $_");
///               },
///               type: LElementType.primary,
///             ),
///           ],
///         ),
///       );
///     },
///   );
///}
///
///...
///
///child: LFlatButton.text(
///  text: "Accept Terms",
///  onPressed: () => _showModel(context),
///  }),
///),
///```
void showLModel(
  BuildContext context, {
  @required LModel Function(BuildContext context) builder,
  Tween<Offset> positionTween,
  Color backdropColor,
  bool barrierDismissable,
}) {
  final overlay = Overlay.of(context);
  final GlobalKey<_LAnimatedModelState> key = GlobalKey<_LAnimatedModelState>();
  final model = OverlayEntry(
    builder: (context) => LAnimatedModel(
      key: key,
      model: builder(context),
      positionTween: positionTween,
      barrierDismissable: barrierDismissable,
      backdropColor: backdropColor,
    ),
  );
  overlay.insert(model);
  final _manager = ModelHandler(
    model,
    key,
  );
  LiquidStateManager.of(context).pushModel(_manager);
}
