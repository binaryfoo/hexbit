library hexbit;

import 'package:collection/collection.dart';
import 'package:quiver/core.dart';

class BitSet extends DelegatingList<Bit> {

  BitSet() : super([]);

  /**
   * Both [byte] and [bit] start at 1.
   */
  Bit bit(int byte, int bit) {
    var index = (byte - 1) * 8 + 8 - bit;
    return index < length ? this[index] : null;
  }

  int get byteCount => (length + 4) ~/ 8;
}

/**
 * Bytes numbered left to right starting with 1.
 * Bits numbered right to left: least significant bit = 1.
 */
class Bit implements Comparable<Bit> {
  num byteNumber;
  num bitNumber;
  bool set;

  Bit(this.byteNumber, this.bitNumber, this.set);

  String get value => set ? "1" : "0";

  int get absoluteBitNumber => (byteNumber - 1) * 8 + bitNumber;

  String toString() => toLabel(false);

  String toLabel(bool includeComma) {
    var separator = includeComma ? "," : "";
    return "Byte ${byteNumber}${separator} Bit ${bitNumber} = ${value}";
  }

  bool operator ==(Bit other) {
    return byteNumber == other.byteNumber && bitNumber == other.bitNumber && set == other.set;
  }

  String get id => "${byteNumber}-${bitNumber}-${value}";

  int get hashCode => hash3(byteNumber, bitNumber, set);

  static BitSet fromHex(String string, [int firstByte = 1]) {
    var set = new BitSet();
    bool partial = string.length % 2 != 0;
    if (partial) {
      string += "0";
    }
    var end = string.length - 1;
    for (var i = 0; i < end; i += 2) {
      var byte = int.parse(string.substring(i, i + 2), radix: 16);
      var byteNumber = i~/2 + 1 + firstByte - 1;
      for (var bitIndex = 7; bitIndex >= 0; bitIndex--) {
        set.add(new Bit(byteNumber, bitIndex + 1, (byte >> bitIndex) & 1 == 1));
      }
    }
    if (partial) {
      set.removeRange(set.length - 4, set.length);
    }
    return set;
  }

  static Bit on(int byteNumber, int bitNumber) => new Bit(byteNumber, bitNumber, true);
  static Bit off(int byteNumber, int bitNumber) => new Bit(byteNumber, bitNumber, false);

  int compareTo(Bit other) {
    var first = byteNumber.compareTo(other.byteNumber);
    if (first != 0) return first;
    var second = bitNumber.compareTo(other.bitNumber);
    if (second != 0) return second;
    if (set && !other.set) return 1;
    if (!set && other.set) return -1;
    return 0;
  }

}