import 'lstyle.dart';
import 'base_parser.dart';
import 'class_parser.dart';

class SpanParser extends Parser {
  static final RegExp _spanRegex = RegExp(
    r"\l(\.[\w=:.(),/&?]+)+{([^}].*)}",
    multiLine: true,
    dotAll: true,
  );

  SpanParser(String subject) : super(subject, _spanRegex);

  Iterable<RegExpMatch> get _parsed => _spanRegex.allMatches(subject);

  Iterable<LTextSpanBuilder> getSpans() sync* {
    int _lastI = 0;
    for (final _ in _parsed) {
      if (_.start != _lastI) {
        final String str = subject.substring(_lastI, _.start);
        _lastI = _.end;
        yield LTextSpanBuilder(null, str);
      }
      final String str = _.group(2);
      yield LTextSpanBuilder(ClassParser(_.group(1)).getClasses(), str);
    }

    if (_lastI != subject.length - 1) {
      final String str = subject.substring(_lastI);
      yield LTextSpanBuilder(null, str);
    }
  }
}
