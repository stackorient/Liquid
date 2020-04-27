part of 'validators.dart';

class SlugValidator extends RegexValidator {
  SlugValidator({String invalidMessage = "Invalid Slug"})
      : super(
          regex: RegExp(r"^[a-z0-9]+(?:-[a-z0-9]+)*$"),
          invalidMessage: invalidMessage,
        );
}

class DuplicateStringValidator extends RegexValidator {
  DuplicateStringValidator(
      {String invalidMessage = "There are duplicates in string"})
      : super(
          regex: RegExp(r"(\b\w+\b)(?=.*\b\1\b)"),
          invalidMessage: invalidMessage,
        );
}
