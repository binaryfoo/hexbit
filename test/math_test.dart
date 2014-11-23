library hexbit_test;

import "package:hexbit/math.dart";
import "package:unittest/unittest.dart";
import "package:matcher/matcher.dart";

main() {
  test("addition wraps with one hex digit", () {
    expect(Math.add('0', 1), equals('1'));
    expect(Math.add('9', 1), equals('a'));
    expect(Math.add('a', 1), equals('b'));
    expect(Math.add('f', 1), equals('0'));
    expect(Math.add('0', -1), equals('f'));
  });

  test("addition flows into second with two hex digits", () {
    expect(Math.add('0f', 1), equals('10'));
    expect(Math.add('10', -1), equals('0f'));
    expect(Math.add('ff', 1), equals('00'));
    expect(Math.add('00', -1), equals('ff'));
  });

  test("addition flows into second with up to 4 hex digits", () {
    expect(Math.add('0ff', 1), equals('100'));
    expect(Math.add('100', -1), equals('0ff'));
    expect(Math.add('fff', 1), equals('000'));
    expect(Math.add('000', -1), equals('fff'));
    expect(Math.add('0fff', 1), equals('1000'));
    expect(Math.add('1000', -1), equals('0fff'));
    expect(Math.add('ffff', 1), equals('0000'));
    expect(Math.add('0000', -1), equals('ffff'));
  });

  test("addition only uses low 4 when more than 4 hex digits", () {
    expect(Math.add('fffff', 1), equals('f0000'));
    expect(Math.add('f0000', 1), equals('f0001'));
    expect(Math.add('10000', -1), equals('1ffff'));
  });
}