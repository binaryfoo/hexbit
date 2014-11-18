library hexbit_test;

import "package:hexbit/math.dart";
import "package:unittest/unittest.dart";
import "package:matcher/matcher.dart";

main() {
  test("add to hex digit", () {
    expect(Math.add('0', 1), equals('1'));
    expect(Math.add('9', 1), equals('a'));
    expect(Math.add('a', 1), equals('b'));
    expect(Math.add('f', 1), equals('0'));
    expect(Math.add('0', -1), equals('f'));
  });
}