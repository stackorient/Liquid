part of 'validators.dart';

class CommonEmailValidator extends RegexValidator {
  CommonEmailValidator({
    String invalidMessage = "Invalid Email",
  }) : super(
          regex: RegExp(r"^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$"),
          invalidMessage: invalidMessage,
        );
}

class UnCommonEmailValidator extends RegexValidator {
  UnCommonEmailValidator({
    String invalidMessage = "Invalid Email",
  }) : super(
          regex: RegExp(r"^([a-z0-9_\.\+-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$"),
          invalidMessage: invalidMessage,
        );
}

class EmailValidator extends CombinedValidator<String> {
  EmailValidator({String invalidMessage = "Invalid Email"})
      : super(
          validators: [CommonEmailValidator(), UnCommonEmailValidator()],
          invalidMessage: invalidMessage,
          validateType: CombinedValidateType.atLeastOneTrue,
        );
}
