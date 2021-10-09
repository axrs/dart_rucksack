import 'package:dart_rucksack/src/booleans.dart' as booleans;
import 'package:test/test.dart';

void main() {
  test('isFalse() is true if the value is false', () {
    expect(booleans.isFalse(null), isFalse);
    expect(booleans.isFalse(true), isFalse);
    expect(booleans.isFalse(false), isTrue);
  });

  test('isTrue() is true if the value is true', () {
    expect(booleans.isTrue(null), isFalse);
    expect(booleans.isTrue(false), isFalse);
    expect(booleans.isTrue(true), isTrue);
  });
}
