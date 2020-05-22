import 'lstyle.dart';
import 'base_parser.dart';
import 'class_parser.dart';

///Used to parse [LText]'s text and tokenization of styleClass
class SpanParser extends Parser {
  /// Regex for parsing \l tokens
  static final RegExp _spanRegex = RegExp(
    r"\l(\.[\w=:.(),-/&?@!$%^&*_+|~\`{}\[\]<>#]+)+{([^}].*?)}",
    multiLine: true,
    dotAll: true,
  );

  SpanParser(String subject) : super(subject, _spanRegex);

  /// private getter for getting parsed matches
  Iterable<RegExpMatch> get _matchList => _spanRegex.allMatches(subject);

  /// Tokenization of the spans
  Iterable<LTextSpanBuilder> getSpans() sync* {
    // tracks last char index for which tokenization is done
    int _lastIndex = 0;

    // iterate over matchlist
    // on each iteration first check if match has a normal string
    // then parse the remaining string which has styleClass applied
    // then update the lastIndex
    for (final match in _matchList) {
      if (match.start != _lastIndex) {
        final String str = subject.substring(_lastIndex, match.start);
        yield LTextSpanBuilder(null, str);
      }
      final String str = match.group(2);
      yield LTextSpanBuilder(ClassParser(match.group(1)).getClasses(), str);
      _lastIndex = match.end;
    }

    // if lastIndex wasn't at the end of string mean
    // there are unstyled string at the end of complete string
    // parse them too if they arn't
    if (_lastIndex != subject.length) {
      final String str = subject.substring(_lastIndex);
      yield LTextSpanBuilder(null, str);
    }
  }
}
