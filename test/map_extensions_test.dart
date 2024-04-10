import 'dart:convert';

import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:flutter_test/flutter_test.dart';

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
  });
}
