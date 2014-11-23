import 'dart:math';

class Math {
  static String add(String hex, int n) {
    var addFieldSize = min(4, hex.length);
    int val = int.parse(hex.substring(hex.length - addFieldSize), radix: 16);
    val += n;
    int bound = pow(2, addFieldSize * 4) - 1;
    if (val > bound) {
      val = 0;
    } else if (val < 0) {
      val = bound;
    }
    var newHex = val.toRadixString(16);
    if (hex.length > 4) {
      return hex.substring(0, hex.length - 4) + newHex.padLeft(addFieldSize, '0');
    } else {
      return newHex.padLeft(hex.length, '0');
    }
  }
}