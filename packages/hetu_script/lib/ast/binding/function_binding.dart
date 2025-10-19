import "dart:math" as math;

import "package:quiver/iterables.dart";
import "package:fast_noise/fast_noise.dart";
import "package:hetu_script/utils/math.dart";

/// Core exernal functions for use globally in Hetu script.
final Map<String, Function> preincludeFunctions = {
  "range": ({positionalArgs, namedArgs}) =>
      range(positionalArgs[0], positionalArgs[1], positionalArgs[2]),
  "parseInt": ({positionalArgs, namedArgs}) =>
      int.tryParse(positionalArgs[0], radix: positionalArgs[1]),
  "parseFloat": ({positionalArgs, namedArgs}) =>
      double.tryParse(positionalArgs.first),
  "Math.random": ({positionalArgs, namedArgs}) => math.Random().nextDouble(),
  "Math.min": ({positionalArgs, namedArgs}) {
    if (positionalArgs[0] == null) {
      return positionalArgs[1];
    }
    if (positionalArgs[1] == null) {
      return positionalArgs[0];
    }
    return math.min(positionalArgs[0] as num, positionalArgs[1] as num);
  },
  "Math.max": ({positionalArgs, namedArgs}) {
    if (positionalArgs[0] == null) {
      return positionalArgs[1];
    }
    if (positionalArgs[1] == null) {
      return positionalArgs[0];
    }
    return math.max(positionalArgs[0] as num, positionalArgs[1] as num);
  },
  "Math.pow": ({positionalArgs, namedArgs}) =>
      math.pow(positionalArgs[0] as num, positionalArgs[1] as num),
  "Math.sin": ({positionalArgs, namedArgs}) =>
      math.sin(positionalArgs.first as num),
  "Math.cos": ({positionalArgs, namedArgs}) =>
      math.cos(positionalArgs.first as num),
  "Math.tan": ({positionalArgs, namedArgs}) =>
      math.tan(positionalArgs.first as num),
  "Math.asin": ({positionalArgs, namedArgs}) =>
      math.asin(positionalArgs.first as num),
  "Math.acos": ({positionalArgs, namedArgs}) =>
      math.acos(positionalArgs.first as num),
  "Math.atan": ({positionalArgs, namedArgs}) =>
      math.atan(positionalArgs.first as num),
  "Math.sqrt": ({positionalArgs, namedArgs}) =>
      math.sqrt(positionalArgs.first as num),
  "Math.exp": ({positionalArgs, namedArgs}) =>
      math.exp(positionalArgs.first as num),
  "Math.log": ({positionalArgs, namedArgs}) =>
      math.log(positionalArgs.first as num),
  "Math.degrees": ({positionalArgs, namedArgs}) =>
      degrees(positionalArgs.first.toDouble()),
  "Math.radians": ({positionalArgs, namedArgs}) =>
      radians(positionalArgs.first.toDouble()),
  "Math.radiusToSigma": ({positionalArgs, namedArgs}) =>
      radiusToSigma(positionalArgs.first.toDouble()),
  "Math.gaussianNoise": ({positionalArgs, namedArgs}) {
    final mean = positionalArgs[0].toDouble();
    final standardDeviation = positionalArgs[1].toDouble();
    final math.Random? randomGenerator = namedArgs["randomGenerator"];
    assert(standardDeviation > 0);
    final num? min = namedArgs["min"];
    final num? max = namedArgs["max"];
    double r;
    do {
      r = gaussianNoise(
        mean,
        standardDeviation,
        randomGenerator: randomGenerator,
      );
    } while ((min != null && r < min) || (max != null && r > max));
    return r;
  },
  "Math.noise2d": ({positionalArgs, namedArgs}) {
    final int width = positionalArgs[0].toInt();
    final int height = positionalArgs[1].toInt();
    final seed = namedArgs["seed"] ?? math.Random().nextInt(1 << 32);
    final double frequency = namedArgs["frequency"] ?? 0.01;
    final int octaves = namedArgs["octaves"] ?? 3;
    final noiseTypeString = namedArgs["noiseType"];
    final noiseType = NoiseType.values.singleWhere(
      (item) {
        return item.name == noiseTypeString;
      },
      orElse: () => NoiseType.valueFractal,
    );
    return noise2(
      width,
      height,
      seed: seed,
      frequency: frequency,
      noiseType: noiseType,
      octaves: octaves,
    );
  },
  "Math.angle": ({positionalArgs, namedArgs}) => angle(
        positionalArgs[0],
        positionalArgs[1],
        positionalArgs[2],
        positionalArgs[3],
      ),
  "Math.aangle": ({positionalArgs, namedArgs}) => aangle(
        positionalArgs[0],
        positionalArgs[1],
        positionalArgs[2],
        positionalArgs[3],
      ),
  "Math.gradualValue": ({positionalArgs, namedArgs}) => gradualValue(
        positionalArgs[0],
        positionalArgs[1],
        power: namedArgs["power"] ?? 0.5,
      ),
};
