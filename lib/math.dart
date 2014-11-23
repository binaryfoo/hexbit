class Math {
  static String add(String char, int n) {
    int val = int.parse(char, radix: 16);
    val += n;
    if (val > 15) {
      val = 0;
    } else if (val < 0) {
      val = 15;
    }
    return val.toRadixString(16);
  }
}