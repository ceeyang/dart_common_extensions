import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('ListExtensions', () {
    test('random returns a random element from the list', () {
      final list = [1, 2, 3];
      expect(list.contains(list.random), isTrue);
    });

    test('safeElementAt returns the correct element or null', () {
      final list = ['a', 'b', 'c'];
      expect(list.safeElementAt(1), 'b');
      expect(list.safeElementAt(3), isNull);
    });

    test('firstWhereOrNull finds an element or returns null', () {
      final list = [1, 2, 3];
      expect(list.firstWhereOrNull((item) => item == 2), 2);
      expect(list.firstWhereOrNull((item) => item == 4), isNull);
    });

    test('shuffled returns a shuffled list', () {
      final list = [1, 2, 3, 4];
      final shuffledList = list.shuffled;
      expect(list.length, shuffledList.length);
      expect(list.toSet().difference(shuffledList.toSet()).isEmpty, isTrue);
    });

    test('chunked creates sublists of a given size', () {
      final list = [1, 2, 3, 4, 5];
      final chunks = list.chunked(2);
      expect(chunks, [
        [1, 2],
        [3, 4],
        [5]
      ]);
    });

    test('firstWhereOrElse finds an element or returns the orElse value', () {
      final list = ['short', 'longer', 'longest'];
      expect(list.firstWhereOrElse((item) => item.length > 5, 'default'), 'longer');
      expect(list.firstWhereOrElse((item) => item.length > 10, 'default'), 'default');
    });

    test('addIfNotContains adds an element if it does not already contain it', () {
      final list = [1, 2, 3];
      list.addIfNotContains(4);
      expect(list, contains(4));
      list.addIfNotContains(4);
      expect(list, containsAll([1, 2, 3, 4]));
      expect(list.length, 4);
    });

    test('removeFirstWhere removes the first element that satisfies the test', () {
      final list = ['a', 'b', 'c', 'b'];
      final result = list.removeFirstWhere((item) => item == 'b');
      expect(result, isTrue);
      expect(list, equals(['a', 'c', 'b']));
    });

    test('isEmptyOrNull checks if the list is empty or contains only nulls', () {
      expect([null, null].isEmptyOrNull, isTrue);
      expect([].isEmptyOrNull, isTrue);
      expect([null, 1].isEmptyOrNull, isFalse);
    });

    test('reversedList returns a new list with elements in reverse order', () {
      expect([1, 2, 3].reversedList, equals([3, 2, 1]));
    });

    test('mapToList converts each element to another type', () {
      final list = [1, 2, 3];
      expect(list.mapToList((item) => item.toString()), equals(['1', '2', '3']));
    });

    test('groupBy groups elements by the provided key', () {
      final list = ['one', 'two', 'three'];
      expect(list.groupBy((item) => item.length), {
        3: ['one', 'two'],
        5: ['three']
      });
    });

    test('unique returns a new list with only unique elements', () {
      expect([1, 2, 2, 3, 3, 3].unique, equals([1, 2, 3]));
    });
  });

  group('NumListExtensions', () {
    test('sum calculates the sum of all elements', () {
      expect([1, 2, 3].sum, 6);
      expect([2].sum, 2);
    });

    test('average calculates the average value', () {
      expect([1, 2, 3, 4].average, 2.5);
      expect([1].average, 1);
    });
  });
}
