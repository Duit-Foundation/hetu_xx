import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:hetu_xx/hetu_xx.dart';

class LexerBenchmark extends BenchmarkBase {
  final _lexer = HTLexerHetu();
  final String content;

  LexerBenchmark(super.name, this.content);

  @override
  void run() {
    _lexer.lex(content);
  }
}
