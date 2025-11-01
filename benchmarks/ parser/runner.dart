import 'package:hetu_xx/hetu_xx.dart';

import '../utils/bench_runner.dart';
import '../utils/fn_randomizer.dart';
import 'parser.dart';

final srcShort = HTSource(generateRandomHetuFunction());
final srcLong = HTSource(List<String>.generate(250, (_) {
  return generateRandomHetuFunction();
}).join());

final parserRunner = BenchRunner(
  [
    ParserSourceBenchmark("ParserShort", srcShort),
    ParserSourceBenchmark("ParserLong", srcLong),
    ParserTokenBenchmark("ParseTokensShort", srcShort),
    ParserTokenBenchmark("ParseTokensLong", srcLong),
  ],
);
