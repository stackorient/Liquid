import 'dart:html';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:liquid/liquid.dart';
import 'package:url_launcher/url_launcher.dart';

final Map<String, LTextStyle> _style = {
  "bold": LTextStyle(style: const TextStyle().weight(FontWeight.bold)),
  "italic": LTextStyle(style: TextStyle(fontStyle: FontStyle.italic)),
  "link": LTextStyle(
    style: TextStyle(
        color: Colors.blue[800], decoration: TextDecoration.underline),
    recognizerHandler: (attrs) => TapGestureRecognizer()
      ..onTap = () {
        print(attrs.get("href", "https://example.com"));
        launch(attrs.get("href", "https://example.com"));
        // window.open(attrs['href'], "_blank");
      },
  )
};

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  GlobalKey<LFormState> _formKey = GlobalKey<LFormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: LTextStyleProvider(
        styleMap: _style,
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              LText(
                "hello \l.bold.italic.link(href=https://google.com){world}",
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
                            invalidMessage:
                                "Please enter correct email address")
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
}
