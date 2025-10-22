import "package:hetu_script/logger/index.dart";

class HTConsoleLogger extends HTLogger {
  const HTConsoleLogger();

  @override
  void log(String message, {MessageSeverity severity = MessageSeverity.none}) {
    print(message);
  }
}
