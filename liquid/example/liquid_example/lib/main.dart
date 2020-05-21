import 'package:flutter/material.dart';
import 'package:liquid/liquid.dart';
import 'scrollspy_page.dart';
import 'form_page.dart';

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

  List<bool> isSelected = [false, false, false];

  void _showModel() {
    showLModel(
      context,
      positionTween: Tween(
        begin: Offset(10.0, 0.0),
        end: Offset.zero,
      ),
      barrierDismissable: true,
      builder: (context) {
        return LModel(
          positon: Alignment.bottomRight,
          header: LModelHeader(
            title: "Terms & Conditions",
            onClose: () async {
              print("Model Closed");
              print("Terms Accepted: false");
            },
          ),
          body: LModelBody(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: LText(
                "Please Accept our \l.color(hex=#0000EE){Terms & Conditions}",
              ),
            ),
          ),
          footer: LModelFooter(
            actions: <Widget>[
              LFlatButton.text(
                text: "Accept",
                onPressed: () async {
                  final _ =
                      await LiquidStateManager.of(context).popModel<bool>(true);
                  print("Terms Accepted: $_");
                },
                type: LElementType.primary,
              ),
            ],
          ),
        );
      },
    );
  }

  final GlobalKey<LDropdownState> _dropdown = GlobalKey<LDropdownState>();
  final GlobalKey<LCollapseState> _collapse = GlobalKey<LCollapseState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.ac_unit),
            LBox(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('StackOrient Library'),
              ),
              visibility: LBoxVisibility(
                xs: false,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 5.0, right: 5.0, left: 5.0),
        child: LColumn(
          children: <Widget>[
            LRow(
              // mode: LGridMode.ratio,
              axis: LRowAxis(lg: Axis.vertical),
              columns: [
                LColumn(
                  sm: 4,
                  children: <Widget>[
                    Container(height: 50.0, color: Colors.amber[800]),
                  ],
                ),
                LColumn(
                  sm: 6,
                  children: <Widget>[
                    Container(height: 50.0, color: Colors.blue[800]),
                  ],
                ),
                LColumn(
                  sm: 2,
                  children: <Widget>[
                    Container(height: 50.0, color: Colors.green[800]),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LProgressIndicator(
                progress: 0.7,
                barColor: LiquidTheme.of(context).colors.success,
                barChild: Text(
                  "70%",
                  style: LiquidTheme.of(context)
                      .typographyTheme
                      .small
                      .withColor(Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LProgressIndicator(
                progress: 0.2,
                barChild: Text(
                  "20%",
                  style: LiquidTheme.of(context)
                      .typographyTheme
                      .small
                      .withColor(Colors.white),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LCircularProgressIndicator(
                progress: 0.6,
                diameter: 70.0,
                thickness: 6.0,
                barColor: LiquidTheme.of(context).colors.primary,
                child: Text(
                  "60%",
                  style: LiquidTheme.of(context).typographyTheme.small,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: LProgressIndicator(
                progress: 0.5,
                barColor: LiquidTheme.of(context).colors.primary,
              ),
            ),
            LRow(
              columns: [
                LColumn(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        LSpinner(
                          diameter: 50.0,
                          thickness: 6.0,
                          cap: StrokeCap.round,
                        ),
                        LGrowSpinner(
                          diameter: 50.0,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        LFlatButton.icon(
                          icon: LSpinner(
                            color: Colors.white,
                            diameter: 10.0,
                            thickness: 2.0,
                          ),
                          label: Text("LOADING"),
                          shape: LElementShape.pill,
                          spacing: 10.0,
                          disabledColor: Colors.blue[300],
                          onPressed: () {},
                        ),
                        LFlatButton.icon(
                          icon: LGrowSpinner(
                            color: Colors.white,
                          ),
                          label: Text("LOADING"),
                          shape: LElementShape.pill,
                          disabledColor: Colors.blue[300],
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            LRow(columns: [
              LColumn(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LAlert(
                    text:
                        "Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.",
                    heading: LAlertHeading(
                      text: "Well done!",
                      onClose: () {},
                    ),
                    type: LElementType.primary,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LExpansionPanel(
                      caption: LBadge.icon(
                        icon: Icon(Icons.warning),
                        label: Text("COVID-19 alert"),
                        type: LElementType.danger,
                        size: LElementSize.small,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black45,
                      ),
                      title: Text("Coronavirus disease"),
                      subtitle: Text("Get the latest information"),
                      collapseChild: Center(
                        child: LFlatButton.text(text: "Hello World"),
                      ),
                      background: Colors.red.withOpacity(0.5),
                    ),
                  ),
                  Container(
                    width: 320.0,
                    child: LExpansionPanel(
                      caption: LBadge.icon(
                        icon: Icon(Icons.warning),
                        label: Text("Latest"),
                        type: LElementType.warning,
                        size: LElementSize.small,
                      ),
                      leading: CircleAvatar(
                        backgroundColor: Colors.black45,
                      ),
                      title: Text("Liquid for flutter"),
                      subtitle: Text("Get the latest information"),
                      collapseChild: Center(
                        child: LFlatButton.text(text: "This was collapsed."),
                      ),
                    ),
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
                  LHeaderTag(
                    child: Text('Header'),
                    tagColor: LiquidTheme.of(context).colors.secondary,
                  ),
                ],
              ),
              LColumn(
                children: <Widget>[
                  LAnimatedBox(
                    height: LBoxDimension(
                      xl: 450.0,
                      lg: 350.0,
                      md: 250.0,
                      sm: 200.0,
                      xs: 200.0,
                    ),
                    child: LCarousel(
                      withCaption: true,
                      autoScroll: true,
                      withControls: true,
                      canScroll: true,
                      showIndicator: true,
                      enableIndicatorTapControl: true,
                      items: [
                        LCarouselItem(
                          child: Image.network(
                            "https://source.unsplash.com/random/?mountain",
                            fit: BoxFit.cover,
                          ),
                          caption: LCarouselCaption(
                            titleText: "First Slide",
                            subTitleText: "Cool Work Cool Work Cool",
                            actions: <Widget>[
                              LFlatButton.text(
                                text: "Accept",
                                onPressed: _showModel,
                                margin: const EdgeInsets.only(top: 10.0),
                              ),
                            ],
                          ),
                        ),
                        LCarouselItem(
                          child: Image.network(
                            "https://source.unsplash.com/random/?mountain,sunset",
                            fit: BoxFit.cover,
                          ),
                        ),
                        LCarouselItem(
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
                  children: <Widget>[
                    LBadge(
                      shape: LElementShape.pill,
                      type: LElementType.primary,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.warning,
                            size: 15.0,
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            "No Update",
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                LColumn(
                  xs: 6,
                  xl: 1,
                  children: <Widget>[
                    LBox(
                      visibility: LBoxVisibility(
                        xs: false,
                      ),
                      child: LBadge.text(
                        "Will hide in xs",
                        shape: LElementShape.pill,
                        type: LElementType.dark,
                      ),
                    ),
                    Tooltip(
                      message: "Accept",
                      padding: const EdgeInsets.all(40.0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                      ),
                      showDuration: Duration(seconds: 20),
                      child: LBadge.icon(
                        icon: Icon(Icons.insert_chart),
                        label: Text("Normal"),
                        // shape: LElementShape.pill,
                        type: LElementType.dark,
                        size: LElementSize.small,
                      ),
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
                      splashThickness: 010.0,
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
                  children: <Widget>[
                    LButtonGroup(
                      direction: Axis.horizontal,
                      buttonShape: LElementShape.pill,
                      size: LElementSize.small,
                      children: [
                        LOutlineButton.text(
                          text: "First",
                          onPressed: () {},
                          // pushAction: LRaisedButtonPushAction.pushDown,

                          type: LElementType.danger,
                        ),
                        LOutlineButton.text(
                          text: "Second",
                          onPressed: () {},
                          // pushAction: LRaisedButtonPushAction.pushDown,

                          type: LElementType.danger,
                        ),
                        LOutlineButton.text(
                          text: "Third",
                          onPressed: () {},
                          // pushAction: LRaisedButtonPushAction.pushDown,

                          type: LElementType.danger,
                        ),
                      ],
                    ),
                    LBox(
                      visibility: LBoxVisibility(
                        xs: false,
                        sm: false,
                      ),
                      height: LBoxDimension(
                          xs: 250.0,
                          sm: 280.0,
                          md: 350.0,
                          lg: 450.0,
                          xl: 500.0),
                      padding: LBoxEdgeInsets(
                        lg: EdgeInsets.all(10.0),
                        xl: EdgeInsets.all(20.0),
                      ),
                      child:
                          Image.network("https://source.unsplash.com/random/"),
                    ),
                    LListGroup(
                      // borderColor: Colors.black12,
                      borderWidth: 1,
                      direction: Axis.vertical,
                      // selectedTextColor: Colors.white,
                      // selectedBackgroundColor: Colors.blue[700],
                      // disabledBackgroundColor: Colors.grey[300],
                      dense: true,
                      children: [
                        LListItem(
                          title: Text("Item 1"),
                          selected: true,
                          onTap: () {},
                        ),
                        LListItem(
                          title: Text("Item 1"),
                          trailing: LBadge.text("45"),
                          onTap: () {},
                        ),
                        LListItem(
                          title: Text("Item 2"),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            LRow(
              columns: [
                LColumn(
                  xs: 4,
                  sm: 4,
                  md: 4,
                  lg: 4,
                  xl: 3,
                  children: <Widget>[],
                )
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
                              child: Text("Toggle Collapse"),
                              onPressed: () {
                                if (_collapse.currentState.isCollapsed)
                                  _collapse.currentState.open();
                                else
                                  _collapse.currentState.close();
                              },
                              type: LElementType.primary,
                            ),
                            LFlatButton(
                              child: Text("ScrollSpy"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScrollSpyPage(),
                                  ),
                                );
                              },
                              type: LElementType.secondary,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LFlatButton.text(
                              text: "Accept Terms",
                              onPressed: () => showLModel(
                                context,
                                positionTween: Tween(
                                  begin: Offset(0.0, 10.0),
                                  end: Offset.zero,
                                ),
                                barrierDismissable: true,
                                builder: (context) {
                                  return LModel(
                                    positon: Alignment.bottomCenter,
                                    header: LModelHeader(
                                      title: "Terms & Conditions",
                                      onClose: () async {
                                        print("Model Closed");
                                        print("Terms Accepted: false");
                                      },
                                    ),
                                    body: LModelBody(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: LText(
                                          "Please Accept our \l.color(hex=#0000EE){Terms & Conditions}",
                                        ),
                                      ),
                                    ),
                                    footer: LModelFooter(
                                      actions: <Widget>[
                                        LFlatButton.text(
                                          text: "Accept",
                                          onPressed: () async {
                                            final _ =
                                                await LiquidStateManager.of(
                                                        context)
                                                    .popModel<bool>(true);
                                            print("Terms Accepted: $_");
                                          },
                                          type: LElementType.primary,
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            LFlatButton.icon(
                              icon: Text("hello"),
                              size: LElementSize.small,
                              label: LBadge.text(
                                "3",
                                size: LElementSize.small,
                                shape: LElementShape.pill,
                                type: LElementType.info,
                              ),
                              onPressed: () {},
                              type: LElementType.danger,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LDropdown(
                              key: _dropdown,
                              scrollToClose: false,
                              scrollable: true,
                              // backdrop: Colors.red.withOpacity(0.4),
                              elevation: 10.0,
                              trigger: LFlatButton.text(
                                text: "Dropdown",
                                onPressed: () {
                                  _dropdown.currentState.toggleDropdown();
                                },
                                type: LElementType.warning,
                              ),
                              itemBuilder: (context) => [
                                LDropdownItem.header(text: "Option 1"),
                                LDropdownItem(
                                  text: "First Item",
                                  onTap: () {},
                                ),
                                LDropdownItem(
                                  text: "Second Item",
                                  onTap: () {
                                    print("pressed");
                                  },
                                  onLongPress: () {
                                    print("long pressed");
                                    _dropdown.currentState.closeDropdown();
                                  },
                                ),
                                LDropdownItem(
                                  text: "Third Item",
                                  onTap: () {},
                                ),
                                LDropdownItem.divider(
                                  thickness: 2,
                                ),
                                LDropdownItem.header(text: "Options"),
                                LDropdownItem.withChild(
                                    child: Row(
                                  // mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    LIconButton(
                                      icon: Icon(Icons.ac_unit),
                                      onPressed: () {},
                                    ),
                                    LIconButton(
                                      icon: Icon(Icons.ac_unit),
                                      onPressed: () {},
                                    ),
                                    LIconButton(
                                      icon: Icon(Icons.ac_unit),
                                      onPressed: () {},
                                    ),
                                  ],
                                )),
                              ],
                            ),
                            LFlatButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.info,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LFlatButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.dark,
                            ),
                            LFlatButton(
                              child: Icon(Icons.ac_unit),
                              onPressed: () {},
                              type: LElementType.light,
                              shape: LElementShape.pill,
                            ),
                          ],
                        ),
                      ],
                    ),
                    LCollapse(
                      key: _collapse,
                      // duration: Duration(seconds: 10),
                      child: Center(
                        child:
                            LText("Hey I am \l.uppercase.bold{visible} now..."),
                      ),
                      background: Colors.green[300],
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
                              type: LElementType.primary,
                            ),
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.secondary,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LRaisedButton(
                              child: Text("Form"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormPage()));
                              },
                              type: LElementType.success,
                            ),
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.danger,
                              size: LElementSize.small,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.warning,
                            ),
                            LRaisedButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.info,
                              shape: LElementShape.pill,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LRaisedButton.text(
                              text: "Hello",
                              onPressed: () {},
                              type: LElementType.dark,
                            ),
                            LRaisedButton.text(
                              text: "Hello",
                              onPressed: () {},
                              type: LElementType.dark,
                            ),
                            LRaisedButton.icon(
                              icon: Icon(Icons.ac_unit),
                              label: Text("Hello"),
                              onPressed: () {},
                              type: LElementType.light,
                              shape: LElementShape.pill,
                              size: LElementSize.small,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
            LRow(
              columns: [
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
                            OutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              highlightedBorderColor: Colors.black,
                            ),
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.primary,
                              size: LElementSize.large,
                            ),
                            LOutlineButton(
                              child: Text("hello"),
                              // onPressed: () {},
                              type: LElementType.secondary,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.success,
                            ),
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.danger,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.warning,
                              // fillMode: FillMode.transparent,
                              shape: LElementShape.pill,
                            ),
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: LElementType.info,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LOutlineButton(
                              child: Text("Hello"),
                              onPressed: () {},
                              type: LElementType.dark,
                              fillMode: FillMode.transparent,
                              shape: LElementShape.pill,
                            ),
                            LOutlineButton.icon(
                              icon: Icon(Icons.ac_unit),
                              label: Text("hello"),
                              onPressed: () {},
                              type: LElementType.light,
                              direction: Axis.vertical,
                              // small: true,
                              fillMode: FillMode.transparent,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
                        LOutlineButton.text(
                          text: "Cancel",
                          onPressed: () {},
                          type: LElementType.primary,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          margin: const EdgeInsets.only(right: 5.0),
                        ),
                        LOutlineButton.text(
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
                      child: LOutlineButton.text(
                        text: "welcome",
                        type: LElementType.dark,
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
