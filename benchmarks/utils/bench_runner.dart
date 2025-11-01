import 'package:benchmark_harness/benchmark_harness.dart';

final class BenchRunner {
  final List<BenchmarkBase> arr;

  BenchRunner(this.arr);

  void call() {
    for (var b in arr) {
      final data = <double>[];
      for (var i = 0; i < 1; i++) {
        final x = b.measure();
        data.add(x);
      }
      final mid = _median(data);
      print("${b.name}:$mid");
    }
  }

  double _median(List<double> data) {
    final sum = data.reduce((a, b) => a + b);
    return sum / data.length;
  }
}
