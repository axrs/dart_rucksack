import 'package:rucksack/src/objects.dart' as objects;
import 'package:test/test.dart';

void main() {
  test('isNull() is true if the value is null', () {
    String? v;
    expect(objects.isNull(v), isTrue);
    expect(objects.isNull('value'), isFalse);
    List x = [];
    expect(objects.isNull(x), isFalse);
  });

  test('isNotNull() is true if the value is NOT null', () {
    String? v;
    expect(objects.isNotNull(v), isFalse);
    expect(objects.isNotNull('value'), isTrue);
    List x = [];
    expect(objects.isNotNull(x), isTrue);
  });

  test(
      'cast() casts the value to the specified Type if it is an instance of it',
      () {
    var v = '1234';
    expect(objects.cast<String>(v), equals(v));
    expect(objects.cast<List>(v), isNull);
    List x = [];
    expect(objects.cast<String>(x), isNull);
    expect(objects.cast<List>(x), equals(x));
  });
}
