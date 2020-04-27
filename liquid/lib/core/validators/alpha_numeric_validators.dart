part of 'validators.dart';

class LAlphaNumericValidator extends LRegexValidator {
  LAlphaNumericValidator(
      {String invalidMessage = "Not Alphanumeric", bool withSpace = false})
      : super(
          regex: withSpace
              ? RegExp(r"^[a-zA-Z0-9 ]*$")
              : RegExp(r"^[a-zA-Z0-9]*$"),
          invalidMessage: invalidMessage,
        );
}
