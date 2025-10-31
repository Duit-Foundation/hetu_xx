import "package:hetu_xx/logger/index.dart";

class HTConsoleLogger extends HTLogger {
  const HTConsoleLogger();

  @override
  void log(String message, {MessageSeverity severity = MessageSeverity.none}) {
    print(message);
  }
}
