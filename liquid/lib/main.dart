import 'package:flutter/rendering.dart';
import 'package:liquid/liquid.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LiquidApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        elevation: 0,
      ),
      body: LColumn(
        children: <Widget>[
          LRow(children: [
            LColumn(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                LAlert(
                  "Happy day",
                  type: AlertType.warning,
                ),
              ],
            ),
            LColumn(
              xs: 7,
              children: <Widget>[
                Text("Hello world"),
              ],
            ),
          ]),
          LRow(children: [
            LColumn(
              xl: 4,
              children: <Widget>[
                Text("Hello World"),
              ],
            ),
            LColumn(
              children: <Widget>[
                Text("Hello world"),
              ],
            ),
            LColumn(
              children: <Widget>[
                Text("Hello world"),
              ],
            ),
            LColumn(
              xl: 3,
              children: <Widget>[
                Text("Hello world"),
              ],
            ),
            LColumn(
              children: <Widget>[
                Text("Hello world"),
              ],
            ),
          ]),
        ],
      ),
    );
  }
}
