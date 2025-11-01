import '../utils/bench_runner.dart';
import '../utils/fn_randomizer.dart';
import 'lexer.dart';

final lexerRunner = BenchRunner(
  [
    LexerBenchmark("LexerShort", generateRandomHetuFunction()),
    LexerBenchmark(
      "LexerLong",
      List<String>.generate(250, (_) {
        return generateRandomHetuFunction();
      }).join().toString(),
    ),
  ],
);
