part of 'validators.dart';

class LSlugValidator extends LRegexValidator {
  LSlugValidator({String invalidMessage = "Invalid Slug"})
      : super(
          regex: RegExp(r"^[a-z0-9]+(?:-[a-z0-9]+)*$"),
          invalidMessage: invalidMessage,
        );
}

class LDuplicateStringValidator extends LRegexValidator {
  LDuplicateStringValidator(
      {String invalidMessage = "There are duplicates in string"})
      : super(
          regex: RegExp(r"(\b\w+\b)(?=.*\b\1\b)"),
          invalidMessage: invalidMessage,
        );
}
