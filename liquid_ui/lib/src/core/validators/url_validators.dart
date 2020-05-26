// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'validators.dart';

/// A URL Validator
///
/// generally used in [LFormField]
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
