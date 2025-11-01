.PHONY: bench

bench:
	sh benchmarks/run_benchmark.sh

.PHONY: example

example:
	dart run packages/hetu_script/example/example.dart