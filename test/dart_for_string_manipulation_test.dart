import 'package:dart_for_string_manipulation/dart_for_string_manipulation.dart';
import 'package:test/test.dart';

void main() {
  test('manipulateStringInIsolate reverses string correctly', () async {
    var result = await manipulateStringInIsolate('hello', 'reverse');
    expect(result, equals('olleh'));
  });

  test('manipulateStringInIsolate handles uppercase command', () async {
    var result = await manipulateStringInIsolate('hello', 'uppercase');
    expect(result, equals('HELLO'));
  });

  test('manipulateStringInIsolate handles invalid command', () async {
    var result = await manipulateStringInIsolate('hello', 'invalid');
    expect(result, isNull);
  });
}
