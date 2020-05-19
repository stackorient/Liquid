import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid/liquid.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  GlobalKey<LFormState> _formKey = GlobalKey<LFormState>();

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
              "Helo \l.blockquote.capitalize{  jai hind with world} and hello \l.color(hex=#f10435){raju}",
            ),
            LForm(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  LTextFormField(
                    name: "email",
                    validators: [
                      LRequiredValidator(),
                      LEmailValidator(
                        invalidMessage: "Please enter correct email address",
                      )
                    ],
                  ),
                  LTextFormField(
                    name: "email2",
                    validators: [
                      LRequiredValidator(),
                      LEmailValidator(
                          invalidMessage: "Please enter correct email address")
                    ],
                  ),
                  LFlatButton.text(
                    text: "Submit",
                    onPressed: _submit,
                  ),
                  LFlatButton.text(
                    text: "reset",
                    onPressed: _reset,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _submit() {
    final state = _formKey.currentState;
    state.validate();
    print("is dirty ${state.isDirty}");
    print("is pristine ${state.isPristine}");
    print("is valid ${state.isValid}");
    print("is invalid ${state.isInvalid}");
    print(state.serialize());
    print(state.fields["email2"].value);
  }

  _reset() {
    final state = _formKey.currentState;
    state.reset();
    print("is dirty ${state.isDirty}");
    print("is pristine ${state.isPristine}");
    print("is valid ${state.isValid}");
    print("is invalid ${state.isInvalid}");
  }

  @override
  void dispose() {
    _t?.cancel();
    super.dispose();
  }
}
