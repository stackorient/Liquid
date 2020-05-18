import 'argument_parser.dart';
import 'lstyle.dart';
import 'base_parser.dart';

class ClassParser extends Parser {
  static final RegExp _classRegex = RegExp(r"\.(\w+)(\(([^)].*?)\))?");

  ClassParser(String subject) : super(subject, _classRegex);

  Iterable<RegExpMatch> get _parsed => _classRegex.allMatches(subject);

  String getClassName(RegExpMatch exp) {
    if (exp.groupCount > 0) {
      return exp.group(1);
    }
    return null;
  }

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

  Iterable<LSpanData> getClasses() sync* {
    for (final exp in _parsed) {
      final String className = getClassName(exp);
      final Map<String, String> args = getArguments(exp);
      yield LSpanData(className, args);
    }
  }
}
