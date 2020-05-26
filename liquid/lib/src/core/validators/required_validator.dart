// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'validators.dart';

/// A Required Validator
///
/// generally used in [LFormField]
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
