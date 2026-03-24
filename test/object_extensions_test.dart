import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('ObjectExtensions Tests', () {
    test('let executes correctly', () {
      final result = "hello".let((it) => it.length);
      expect(result, equals(5));

      final result2 = 10.let((it) => it * 2);
      expect(result2, equals(20));
    });

    test('also executes side effects and returns original object', () {
      int sideEffect = 0;
      final obj = "test";
      final result = obj.also((it) {
        sideEffect = it.length;
      });

      expect(result, equals(obj));
      expect(sideEffect, equals(4));
    });

    test('isNull and isNotNull work correctly', () {
      String? nullObj;
      String? nonNullObj = "hi";

      expect(nullObj.isNull, isTrue);
      expect(nullObj.isNotNull, isFalse);

      expect(nonNullObj.isNull, isFalse);
      expect(nonNullObj.isNotNull, isTrue);
    });
  });
}
