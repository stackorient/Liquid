import 'package:flutter/widgets.dart';

enum CaretSide {
  TOP,
  LEFT,
  BOTTOM,
  RIGHT,
}

/// clipper for popup shape
class PopupRRClipper extends CustomClipper<Path> {
  final double offset;
  final double caretSize;
  final double gap = 18.0;
  final CaretSide side;
  double radius;
  final bool roundedCorner;

  PopupRRClipper({
    this.offset = 12.0,
    this.caretSize = 5.0,
    this.side,
    this.roundedCorner = false,
  }) {
    roundedCorner ? radius = 3.0 : radius = 0.0;
  }

  double _getOffset(double dimen) {
    if (offset > dimen) return dimen - 2 * gap;
    return offset;
  }

  Path _getTopCaret(Size size) {
    Path path = Path();

    path.moveTo(caretSize, caretSize);

    // caret start
    path.lineTo(gap + _getOffset(size.width) - caretSize, caretSize);
    path.lineTo(gap + _getOffset(size.width), 0.0);
    path.lineTo(gap + _getOffset(size.width) + caretSize, caretSize);
    // caret end

    path.lineTo(size.width - caretSize - radius, caretSize);
    path.arcToPoint(Offset(size.width - caretSize, radius + caretSize),
        radius: Radius.circular(radius));

    path.lineTo(size.width - caretSize, size.height - caretSize - radius);
    path.arcToPoint(
        Offset(size.width - caretSize - radius, size.height - caretSize),
        radius: Radius.circular(radius));

    path.lineTo(caretSize + radius, size.height - caretSize);
    path.arcToPoint(Offset(caretSize, size.height - caretSize - radius),
        radius: Radius.circular(radius));

    path.lineTo(caretSize, caretSize + radius);
    path.arcToPoint(Offset(caretSize + radius, caretSize),
        radius: Radius.circular(radius));
    path.close();

    return path;
  }

  Path _getRightCaret(Size size) {
    Path path = Path();
    path.moveTo(caretSize, caretSize);

    path.lineTo(size.width - caretSize - radius, caretSize);
    path.arcToPoint(Offset(size.width - caretSize, radius + caretSize),
        radius: Radius.circular(radius));

    // caret start
    path.lineTo(
        size.width - caretSize, gap + _getOffset(size.height) - caretSize);
    path.lineTo(size.width, gap + _getOffset(size.height));
    path.lineTo(
        size.width - caretSize, gap + _getOffset(size.height) + caretSize);
    // caret end

    path.lineTo(size.width - caretSize, size.height - caretSize - radius);
    path.arcToPoint(
        Offset(size.width - caretSize - radius, size.height - caretSize),
        radius: Radius.circular(radius));

    path.lineTo(caretSize + radius, size.height - caretSize);
    path.arcToPoint(Offset(caretSize, size.height - caretSize - radius),
        radius: Radius.circular(radius));

    path.lineTo(caretSize, caretSize + radius);
    path.arcToPoint(Offset(caretSize + radius, caretSize),
        radius: Radius.circular(radius));
    path.close();

    return path;
  }

  Path _getBottomCaret(Size size) {
    Path path = Path();

    path.moveTo(caretSize, caretSize);

    path.lineTo(size.width - caretSize - radius, caretSize);
    path.arcToPoint(Offset(size.width - caretSize, radius + caretSize),
        radius: Radius.circular(radius));

    path.lineTo(size.width - caretSize, size.height - caretSize - radius);
    path.arcToPoint(
        Offset(size.width - caretSize - radius, size.height - caretSize),
        radius: Radius.circular(radius));

    // caret start
    path.lineTo(
        gap + _getOffset(size.width) - caretSize, size.height - caretSize);
    path.lineTo(gap + _getOffset(size.width), size.height);
    path.lineTo(
        gap + _getOffset(size.width) + caretSize, size.height - caretSize);
    // caret start

    path.lineTo(caretSize + radius, size.height - caretSize);
    path.arcToPoint(Offset(caretSize, size.height - caretSize - radius),
        radius: Radius.circular(radius));

    path.lineTo(caretSize, caretSize + radius);
    path.arcToPoint(Offset(caretSize + radius, caretSize),
        radius: Radius.circular(radius));
    path.close();

    return path;
  }

  Path _getLeftCaret(Size size) {
    Path path = Path();

    path.moveTo(caretSize, caretSize);

    path.lineTo(size.width - caretSize - radius, caretSize);
    path.arcToPoint(Offset(size.width - caretSize, radius + caretSize),
        radius: Radius.circular(radius));

    path.lineTo(size.width - caretSize, size.height - caretSize - radius);
    path.arcToPoint(
        Offset(size.width - caretSize - radius, size.height - caretSize),
        radius: Radius.circular(radius));

    path.lineTo(caretSize + radius, size.height - caretSize);
    path.arcToPoint(Offset(caretSize, size.height - caretSize - radius),
        radius: Radius.circular(radius));

    // carret start
    path.lineTo(caretSize, gap + _getOffset(size.height) - caretSize);
    path.lineTo(0.0, gap + _getOffset(size.height));
    path.lineTo(caretSize, gap + _getOffset(size.height) + caretSize);
    // caret end
    path.lineTo(caretSize, caretSize + radius);
    path.arcToPoint(Offset(caretSize + radius, caretSize),
        radius: Radius.circular(radius));
    path.close();

    return path;
  }

  @override
  getClip(Size size) {
    if (side == CaretSide.TOP)
      return _getTopCaret(size);
    else if (side == CaretSide.LEFT)
      return _getLeftCaret(size);
    else if (side == CaretSide.RIGHT)
      return _getRightCaret(size);
    else
      return _getBottomCaret(size);
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}
