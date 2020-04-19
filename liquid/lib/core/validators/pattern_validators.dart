part of 'validators.dart';

class EmailValidator extends RegexValidator {
  static final RegExp _emailRegex = RegExp(r"");

  EmailValidator({String errorMessage = "Invalid Email"})
      : super(regex: _emailRegex, errorMessage: errorMessage);
}
