// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// A Text Capitalization Function
String textCapitalize(String text) {
  return text
      .split(" ")
      .map((word) =>
          word.length > 0 ? word[0].toUpperCase() + word.substring(1) : word)
      .join(" ");
}
