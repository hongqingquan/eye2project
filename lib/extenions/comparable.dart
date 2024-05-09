T min<T extends Comparable<dynamic>>(T a, T b) {
  return a.compareTo(b) < 0 ? a : b;
}

T max<T extends Comparable<dynamic>>(T a, T b) {
  return a.compareTo(b) > 0 ? a : b;
}
