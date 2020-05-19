import 'base_parser.dart';

/// Used to parse the argument from styleClasses
///
///
/// ```dart
/// LText("This line is very \l.highlight(hex=#37f5b5){important}.");
/// ```
///ArgumentParser will parse `hex` and `#37f5b5` from `highlight`
///styleClass`s arguments
///in above snippet
class ArgumentParser extends Parser {
  static final RegExp _argsRegex = RegExp(r"(\w+)=(.*)");
  ArgumentParser(String subject) : super(subject, _argsRegex);

  RegExpMatch get parsed => _argsRegex.firstMatch(subject);
}
