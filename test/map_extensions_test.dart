import 'dart:convert';

import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('MapExtensions', () {
    test('getOrDefault returns value for existing key and default for non-existing key', () {
      final map = {'first': 1, 'second': 2};
      expect(map.getOrDefault('first', 0), 1);
      expect(map.getOrDefault('third', 0), 0);
    });

    test('getOrNull returns value for existing key and null for non-existing key', () {
      final map = {'first': 1, 'second': 2};
      expect(map.getOrNull('second'), 2);
      expect(map.getOrNull('third'), isNull);
    });

    test('toJsonString converts map to JSON string', () {
      final map = {'name': 'John', 'age': 30};
      expect(jsonDecode(map.toJsonString()), equals(map));
    });

    test('toJsonStringWithIndent converts map to formatted JSON string', () {
      final map = {'name': 'John', 'age': 30};
      final jsonString = map.toJsonStringWithIndent(4);
      expect(jsonString, contains('John'));
      expect(jsonString, contains('    ')); // Check for indentation
    });

    test('invert inverts map keys and values', () {
      final map = {'first': 'John', 'second': 'Doe'};
      final invertedMap = map.invert();
      expect(invertedMap, equals({'John': 'first', 'Doe': 'second'}));
    });

    test('filterKeys filters map based on key condition', () {
      final map = {'first': 1, 'second': 2, 'third': 3};
      expect(map.filterKeys((key) => key.startsWith('f')), equals({'first': 1}));
    });

    test('filterValues filters map based on value condition', () {
      final map = {'first': 1, 'second': 2, 'third': 3};
      expect(map.filterValues((value) => value > 1), equals({'second': 2, 'third': 3}));
    });

    test('merge merges two maps with custom resolve function for duplicate keys', () {
      final map1 = {'first': 1, 'second': 2};
      final map2 = {'second': 3, 'third': 4};
      expect(map1.merge(map2, (v1, v2) => v1 + v2), equals({'first': 1, 'second': 5, 'third': 4}));
    });

    test('pick and omit work correctly', () {
      final map = {'a': 1, 'b': 2, 'c': 3};
      expect(map.pick(['a', 'c']), equals({'a': 1, 'c': 3}));
      expect(map.pick(['z']), isEmpty);
      expect(map.omit(['b']), equals({'a': 1, 'c': 3}));
    });

    test('any and all work correctly', () {
      final map = {'a': 1, 'b': 2};
      expect(map.any((k, v) => v > 1), isTrue);
      expect(map.any((k, v) => v > 5), isFalse);
      expect(map.all((k, v) => v > 0), isTrue);
      expect(map.all((k, v) => v > 1), isFalse);
    });

    test('mapKeys and mapValues work correctly', () {
      final map = {'a': 1, 'b': 2};
      expect(map.mapKeys((k, v) => k.toUpperCase()), equals({'A': 1, 'B': 2}));
      expect(map.mapValues((k, v) => v * 10), equals({'a': 10, 'b': 20}));
    });
  });
}
