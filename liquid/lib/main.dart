import 'package:liquid/liquid.dart';

void main() {
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
      // builder: (context, child) => child,
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
  String result;

  void _showModel() {
    showLModel(context,
        positionTween: Tween(begin: Offset(0, 10.0), end: Offset.zero),
        barrierDismissable: true, builder: (context) {
      return LModel(
        positon: MainAxisAlignment.end,
        margin: EdgeInsets.all(20.0),
        header: LModelHeader(
          title: "Terms & Conditions",
          onClose: () async {
            setState(() {
              result = "Canceled";
            });
          },
        ),
        body: LModelBody(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: SelectableText(
                """Cras mattis consectetur purus sit amet fermentum. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesencibus dolor auctor.Aenean lacinia bibendum nulla sed consectetur. Praesent commodo cursus magna, vel scelerisque nisl consectetur et. Donec sed odio dui. Donec ullamcorper nulla non metus auctor fringilla."""),
          ),
        ),
        footer: LModelFooter(
          actions: <Widget>[
            LButton(
              text: "Cancel",
              onPressed: () async {
                final _ = await LiquidStateManager.of(context)
                    .popModel<String>("Helllo world");
                setState(() {
                  result = _;
                });
              },
              type: ButtonType.secondary,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              margin: const EdgeInsets.only(right: 5.0),
            ),
            LButton(
              text: "Accept",
              onPressed: () async {
                final _ = await LiquidStateManager.of(context)
                    .popModel<String>("Terms Accepted");
                setState(() {
                  result = _;
                });
              },
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(result ?? widget.title),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
        child: LColumn(
          children: <Widget>[
            LRow(columns: [
              LColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LAlert(
                    "Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.",
                    heading: "Well done!",
                    type: LAlertType.success,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 7.0),
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
                  LBox(
                    height: LBoxDimension(
                      xl: 450.0,
                      lg: 350.0,
                      md: 250.0,
                      sm: 200.0,
                      xs: 200.0,
                    ),
                    child: LCorousel(
                      withCaption: true,
                      autoScroll: true,
                      withControls: true,
                      canScroll: true,
                      showIndicator: true,
                      enableIndicatorTapControl: true,
                      items: [
                        LCorouselItem(
                          child: Image.network(
                            "https://source.unsplash.com/random/?mountain",
                            fit: BoxFit.cover,
                          ),
                          caption: LCorouselCaption(
                            titleText: "First Slide",
                            subTitleText: "Cool Work Cool Work Cool",
                            actions: <Widget>[
                              LFlatButton.text(
                                text: "Accept",
                                onPressed: _showModel,
                                margin: const EdgeInsets.only(top: 10.0),
                                small: true,
                              ),
                            ],
                          ),
                        ),
                        LCorouselItem(
                          child: Image.network(
                            "https://source.unsplash.com/random/?mountain,sunset",
                            fit: BoxFit.cover,
                          ),
                        ),
                        LCorouselItem(
                          child: Image.network(
                            "https://source.unsplash.com/random/?sunrise",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ]),
            LRow(
              gutter: 0,
              columns: [
                LColumn(
                  xs: 6,
                  xl: 1,
                  children: <Widget>[
                    LBadges(
                      "Hello",
                      shape: BadgesShape.standard,
                      type: BadgesType.dark,
                    ),
                  ],
                ),
                LColumn(
                  xs: 6,
                  xl: 3,
                  children: <Widget>[
                    LIconButton(
                      icon: Icon(Icons.ac_unit),
                      color: Colors.green,
                      onPressed: () {},
                    ),
                    SizedBox(height: 20.0),
                    IconButton(
                      icon: Icon(Icons.ac_unit),
                      color: Colors.red,
                      splashColor: Colors.red.withOpacity(0.2),
                      onPressed: () {},
                    )
                  ],
                ),
              ],
            ),
            LRow(
              gutter: 0,
              columns: [
                LColumn(
                  xs: 6,
                  xl: 1,
                  children: <Widget>[
                    LButtonGroup(
                      small: false,
                      direction: Axis.horizontal,
                      children: [
                        LGroupButton(
                            text: "primary",
                            onPressed: () {
                              print("hello");
                            }),
                        LGroupButton(
                            child: Icon(Icons.arrow_drop_down, size: 16.0),
                            onPressed: () {
                              print("dark button");
                            }),
                      ],
                      type: ButtonType.success,
                      borderThickness: 1.0,
                      outline: true,
                    ),
                  ],
                ),
              ],
            ),
            LRow(
              columns: [
                LColumn(
                  children: <Widget>[
                    // flat buttons
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Flat Buttons"),
                    ),
                    LRow(
                      columns: [
                        LColumn(
                          xs: 3,
                          children: <Widget>[
                            LFlatButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.primary,
                            ),
                            LFlatButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.secondary,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LDropdown(
                              scrollable: false,
                              scrollToClose: false,
                              predictiveHeight: 200.0,
                              trigger: LFlatButton(
                                child: Text("hello"),
                                type: ButtonType.success,
                              ),
                              itemBuilder: (context) => [
                                LDropdownItem(
                                  text: "First Item",
                                  onTap: () {},
                                ),
                                LDropdownItem(
                                  text: "Second Item",
                                  onTap: () {},
                                ),
                                LDropdownItem(
                                  text: "Third Item",
                                  onTap: () {},
                                ),
                                LDropdownItem.withChild(
                                  child: LFlatButton.text(
                                    text: "Happy day",
                                    onPressed: () {},
                                  ),
                                ),
                              ],
                            ),
                            LFlatButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.danger,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LFlatButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.warning,
                              small: true,
                            ),
                            LFlatButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.info,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LFlatButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.dark,
                              small: true,
                            ),
                            LFlatButton(
                              child: Icon(Icons.ac_unit),
                              onPressed: () {},
                              type: ButtonType.light,
                              buttonShape: ButtonShape.pill,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                LColumn(
                  children: <Widget>[
                    // outline button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Outline Buttons"),
                    ),
                    LRow(
                      columns: [
                        LColumn(
                          xs: 3,
                          children: <Widget>[
                            LNOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.primary,
                            ),
                            LNOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.secondary,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LNOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.success,
                            ),
                            LNOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.danger,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LNOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.warning,
                              buttonShape: ButtonShape.pill,
                            ),
                            LNOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.info,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LNOutlineButton(
                              child: Text("Hello"),
                              onPressed: () {},
                              type: ButtonType.dark,
                              fillMode: FillMode.transparent,
                              buttonShape: ButtonShape.pill,
                            ),
                            LNOutlineButton.icon(
                              icon: Icon(Icons.ac_unit),
                              label: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.light,
                              direction: Axis.vertical,
                              small: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                LColumn(
                  children: <Widget>[
                    // Raised button
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Raised Buttons"),
                    ),
                    LRow(
                      columns: [
                        LColumn(
                          xs: 3,
                          children: <Widget>[
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.primary,
                            ),
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.secondary,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.success,
                            ),
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.danger,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.warning,
                            ),
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.info,
                              buttonShape: ButtonShape.pill,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LRaisedButton.text(
                              text: "Hello",
                              onPressed: () {},
                              type: ButtonType.dark,
                            ),
                            LRaisedButton.icon(
                              icon: Icon(Icons.ac_unit),
                              label: Text("Hello"),
                              onPressed: () {},
                              type: ButtonType.light,
                              buttonShape: ButtonShape.pill,
                              small: true,
                            ),
                            LRaisedButton.icon(
                              icon: Icon(Icons.ac_unit),
                              label: Text("Hello"),
                              onPressed: () {},
                              type: ButtonType.light,
                              buttonShape: ButtonShape.pill,
                              small: true,
                            ),
                            LRaisedButton.icon(
                              icon: Icon(Icons.ac_unit),
                              label: Text("Hello"),
                              onPressed: () {},
                              type: ButtonType.light,
                              buttonShape: ButtonShape.pill,
                              small: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            LRow(gutter: 5.0, columns: [
              LColumn(
                sm: 6,
                children: <Widget>[
                  LModel(
                    header: LModelHeader(
                      title: "Hello World",
                      onClose: () {},
                    ),
                    body: LModelBody(
                      padding: EdgeInsets.zero,
                      child: LCard(
                        radius: 0.0,
                        width: null,
                        border:
                            Border.all(width: 0.0, color: Colors.transparent),
                        image: LCardImage(
                          image: NetworkImage(
                              'https://source.unsplash.com/random/?girl'),
                          fit: BoxFit.cover,
                        ),
                        body: LCardBody(
                          title: "hasjhdja",
                        ),
                      ),
                    ),
                    footer: LModelFooter(
                      actions: <Widget>[
                        LOutlineButton(
                          text: "Cancel",
                          onPressed: () {},
                          type: ButtonType.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          margin: const EdgeInsets.only(right: 5.0),
                        ),
                        LButton(
                          text: "Accept",
                          onPressed: () {},
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              LColumn(
                children: <Widget>[
                  LCard(
                    elevation: 10.0,
                    header: LCardHeader(title: "title"),
                    footer: LCardFooter(
                      actions: <Widget>[Text('Footer')],
                    ),
                    color: Colors.white,
                    image: LCardImage(
                      image: NetworkImage(
                        'https://source.unsplash.com/random/?cars',
                      ),
                    ),
                    body: LCardBody(
                      subTitle:
                          "hi how are you fine from my side hi how are you fine from my side hi how are you fine from my side ",
                      title: "Hello",
                      child: LButton(
                        text: "welcome",
                        type: ButtonType.dark,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
