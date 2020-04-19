part of 'validators.dart';
// email, password, minValue, maxValue, minLength, maxLength,

abstract class LValidator {
  final String _message;

  const LValidator(String errorMessage) : _message = errorMessage;

  String get errorMessage => _message;
  bool validate();
  Future<bool> asyncValidate();
}

abstract class RegexValidator extends LValidator {
  final RegExp _regex;

  const RegexValidator({@required RegExp regex, @required String errorMessage})
      : assert(regex != null),
        _regex = regex,
        super(errorMessage);

  RegExp get regex => _regex;

  @override
  bool validate({@required String candidate}) => _regex.hasMatch(candidate);

  @override
  Future<bool> asyncValidate({@required String candidate}) =>
      Future.value(validate(candidate: candidate));
}
