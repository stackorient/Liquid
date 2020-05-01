import 'package:flutter/material.dart';
import 'package:liquid/liquid.dart';
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
            LFlatButton.text(
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
            LFlatButton.text(
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

  final GlobalKey<LDropdownState> _dropdown = GlobalKey<LDropdownState>();
  final GlobalKey<LDropdownState> _dropdown2 = GlobalKey<LDropdownState>();
  final GlobalKey<LCollapseState> _collapse = GlobalKey<LCollapseState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              columns: [
                LColumn(
                  children: <Widget>[
                    ToggleButtons(
                      borderColor: Colors.red,
                      children: <Widget>[
                        Icon(Icons.ac_unit),
                        Icon(Icons.call),
                        LDropdown(
                          scrollable: false,
                          scrollToClose: false,
                          key: _dropdown2,
                          trigger: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Toggle Dropdown"),
                          ),
                          items: [
                            LDropdownItem(
                              text: "First Item",
                              onTap: () {},
                            )
                          ],
                        )
                      ],
                      onPressed: (int index) {
                        setState(() {
                          isSelected[index] = !isSelected[index];
                        });

                        if (index == 2) {
                          _dropdown2.currentState.toggleDropdown();
                        }
                      },
                      isSelected: isSelected,
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
                    "Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.",
                    heading: "Well done!",
                    type: LAlertType.success,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LExpansionPanel(
                      caption: LBadge.icon(
                        padding: EdgeInsets.all(3),
                        icon: Icon(Icons.warning),
                        label: Text("COVID-19 alert"),
                        background: Colors.red,
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
                    tagColor:
                        LiquidTheme.of(context).backgroundColors.secondaryColor,
                  ),
                ],
              ),
              LColumn(
                visibility: LBoxVisibility(
                  md: false,
                ),
                children: <Widget>[
                  LAnimatedBox(
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
                  children: <Widget>[
                    LBadge(
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
                        shape: BadgesShape.standard,
                        type: BadgesType.dark,
                      ),
                    ),
                    LBadge.text(
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
                      buttonShape: ButtonShape.pill,
                      children: [
                        LRaisedButton.text(
                          text: "First",
                          onPressed: () {},
                          small: true,
                        ),
                        LRaisedButton.text(
                          text: "Second",
                          onPressed: () {},
                          small: true,
                        ),
                        LRaisedButton.text(
                          text: "Third",
                          onPressed: () {},
                          small: true,
                          type: ButtonType.dark,
                        ),
                        LOutlineButton.text(
                          text: 'heee',
                          small: true,
                        ),
                      ],
                    ),
                    LBox(
                      decoration: LBoxDecoration(
                        xs: const BoxDecoration(color: Colors.blue),
                        sm: const BoxDecoration(color: Colors.pink),
                        lg: BoxDecoration(color: Colors.green),
                      ),
                      padding: LBoxEdgeInsets(
                        xs: const EdgeInsets.all(2.0),
                        lg: const EdgeInsets.all(15.0),
                      ),
                      child: Image.network(
                          "https://source.unsplash.com/random/",
                          height: 100.0,
                          width: 100.0),
                    ),
                    LListGroup(
                      borderColor: Colors.black12,
                      borderWidth: 1,
                      direction: Axis.vertical,
                      selectedTextColor: Colors.white,
                      selectedBackgroundColor: Colors.blue[700],
                      disabledBackgroundColor: Colors.grey[300],
                      dense: true,
                      children: [
                        LListItem(
                          title: Text("Item 1"),
                          selected: true,
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
                            LFlatButton(
                              child: Text("hello"),
                              type: ButtonType.success,
                              onPressed: () {},
                            ),
                            LFlatButton.icon(
                              icon: Text("hello"),
                              label: LBadge.text(
                                "3",
                                type: BadgesType.danger,
                                shape: BadgesShape.pills,
                              ),
                              onPressed: () {},
                              type: ButtonType.danger,
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
                              predictiveHeight: 250.0,
                              predictiveWidth: 150.0,
                              elevation: 10.0,
                              trigger: LFlatButton.icon(
                                icon: Text("Dropdown"),
                                label: Icon(Icons.arrow_drop_down),
                                onPressed: () {
                                  _dropdown.currentState.toggleDropdown();
                                },
                                type: ButtonType.warning,
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
                    LCollapse(
                      key: _collapse,
                      // duration: Duration(seconds: 10),
                      child: Center(
                        child: LFlatButton.text(
                          text: "Close",
                          onPressed: () => _collapse.currentState.close(),
                        ),
                      ),
                      background: Colors.black,
                    ),
                  ],
                ),
                LColumn(
                  visibility: LBoxVisibility(
                    xs: false,
                    lg: false,
                  ),
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
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.primary,
                            ),
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.secondary,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.success,
                            ),
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.danger,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.warning,
                              fillMode: FillMode.transparent,
                              buttonShape: ButtonShape.pill,
                            ),
                            LOutlineButton(
                              child: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.info,
                            ),
                          ],
                        ),
                        LColumn(
                          children: <Widget>[
                            LOutlineButton(
                              child: Text("Hello"),
                              onPressed: () {},
                              type: ButtonType.dark,
                              fillMode: FillMode.transparent,
                              buttonShape: ButtonShape.pill,
                            ),
                            LOutlineButton.icon(
                              icon: Icon(Icons.ac_unit),
                              label: Text("hello"),
                              onPressed: () {},
                              type: ButtonType.light,
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
                              child: Text("Form"),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FormPage()));
                              },
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
                        LOutlineButton.text(
                          text: "Cancel",
                          onPressed: () {},
                          type: ButtonType.primary,
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
