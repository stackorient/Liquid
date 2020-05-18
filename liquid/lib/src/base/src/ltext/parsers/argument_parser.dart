import 'base_parser.dart';

class ArgumentParser extends Parser {
  static final RegExp _argsRegex = RegExp(r"(\w+)=(.*)");
  ArgumentParser(String subject) : super(subject, _argsRegex);

  RegExpMatch get parsed => _argsRegex.firstMatch(subject);
}
