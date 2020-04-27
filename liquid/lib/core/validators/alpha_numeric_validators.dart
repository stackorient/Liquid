part of 'validators.dart';

class AlphaNumericValidator extends RegexValidator {
  AlphaNumericValidator(
      {String invalidMessage = "Not Alphanumeric", bool withSpace = false})
      : super(
          regex: withSpace
              ? RegExp(r"^[a-zA-Z0-9 ]*$")
              : RegExp(r"^[a-zA-Z0-9]*$"),
          invalidMessage: invalidMessage,
        );
}
