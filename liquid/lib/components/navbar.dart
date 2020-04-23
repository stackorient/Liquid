part of 'components.dart';

class LNavBar extends StatelessWidget {
  final Widget leftChild;
  final Widget midChild;
  final Widget rightChild;
  final MainAxisAlignment mainAlignment;

  LNavBar(this.leftChild, this.midChild, this.rightChild, this.mainAlignment);
  @override
  Widget build(BuildContext context) {
    return Material(
      child: LRow(
        columns: [],
      ),
    );
  }
}
