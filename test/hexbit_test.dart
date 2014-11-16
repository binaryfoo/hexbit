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

  test("Set of bits should override ==", () {
    expect(Bit.fromHex("ff") == Bit.fromHex("ff"), equals(true));
  });

  test("toString()", () {
    expect(Bit.on(3, 2).toString(), equals("Byte 3 Bit 2 = 1"));
    expect(Bit.fromHex("01").where((bit) => bit.set).first.toString(), equals("Byte 1 Bit 1 = 1"));
  });
}