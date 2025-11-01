import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:hetu_xx/hetu_xx.dart';

class ParserSourceBenchmark extends BenchmarkBase {
  final HTSource src;
  final _parser = HTParserHetu();

  ParserSourceBenchmark(
    super.name,
    this.src,
  );

  @override
  void run() {
    _parser.parseSource(src);
  }
}

class ParserTokenBenchmark extends BenchmarkBase {
  final HTSource src;
  final _parser = HTParserHetu();
  late Token tkn;

  ParserTokenBenchmark(
    super.name,
    this.src,
  );

  @override
  void setup() {
    final lxr = HTLexerHetu();
    tkn = lxr.lex(src.content);
  }

  @override
  void run() {
    _parser.parseTokens(tkn);
  }
}
