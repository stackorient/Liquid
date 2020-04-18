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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: LColumn(
          children: <Widget>[
            LRow(children: [
              LColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LAlert(
                    "Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.",
                    heading: "Well done!",
                    type: LAlertType.success,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: LBreadCrumbs(
                      items: [
                        LBreadCrumbItem(
                          "Home",
                          onTap: () {},
                        ),
                        LBreadCrumbItem(
                          "Library",
                          onTap: () {},
                        ),
                        LBreadCrumbItem(
                          "Data",
                          active: true,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              LColumn(
                children: <Widget>[
                  LCorousel(
                    withCaption: true,
                    autoScroll: false,
                    withControls: true,
                    canScroll: false,
                    showIndicator: true,
                    height: 200.0,
                    items: [
                      LCorouselItem(
                        child: Image.network(
                          "https://source.unsplash.com/random/?mountain",
                          fit: BoxFit.cover,
                        ),
                        caption: LCorouselCaption(
                          titleText: "First Slide",
                          subTitleText: "Cool Work Cool Work Cool",
                        ),
                      ),
                      LCorouselItem(
                        child: Image.network(
                          "https://source.unsplash.com/random/?girl",
                          fit: BoxFit.cover,
                        ),
                      ),
                      LCorouselItem(
                        child: Image.network(
                          "https://source.unsplash.com/random/",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
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
                children: <Widget>[
                  Text("Hello world"),
                ],
              ),
              LColumn(
                children: <Widget>[
                  Text("Hello world"),
                  Text("Hello world"),
                  Text("Hello world"),
                  SizedBox(
                    height: 60.0,
                    child: Center(child: Text("hello world")),
                  ),
                  Text("hello world"),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
