import 'package:talker/talker.dart';

class LogHelper {
  static final Talker talker = Talker();

  static void info(String message) {
    talker.info(message);
  }

  static void warning(String message) {
    talker.warning(message);
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    talker.error(message, error, stackTrace);
  }

  static void debug(String message) {
    talker.debug(message);
  }

  static void exception(Exception exception, [StackTrace? stackTrace]) {
    talker.handle(exception, stackTrace);
  }
}
