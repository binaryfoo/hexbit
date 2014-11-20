library hexbit_test;

import "package:hexbit/hexbit.dart";
import "package:unittest/unittest.dart";
import "package:matcher/matcher.dart";

main() {

  test("Bit is sorts by byte, bit then value", () {
    expect(Bit.on(1, 2).compareTo(Bit.on(0, 2)), equals(1));
    expect(Bit.on(1, 2).compareTo(Bit.on(2, 2)), equals(-1));
    expect(Bit.on(1, 2).compareTo(Bit.on(1, 1)), equals(1));
    expect(Bit.on(1, 2).compareTo(Bit.on(1, 3)), equals(-1));
    expect(Bit.off(1, 2).compareTo(Bit.on(1, 2)), equals(-1));
    expect(Bit.on(1, 2).compareTo(Bit.on(1, 2)), equals(0));
  });

  test("Bit set from hex string", () {
    expect(Bit.fromHex("08"), contains(Bit.on(1, 4)));
    expect(Bit.fromHex("08"), hasLength(8));
    expect(Bit.fromHex("0080"), contains(Bit.on(2, 8)));
    expect(Bit.fromHex("0001"), contains(Bit.on(2, 1)));
    expect(Bit.fromHex("0000"), hasLength(16));
  });

  test("From hex with optional first byte number", () {
    expect(Bit.fromHex("ff", 3), contains(Bit.on(3, 1)));
  });

  test("All bits set for FF", () {
    var set = Bit.fromHex("FF");
    for (var i = 1; i <= 8; ++i) {
      expect(set, contains(Bit.on(1, i)));
    }
  });

  test("All bits set for 00", () {
    var set = Bit.fromHex("00");
    for (var i = 1; i <= 8; ++i) {
      expect(set, contains(Bit.off(1, i)));
    }
  });

  test("Should override ==", () {
    expect(Bit.on(1, 1) == Bit.on(1, 1), equals(true));
    expect(Bit.on(1, 1) == Bit.off(1, 1), equals(false));
    expect(Bit.on(1, 1) == Bit.on(1, 2), equals(false));
    expect(Bit.on(1, 1) == Bit.on(2, 1), equals(false));
  });

  test("toString()", () {
    expect(Bit.on(3, 2).toString(), equals("Byte 3 Bit 2 = 1"));
    expect(Bit.fromHex("01").where((bit) => bit.set).first.toString(), equals("Byte 1 Bit 1 = 1"));
  });

  test("id", () {
    expect(Bit.on(4, 2).id, equals("4-2-1"));
    expect(Bit.off(3, 5).id, equals("3-5-0"));
  });

  test("absolute bit number", () {
    expect(Bit.on(1, 1).absoluteBitNumber, equals(1));
    expect(Bit.on(1, 4).absoluteBitNumber, equals(4));
    expect(Bit.on(2, 4).absoluteBitNumber, equals(12));
    expect(Bit.on(2, 1).absoluteBitNumber, equals(9));
  });

  test("access bit in set via (byte,bit) numbers", () {
    expect(Bit.fromHex("810042").bit(1, 8), equals(Bit.on(1, 8)));
    expect(Bit.fromHex("810042").bit(1, 1), equals(Bit.on(1, 1)));
    expect(Bit.fromHex("810042").bit(3, 1), equals(Bit.off(3, 1)));
    expect(Bit.fromHex("810042").bit(3, 2), equals(Bit.on(3, 2)));
    expect(Bit.fromHex("810042").bit(3, 7), equals(Bit.on(3, 7)));
    expect(Bit.fromHex("810042").bit(3, 8), equals(Bit.off(3, 8)));
  });

  test("byte count of bit set", () {
    expect(Bit.fromHex("").byteCount, equals(0));
    expect(Bit.fromHex("11").byteCount, equals(1));
    expect(Bit.fromHex("112233").byteCount, equals(3));
  });
}
