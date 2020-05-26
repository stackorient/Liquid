// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'validators.dart';

/// A Slug Validator
///
/// generally used in [LFormField]
class LSlugValidator extends LRegexValidator {
  LSlugValidator({String invalidMessage = "Invalid Slug"})
      : super(
          regex: RegExp(r"^[a-z0-9]+(?:-[a-z0-9]+)*$"),
          invalidMessage: invalidMessage,
        );
}

/// A Duplicate String Validator
///
/// generally used in [LFormField]
class LDuplicateStringValidator extends LRegexValidator {
  LDuplicateStringValidator(
      {String invalidMessage = "There are duplicates in string"})
      : super(
          regex: RegExp(r"(\b\w+\b)(?=.*\b\1\b)"),
          invalidMessage: invalidMessage,
        );
}
