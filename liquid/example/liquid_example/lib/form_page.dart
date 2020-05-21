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
  ScrollSpyController _controller = ScrollSpyController();
  List<String> ids = ["0", "1", "2", "3", "4", "5"];

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
            Container(
              width: 400.0,
              height: 300.0,
              color: Colors.black38,
              child: LRow(
                useMediaQuery: false,
                axis: LRowAxis(xs: Axis.horizontal),
                columns: [
                  LColumn(
                    sm: 2,
                    children: [
                      LFlatButton.text(
                        text: "First",
                        onPressed: () => _controller.scrollTo(ids[0]),
                      ),
                      LFlatButton.text(
                        text: "Second",
                        onPressed: () => _controller.scrollTo(ids[1]),
                      ),
                      LFlatButton.text(
                        text: "Third",
                        onPressed: () => _controller.scrollTo(ids[2]),
                      ),
                      LFlatButton.text(
                        text: "Fourth",
                        onPressed: () => _controller.scrollTo(ids[3]),
                      ),
                      LFlatButton.text(
                        text: "Fifth",
                        onPressed: () => _controller.scrollTo(ids[4]),
                      ),
                      LFlatButton.text(
                        text: "Sixth",
                        onPressed: () => _controller.scrollTo(ids[5]),
                      ),
                    ],
                  ),
                  LColumn(
                    sm: 10,
                    xl: 10,
                    children: [
                      LScrollSpy(
                          controller: _controller,
                          uniqueIdList: ids,
                          itemBuilder: (context, index) => Container(
                                color: Colors.blue[(index + 2) * 100],
                              ),
                          itemLengthBuilder: (index, id) => 200.0,
                          itemCount: ids.length),
                    ],
                  )
                ],
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
