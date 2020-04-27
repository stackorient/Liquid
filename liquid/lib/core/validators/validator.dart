part of 'validators.dart';

/// Validators expect the candidate is Already sanatized
abstract class LValidator<T> {
  final String _message;

  const LValidator({String errorMessage}) : _message = errorMessage;

  String get errorMessage => _message;
  bool valid({T candidate});
  Future<bool> asyncValid({T candidate});
}

/// **Warning** Validators expect the candidate is Already sanatized
///
/// Example:
/// Find Purple Cow in string
///
/// ```dart
/// final hasPurpleCow = LRegexValidator(
///   regex: RegExp(r'purple[ |}{":>?<!@#$%^\&*(\*+]+cow'),
///   invalidMessage: "Purple cow not found",
/// );
///
/// print(hasPurpleCow.valid("Big fat purple cow is near you")) // true
/// print(hasPurpleCow.valid("humm! no cow")) // false
/// ```
class LRegexValidator extends LValidator<String> {
  final RegExp _regex;

  const LRegexValidator(
      {@required RegExp regex, @required String invalidMessage})
      : assert(regex != null),
        _regex = regex,
        super(errorMessage: invalidMessage);

  RegExp get regex => _regex;

  @override
  bool valid({@required String candidate}) => _regex.hasMatch(candidate);

  @override
  Future<bool> asyncValid({@required String candidate}) =>
      Future.value(valid(candidate: candidate));
}

enum LCombinedValidateType {
  allTrue,
  allFalse,
  atLeastOneTrue,
  atLeastOneFalse,
  atMostOneTrue,
  atMostOneFalse,
}

class LCombinedValidator<T> extends LValidator<T> {
  final List<LValidator<T>> validators;
  final LCombinedValidateType validateType;

  const LCombinedValidator({
    @required this.validators,
    String invalidMessage = "",
    this.validateType = LCombinedValidateType.allTrue,
  })  : assert(validators != null),
        super(errorMessage: invalidMessage);

  @override
  Future<bool> asyncValid({@required T candidate}) =>
      Future.value(valid(candidate: candidate));

  @override
  bool valid({T candidate}) {
    switch (validateType) {
      case LCombinedValidateType.allTrue:
        return _all(true, candidate);
        break;
      case LCombinedValidateType.allFalse:
        return _all(false, candidate);
        break;
      case LCombinedValidateType.atLeastOneTrue:
        return _atLeastOne(true, candidate);
        break;
      case LCombinedValidateType.atLeastOneFalse:
        return _atLeastOne(false, candidate);
        break;
      case LCombinedValidateType.atMostOneTrue:
        return _atMostOne(true, candidate);
        break;
      case LCombinedValidateType.atMostOneFalse:
        return _atMostOne(false, candidate);
        break;
      default:
        return false;
    }
  }

  bool _all(bool t, T candidate) {
    for (final validator in validators) {
      if (t && !validator.valid(candidate: candidate)) {
        return false;
      }
      if (!t && validator.valid(candidate: candidate)) {
        return false;
      }
    }
    return true;
  }

  bool _atLeastOne(bool t, T candidate) {
    for (final validator in validators) {
      if (t && validator.valid(candidate: candidate)) {
        return true;
      }
      if (!t && !validator.valid(candidate: candidate)) {
        return true;
      }
    }
    return false;
  }

  bool _atMostOne(bool t, T candidate) {
    bool firstFound = false;
    for (final validator in validators) {
      if (t && validator.valid(candidate: candidate) && !firstFound) {
        firstFound = true;
      }
      if (!t && !validator.valid(candidate: candidate) && !firstFound) {
        firstFound = true;
      }
    }
    return !firstFound;
  }
}
