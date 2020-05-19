import 'argument_parser.dart';
import 'lstyle.dart';
import 'base_parser.dart';

/// Used to tokenize the styleClass in parsed [LText] string
class ClassParser extends Parser {
  static final RegExp _classRegex = RegExp(r"\.([\w-]+)(\(([^)].*?)\))?");

  ClassParser(String subject) : super(subject, _classRegex);

  /// private getter for getting all the matched styleClasses
  Iterable<RegExpMatch> get _parsed => _classRegex.allMatches(subject);

  /// get styleClass name from [RegExpMatch]
  String getClassName(RegExpMatch exp) {
    if (exp.groupCount > 0) {
      return exp.group(1);
    }
    return null;
  }

  /// get parsed arguments from styleClasses if available
  ///
  /// See Also: [ArgumentParser]
  Map<String, String> getArguments(RegExpMatch exp) {
    Map<String, String> _result;
    final argsStr = exp.group(3);
    if (argsStr != null) {
      _result = {};

      final argsParsed = ArgumentParser(argsStr).parsed;

      if (argsParsed.groupCount == 2) {
        _result[argsParsed.group(1)] = argsParsed.group(2);
      }
    }

    return _result;
  }

  /// parses styleClasses from the text
  Iterable<LSpanToken> getClasses() sync* {
    for (final exp in _parsed) {
      final String className = getClassName(exp);
      final Map<String, String> args = getArguments(exp);
      yield LSpanToken(className, args);
    }
  }
}
