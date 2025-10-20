extension Binary on int {
  int get b => int.parse(toRadixString(10), radix: 2);
}
