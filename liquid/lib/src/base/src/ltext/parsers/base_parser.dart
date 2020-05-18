class Parser {
  final String _subject;
  final RegExp _regExp;

  const Parser(this._subject, this._regExp)
      : assert(_subject != null),
        assert(_regExp != null);

  String get subject => _subject;
  RegExp get regex => _regExp;
}
