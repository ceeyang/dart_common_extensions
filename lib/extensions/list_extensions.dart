part of '../dart_extensions.dart';

/// Common iterable extensions
extension IterableExtensions<T> on Iterable<T> {
  /// Tries to find the first element in the iterable that matches the given [test].
  /// Returns null if no such element is found.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3];
  /// var result = list.firstWhereOrNull((i) => i > 2); // 3
  /// ```
  T? firstWhereOrNull(bool Function(T) test) {
    for (T element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// Groups the elements in the iterable according to the [keyFunction].
  /// Returns a map where each key corresponds to a list of elements that share that key.
  ///
  /// Example:
  /// ```dart
  /// var list = ['a', 'ab', 'b'];
  /// var result = list.groupBy((s) => s.length); // {1: ['a', 'b'], 2: ['ab']}
  /// ```
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    return fold(<K, List<T>>{}, (Map<K, List<T>> map, T element) {
      final K key = keyFunction(element);
      map.putIfAbsent(key, () => []).add(element);
      return map;
    });
  }

  /// Returns a new list containing the unique elements from the original iterable.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 2, 3];
  /// var result = list.unique; // [1, 2, 3]
  /// ```
  List<T> get unique => toSet().toList();

  /// Converts the iterable to a list using a [convert] function for each element.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2];
  /// var result = list.mapToList((i) => i.toString()); // ['1', '2']
  /// ```
  List<E> mapToList<E>(E Function(T) convert) => map(convert).toList();

  /// Calculates the sum of all elements in the iterable by mapping them to numeric values.
  ///
  /// Example:
  /// ```dart
  /// var list = ['a', 'ab'];
  /// var result = list.sumBy((s) => s.length); // 3
  /// ```
  num sumBy(num Function(T) selector) =>
      isEmpty ? 0 : map(selector).reduce((value, element) => value + element);

  /// Calculates the average value of all elements in the iterable by mapping them to numeric values.
  ///
  /// Example:
  /// ```dart
  /// var list = ['a', 'abc'];
  /// var result = list.averageBy((s) => s.length); // 2.0
  /// ```
  num averageBy(num Function(T) selector) => isEmpty ? 0 : sumBy(selector) / length;

  /// Maps each element along with its index to a new value.
  ///
  /// Example:
  /// ```dart
  /// var list = ['a', 'b'];
  /// var result = list.mapIndexed((i, e) => '$i: $e'); // ['0: a', '1: b']
  /// ```
  Iterable<E> mapIndexed<E>(E Function(int index, T element) f) sync* {
    var index = 0;
    for (var element in this) {
      yield f(index++, element);
    }
  }

  /// Iterates through the iterable with both index and element.
  ///
  /// Example:
  /// ```dart
  /// [1, 2].forEachIndexed((index, element) => print('$index: $element'));
  /// ```
  void forEachIndexed(void Function(int index, T element) f) {
    var index = 0;
    for (var element in this) {
      f(index++, element);
    }
  }

  /// Returns a new iterable containing elements that satisfy the test with their index.
  ///
  /// Example:
  /// ```dart
  /// [10, 20, 30].whereIndexed((i, e) => i > 0); // [20, 30]
  /// ```
  Iterable<T> whereIndexed(bool Function(int index, T element) test) sync* {
    var index = 0;
    for (var element in this) {
      if (test(index++, element)) {
        yield element;
      }
    }
  }

  /// Returns a list of unique elements based on a selector function.
  ///
  /// Example:
  /// ```dart
  /// var list = [{'id': 1}, {'id': 1}, {'id': 2}];
  /// var result = list.distinctBy((e) => e['id']); // [{'id': 1}, {'id': 2}]
  /// ```
  List<T> distinctBy(Object? Function(T e) selector) {
    final set = <Object?>{};
    return where((e) => set.add(selector(e))).toList();
  }

  /// Returns a sliding window of a given [size] and optional [step].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].windowed(2); // [[1, 2], [2, 3], [3, 4]]
  /// ```
  Iterable<List<T>> windowed(int size, {int step = 1, bool partialWindows = false}) sync* {
    final list = toList();
    for (var i = 0; i <= list.length - (partialWindows ? 1 : size); i += step) {
      final end = (i + size > list.length) ? list.length : i + size;
      yield list.sublist(i, end);
    }
  }

  /// Zips this iterable with another [other] iterable.
  ///
  /// Example:
  /// ```dart
  /// [1, 2].zip(['a', 'b']); // [[1, 'a'], [2, 'b']]
  /// ```
  Iterable<List<dynamic>> zip(Iterable<dynamic> other) sync* {
    final it1 = iterator;
    final it2 = other.iterator;
    while (it1.moveNext() && it2.moveNext()) {
      yield [it1.current, it2.current];
    }
  }

  /// Counts the number of elements that satisfy the [test].
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].count((i) => i % 2 == 0); // 2
  /// ```
  int count(bool Function(T element) test) {
    var c = 0;
    for (var element in this) {
      if (test(element)) c++;
    }
    return c;
  }
}

/// Common list extensions
extension ListExtensions<T> on List<T> {
  /// Randomly gets an element from the list.
  /// Returns null if the list is empty.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3];
  /// var result = list.random;
  /// ```
  T? get random => isEmpty ? null : this[(Random().nextInt(length))];

  /// Safely gets an element from the list at the given [index].
  /// Returns null if the [index] is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2];
  /// var result = list.safeElementAt(5); // null
  /// ```
  T? safeElementAt([int? index]) {
    if (index == null) return null;
    return (index >= 0 && index < length) ? this[index] : null;
  }

  /// Shuffles the elements of the list into a random order.
  /// Returns a new list with the shuffled elements.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3];
  /// var result = list.shuffled;
  /// ```
  List<T> get shuffled {
    var newList = List<T>.from(this);
    newList.shuffle();
    return newList;
  }

  /// Creates subLists of a given size from the list.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3, 4];
  /// var result = list.chunked(2); // [[1, 2], [3, 4]]
  /// ```
  List<List<T>> chunked(int chunkSize) {
    List<List<T>> chunks = [];
    for (var i = 0; i < length; i += chunkSize) {
      var end = (i + chunkSize < length) ? i + chunkSize : length;
      chunks.add(sublist(i, end));
    }
    return chunks;
  }

  /// Finds the first element matching [test], or returns [orElse] if none match.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2];
  /// var result = list.firstWhereOrElse((i) => i > 5, 0); // 0
  /// ```
  T firstWhereOrElse(bool Function(T) test, T orElse) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return orElse;
  }

  /// Adds an element to the list if it does not already contain it.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2];
  /// list.addIfNotContains(2); // list is still [1, 2]
  /// ```
  void addIfNotContains(T element) {
    if (!contains(element)) {
      add(element);
    }
  }

  /// Removes the first element in the list that satisfies the given [test].
  /// Returns true if an element was removed, otherwise false.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3];
  /// list.removeFirstWhere((i) => i % 2 == 0); // true, list is [1, 3]
  /// ```
  bool removeFirstWhere(bool Function(T) test) {
    for (T element in this) {
      if (test(element)) {
        remove(element);
        return true;
      }
    }
    return false;
  }

  /// Checks if the list only contains null values (or is empty).
  ///
  /// Example:
  /// ```dart
  /// var list = [null, null];
  /// print(list.isAllNull); // true
  /// ```
  bool get isAllNull => every((element) => element == null);

  /// Returns a new list with the elements in reverse order.
  ///
  /// Example:
  /// ```dart
  /// var list = [1, 2, 3];
  /// var result = list.reversedList; // [3, 2, 1]
  /// ```
  List<T> get reversedList => reversed.toList();

  /// Returns the first element that satisfies the highest priority predicate.
  /// Iterates through [priorities] and for each predicate, finds the first matching
  /// element in the list.
  ///
  /// Example:
  /// ```dart
  /// final result = list.firstWhereByPriority([
  ///   (m) => m.code == 'a',       // Priority 1
  ///   (m) => m.code == 'b',       // Priority 2
  ///   (m) => m.isDefault == true, // Priority 3
  /// ]);
  /// ```
  T? firstWhereByPriority(Iterable<bool Function(T)> priorities) {
    for (var priority in priorities) {
      for (var element in this) {
        if (priority(element)) {
          return element;
        }
      }
    }
    return null;
  }
}

/// Common num list extensions
extension NumListExtensions on List<num> {
  /// Calculates the sum of all elements in the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].sum; // 6
  /// ```
  num get sum => isEmpty ? 0 : reduce((value, element) => value + element);

  /// Calculates the average value of all elements in the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].average; // 2.5
  /// ```
  num get average => isEmpty ? 0 : sum / length;

  /// Returns the maximum value in the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 5, 2].max; // 5
  /// ```
  num get max {
    if (isEmpty) return 0;
    num max = this[0];
    for (var i = 1; i < length; i++) {
      if (this[i] > max) max = this[i];
    }
    return max;
  }

  /// Returns the minimum value in the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 5, 2].min; // 1
  /// ```
  num get min {
    if (isEmpty) return 0;
    num min = this[0];
    for (var i = 1; i < length; i++) {
      if (this[i] < min) min = this[i];
    }
    return min;
  }
}

/// Common int list extensions
extension IntListExtensions on List<int> {
  /// Calculates the sum of all elements in the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3].sum; // 6
  /// ```
  int get sum => isEmpty ? 0 : reduce((value, element) => value + element);

  /// Calculates the average value of all elements in the list.
  ///
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].average; // 2.5
  /// ```
  double get average => isEmpty ? 0 : sum / length;
}

/// Common double list extensions
extension DoubleListExtensions on List<double> {
  /// Calculates the sum of all elements in the list.
  ///
  /// Example:
  /// ```dart
  /// [1.0, 2.0].sum; // 3.0
  /// ```
  double get sum => isEmpty ? 0 : reduce((value, element) => value + element);

  /// Calculates the average value of all elements in the list.
  ///
  /// Example:
  /// ```dart
  /// [1.0, 3.0].average; // 2.0
  /// ```
  double get average => isEmpty ? 0 : sum / length;
}
