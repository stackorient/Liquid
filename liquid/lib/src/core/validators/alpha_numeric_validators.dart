// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'validators.dart';

/// A Alphanumeric validator
///
/// generally used in [LFormField]
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
