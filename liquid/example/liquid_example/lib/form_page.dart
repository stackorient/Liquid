import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid/liquid.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  LFormManager manager = LFormManager();
  LScrollSpyController _controller;
  List<String> ids = ["0", "1", "2", "3", "4", "5"];
  String activeId;

  String link = '';
  Timer _t;

  @override
  void initState() {
    super.initState();
    _t = Timer(Duration(seconds: 3), () {
      setState(() {
        link = 'link(href=https://google.com)';
      });
    });

    _controller = LScrollSpyController()
      ..addListener(() {
        setState(() {
          activeId = _controller.activeID;
        });
      });

    activeId = _controller.activeID;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            LText(
              "Helo \l.h1.capitalize.bold{jai hind with ${4 + 32}} and hello \l.color(hex=#f10435){raju}",
            ),
            LCard(
              width: 450.0,
              body: LCardBody(
                child: LRow(
                  useMediaQuery: false,
                  axis: LRowAxis(xs: Axis.horizontal),
                  columns: [
                    LColumn(
                      xs: 3,
                      children: [
                        for (final id in ids)
                          LFlatButton.text(
                            text: (int.parse(id) + 1).toString(),
                            type: activeId == id
                                ? LElementType.warning
                                : LElementType.primary,
                            onPressed: () => _controller.scrollTo(id),
                          )
                      ],
                    ),
                    LColumn(
                      children: [
                        Container(
                          height: 270.0,
                          child: LScrollSpy(
                              controller: _controller,
                              uniqueIdList: ids,
                              itemBuilder: (context, index) => Container(
                                    color: Colors.blue[(index + 2) * 100],
                                    alignment: Alignment.center,
                                    child: LText(" \l.h1{ ${index + 1} }"),
                                  ),
                              itemExtent: 270.0,
                              itemExtentBuilder: null,
                              itemCount: ids.length),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            LForm(
              manager: manager,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  LTextFormField(
                    name: "email", // for serialization
                    decoration: const InputDecoration(
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                    disabledStyle: TextStyle()
                        .withColor(Colors.grey)
                        .weight(FontWeight.bold),
                    initialValue: 'xyz@xyz.com',
                    validators: [
                      LRequiredValidator(),
                      LEmailValidator(
                          invalidMessage: "Please enter correct email address")
                    ],
                  ),
                  LRaisedButton.text(
                    text: "Submit",
                    margin: const EdgeInsets.symmetric(vertical: 16.0),
                    onPressed: () {
                      // Validate will return true if the form is valid, or false if
                      // the form is invalid.
                      print(
                          manager.formState.isDirty); // print if form is dirty
                      manager.formState.fields.get('email').disable();
                      Future.delayed(Duration(seconds: 3),
                          () => manager.formState.fields.get('email').enable());
                      if (manager.formState.validate()) {
                        // Get Serialized Data
                        final data = manager.formState.serialize();
                        print(data); // {'email': 'xyz@xyz.com'}

                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }
}
