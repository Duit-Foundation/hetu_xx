import "package:hetu_script/logger/message_severity.dart";
import "package:hetu_script/logger/logger.dart";

class HTConsoleLogger extends HTLogger {
  const HTConsoleLogger();

  @override
  void log(String message, {MessageSeverity severity = MessageSeverity.none}) {
    print(message);
  }
}
