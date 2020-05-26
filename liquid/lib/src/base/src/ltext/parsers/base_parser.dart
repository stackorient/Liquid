// Copyright (c) 2020, the Liquid project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

///Abstract Base class for all the Parser used by [LText]
abstract class Parser {
  final String _subject;
  final RegExp _regExp;

  const Parser(this._subject, this._regExp)
      : assert(_subject != null),
        assert(_regExp != null);

  String get subject => _subject;
  RegExp get regex => _regExp;
}
