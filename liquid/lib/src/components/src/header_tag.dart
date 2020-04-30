import 'package:flutter/material.dart';

import '../../base/base.dart';

class LHeaderTag extends StatelessWidget {
  final double tagWidth;
  final double tagHeight;
  final EdgeInsetsGeometry margin;
  final Color tagColor;
  final EdgeInsets textPadding;
  final String text;
  final String subText;
  final TextStyle textStyle;
  final TextStyle subTextStyle;
  const LHeaderTag(
      {Key key,
      this.tagWidth = 4.0,
      this.tagHeight = 20.0,
      this.margin = const EdgeInsets.all(2.0),
      this.tagColor,
      this.textPadding = const EdgeInsets.all(6.0),
      this.text = 'NOW',
      this.subText = 'April 25',
      this.textStyle,
      this.subTextStyle})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = LiquidTheme.of(context);
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Container(
          width: tagWidth ?? 5.0,
          margin: margin ?? EdgeInsets.all(2.0),
          height: tagHeight ?? 20.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: tagColor ?? theme.backgroundColors.primaryColor,
          ),
        ),
        Padding(
          padding: textPadding ?? EdgeInsets.all(2.0),
          child: Text(
            text,
            style: textStyle ??
                theme.typographyTheme.p.weight(FontWeight.w500).size(16.0),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 10.0),
          child: Text(
            '.',
            style: theme.typographyTheme.p.weight(FontWeight.bold),
          ),
        ),
        Padding(
          padding: textPadding ?? EdgeInsets.all(2.0),
          child: Text(
            subText,
            style: subTextStyle ??
                theme.typographyTheme.p
                    .weight(FontWeight.w500)
                    .withColor(Colors.grey[600]),
          ),
        ),
      ],
    );
  }
}
