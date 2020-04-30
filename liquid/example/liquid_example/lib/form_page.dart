import 'package:flutter/material.dart';
import 'package:liquid/liquid.dart';

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
      body: Container(
        padding: const EdgeInsets.all(10.0),
        // child: LForm(
        //   key: _formKey,
        //   child: Column(
        //     children: <Widget>[
        //       LTextFormField(
        //         name: "email",
        //         validators: [
        //           LRequiredValidator(),
        //           LEmailValidator(
        //             invalidMessage: "Please enter correct email address",
        //           )
        //         ],
        //       ),
        //       LTextFormField(
        //         name: "email2",
        //         validators: [
        //           LRequiredValidator(),
        //           LEmailValidator(
        //               invalidMessage: "Please enter correct email address")
        //         ],
        //       ),
        //       LFlatButton.text(
        //         text: "Submit",
        //         onPressed: _submit,
        //       ),
        //       LFlatButton.text(
        //         text: "reset",
        //         onPressed: _reset,
        //       )
        //     ],
        //   ),
        // ),
        child: LAlert(
          "Aww yeah, you successfully read this important alert message. This example text is going to run a bit longer so that you can see how spacing within an alert works with this kind of content.",
          heading: "Well done!",
          type: LAlertType.success,
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
