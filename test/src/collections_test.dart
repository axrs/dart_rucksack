import 'package:rucksack/src/collections.dart' as collections;
import 'package:test/test.dart';

void main() {
  test('isEmpty() is true if the list is null or empty', () {
    expect(collections.isEmpty(null), isTrue);
    expect(collections.isEmpty(<dynamic>{}), isTrue);
    expect(collections.isEmpty([]), isTrue);
    expect(collections.isEmpty({}), isTrue);
    expect(collections.isEmpty([1]), isFalse);
    expect(collections.isEmpty(<dynamic>{'key'}), isFalse);
    expect(collections.isEmpty({'key': 1}), isFalse);
  });

  test('isNotEmpty() is true if the list is not empty', () {
    expect(collections.isNotEmpty(null), isFalse);
    expect(collections.isNotEmpty(<dynamic>{}), isFalse);
    expect(collections.isNotEmpty([]), isFalse);
    expect(collections.isNotEmpty({}), isFalse);
    expect(collections.isNotEmpty([1]), isTrue);
    expect(collections.isNotEmpty(<dynamic>{'key'}), isTrue);
    expect(collections.isNotEmpty({'key': 1}), isTrue);
  });
}
