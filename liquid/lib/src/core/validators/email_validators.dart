part of 'validators.dart';

class LCommonEmailValidator extends LRegexValidator {
  LCommonEmailValidator({
    String invalidMessage = "Invalid Email",
  }) : super(
          regex: RegExp(r"^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$"),
          invalidMessage: invalidMessage,
        );
}

class LUnCommonEmailValidator extends LRegexValidator {
  LUnCommonEmailValidator({
    String invalidMessage = "Invalid Email",
  }) : super(
          regex: RegExp(r"^([a-z0-9_\.\+-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$"),
          invalidMessage: invalidMessage,
        );
}

class LEmailValidator extends LCombinedValidator<String> {
  LEmailValidator({String invalidMessage = "Invalid Email"})
      : super(
          validators: [LCommonEmailValidator(), LUnCommonEmailValidator()],
          invalidMessage: invalidMessage,
          validateType: LCombinedValidateType.atLeastOneTrue,
        );
}
