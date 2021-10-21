import 'package:rucksack/src/collections.dart' as collections;
import 'package:test/test.dart';

void main() {
  test('isEmpty() is true if the list is null or empty', () {
    expect(collections.isEmpty(null), isTrue);
    expect(collections.isEmpty([]), isTrue);
    expect(collections.isEmpty([1]), isFalse);
  });

  test('isNotEmpty() is true if the list is not empty', () {
    expect(collections.isNotEmpty(null), isFalse);
    expect(collections.isNotEmpty([]), isFalse);
    expect(collections.isNotEmpty([1]), isTrue);
  });
}
