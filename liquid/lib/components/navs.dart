part of 'components.dart';

class LNavs extends StatelessWidget {
  final Widget leftBuild;
  final Widget midBuild;
  final Widget rightBuild;
  final MainAxisAlignment mainAlignment;

  LNavs(this.leftBuild, this.midBuild, this.rightBuild, this.mainAlignment);
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      onXS: (context) => LRow(
        cols: 1,
        columns: [
          leftBuild,
          rightBuild,
        ],
        mainAxisAlignment: mainAlignment ?? MainAxisAlignment.start,
      ),
    );
  }
}
