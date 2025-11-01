import 'dart:math';

const List<String> bodyVariants = <String>[
  // Simple return values
  "return 'hello'",
  'return 42',
  'return true',
  // Printing and simple arithmetic
  "print('hi from random fn')",
  'var a = 6\n  var b = 7\n  return a * b',
  // Control flow
  'var n = 5\n  var sum = 0\n  for (var i = 0; i < n; ++i) {\n    sum = sum + i\n  }\n  return sum',
  // Map and list operations
  "var m = Map()\n  m['x'] = 1\n  m['y'] = 2\n  return m['x'] + m['y']",
  'var list = [1, 2, 3]\n  var total = 0\n  for (var v in list) {\n    total = total + v\n  }\n  print(total)'
];

String randomIdentifier(int minLen, int maxLen) {
  final Random random = Random();
  final int length = minLen + random.nextInt(max(1, maxLen - minLen + 1));
  const String letters = 'abcdefghijklmnopqrstuvwxyz';
  const String lettersDigits = 'abcdefghijklmnopqrstuvwxyz0123456789_';
  final StringBuffer sb = StringBuffer('fn_');
  // Ensure identifier starts with a letter for better compatibility.
  sb.write(letters[random.nextInt(letters.length)]);
  for (int i = 1; i < length; i++) {
    sb.write(lettersDigits[random.nextInt(lettersDigits.length)]);
  }
  return sb.toString();
}

/// Generates a Hetu Script function as a string with a random name and
/// a randomly selected body from predefined variants.
String generateRandomHetuFunction({
  int minNameLength = 6,
  int maxNameLength = 12,
}) {
  final Random random = Random();

  final String fnName = randomIdentifier(minNameLength, maxNameLength);
  final String buffer = bodyVariants[random.nextInt(bodyVariants.length)];

  final StringBuffer hetu = StringBuffer();
  hetu.writeln('function ' + fnName + ' {');
  for (final String line in buffer.split('\n')) {
    hetu.writeln('  ' + line);
  }
  hetu.writeln('}');
  return hetu.toString();
}
