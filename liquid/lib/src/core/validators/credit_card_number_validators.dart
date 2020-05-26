// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

part of 'validators.dart';

/// A Visa Card Validator
///
/// generally used in [LFormField]
class LVisaCardValidator extends LRegexValidator {
  LVisaCardValidator({String invalidMessage = "Invalid Visa Card Number"})
      : super(
          regex: RegExp(r"^4[0-9]{12}(?:[0-9]{3})?$"),
          invalidMessage: invalidMessage,
        );
}

/// A Master Card validator
///
/// generally used in [LFromField]
class LMasterCardValidator extends LRegexValidator {
  LMasterCardValidator({String invalidMessage = "Invalid Master Card Number"})
      : super(
          regex: RegExp(
              r"^(?:5[1-5][0-9]{2}|222[1-9]|22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}$"),
          invalidMessage: invalidMessage,
        );
}

/// An AmericanExpress Card Validator
///
/// generally used in [LFormField]
class LAmericanExpressCardValidator extends LRegexValidator {
  LAmericanExpressCardValidator(
      {String invalidMessage = "Invalid American Express Card Number"})
      : super(
          regex: RegExp(r"^3[47][0-9]{13}$"),
          invalidMessage: invalidMessage,
        );
}

/// A DinersClub Validator
///
/// generally used in [LFormField]
class LDinersClubValidator extends LRegexValidator {
  LDinersClubValidator(
      {String invalidMessage = "Invalid Diners Club Card Number"})
      : super(
          regex: RegExp(r"^3(?:0[0-5]|[68][0-9])[0-9]{11}$"),
          invalidMessage: invalidMessage,
        );
}

/// A DiscoverClub Validator
///
/// generally used in [LFormField]
class LDiscoverCardValidator extends LRegexValidator {
  LDiscoverCardValidator(
      {String invalidMessage = "Invalid Discover Card Number"})
      : super(
          regex: RegExp(r"^6(?:011|5[0-9]{2})[0-9]{12}$"),
          invalidMessage: invalidMessage,
        );
}

/// A JCBCardValidator Validator
///
/// generally used in [LFormField]
class LJCBCardValidator extends LRegexValidator {
  LJCBCardValidator({String invalidMessage = "Invalid JCB Card Number"})
      : super(
          regex: RegExp(r"^(?:2131|1800|35\d{3})\d{11}$"),
          invalidMessage: invalidMessage,
        );
}

/// Matches only Visa, MasterCard, Discover, JCB, AmericanExpress, DinersClub
/// For other cards use [LRegexValidator] along with [LCombinedValidator]
///
/// example:
/// ```dart
/// final someOtherCardValidator = LRegexValidator(
///   regex: RegExp(r'other_card_regex'),
///   invalidMessage: "Invalid Card",
/// );
/// final newCreditCardValidator = LCombinedValidator(validators: [
///   someOtherCardValidator,
///   LCreditCardValidator(),
/// ]);
///
/// final isValid =
///     newCreditCardValidator.valid(candidate: "Some Credit Card Number"); // true | false
///```
class LCreditCardValidator extends LRegexValidator {
  LCreditCardValidator({String invalidMessage = "Invalid JCB Card Number"})
      : super(
          regex:
              RegExp(r"^(?:4[0-9]{12}(?:[0-9]{3})?|(?:5[1-5][0-9]{2}|222[1-9]|"
                  "22[3-9][0-9]|2[3-6][0-9]{2}|27[01][0-9]|2720)[0-9]{12}|3["
                  "47][0-9]{13}|3(?:0[0-5]|[68][0-9])[0-9]{11}|6(?:011|5[0-9]"
                  r"{2})[0-9]{12}|(?:2131|1800|35\d{3})\d{11})$"),
          invalidMessage: invalidMessage,
        );
}
