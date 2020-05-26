// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'validators.dart';

/// Common Email Validator
///
/// generally used in [LFormField]
///
/// See Also:
/// * [LEmailValidator], An Email Validator
class LCommonEmailValidator extends LRegexValidator {
  LCommonEmailValidator({
    String invalidMessage = "Invalid Email",
  }) : super(
          regex: RegExp(r"^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6})*$"),
          invalidMessage: invalidMessage,
        );
}

/// UnCommon Email Validator
///
/// generally used in [LFormField]
///
/// See Also:
/// * [LEmailValidator], An Email Validator
class LUnCommonEmailValidator extends LRegexValidator {
  LUnCommonEmailValidator({
    String invalidMessage = "Invalid Email",
  }) : super(
          regex: RegExp(r"^([a-z0-9_\.\+-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$"),
          invalidMessage: invalidMessage,
        );
}

/// An Email Validator
///
/// generally used in [LFormField]
class LEmailValidator extends LCombinedValidator<String> {
  LEmailValidator({String invalidMessage = "Invalid Email"})
      : super(
          validators: [LCommonEmailValidator(), LUnCommonEmailValidator()],
          invalidMessage: invalidMessage,
          validateType: LCombinedValidateType.atLeastOneTrue,
        );
}
