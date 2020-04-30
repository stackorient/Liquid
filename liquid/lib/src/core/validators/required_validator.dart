part of 'validators.dart';

class LRequiredValidator extends LValidator<String> {
  const LRequiredValidator({
    String invalidMessage = "This field is required",
  }) : super(errorMessage: invalidMessage);

  @override
  Future<bool> asyncValid({String candidate}) =>
      Future.value(valid(candidate: candidate));

  @override
  bool valid({@required String candidate}) {
    final _ = candidate.toString().trim().length > 0;
    return _;
  }
}
