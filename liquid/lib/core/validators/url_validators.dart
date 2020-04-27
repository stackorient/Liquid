part of 'validators.dart';

class LURLValidator extends LRegexValidator {
  LURLValidator(
      {String invalidMessage = "Invalid URL", bool withProtocol = false})
      : super(
          regex: withProtocol
              ? RegExp(
                  r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#()?&//=]*)")
              : RegExp(
                  r"(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)"),
          invalidMessage: invalidMessage,
        );
}
