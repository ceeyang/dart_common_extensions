part of '../dart_extensions.dart';

/// Common list extensions
extension ListExtensions<T> on List<T> {
  /// Randomly gets an element from the list.
  /// Returns null if the list is empty.
  T? get random => isEmpty ? null : this[(Random().nextInt(length))];

  /// Safely gets an element from the list at the given [index].
  /// Returns null if the [index] is out of bounds.
  T? safeElementAt([int? index]) {
    if (index == null) return null;
    return (index >= 0 && index < length) ? this[index] : null;
  }

  /// Tries to find the first element in the list that matches the given [test].
  /// Returns null if no such element is found.
  T? firstWhereOrNull(bool Function(T) test) {
    for (T element in this) {
      if (test(element)) {
        return element;
      }
    }
    return null;
  }

  /// Shuffles the elements of the list into a random order.
  ///
  /// Example:
  /// ```dart
  /// var numbers = [1, 2, 3, 4];
  /// var shuffledNumbers = numbers.shuffled;
  /// print(shuffledNumbers); // Output might be [2, 4, 1, 3]
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
  /// var numbers = [1, 2, 3, 4, 5];
  /// var chunks = numbers.chunked(2);
  /// print(chunks); // Output: [[1, 2], [3, 4], [5]]
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
  /// var names = ['Alice', 'Bob', 'Charlie'];
  /// var firstLongName = names.firstWhereOrElse((name) => name.length > 4, 'No long names');
  /// print(firstLongName); // Output: "Alice"
  /// ```
  T firstWhereOrElse(bool Function(T) test, T orElse) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return orElse;
  }

  /// Adds an element to the list if it does not already contain it.
  void addIfNotContains(T element) {
    if (!contains(element)) {
      add(element);
    }
  }

  /// Removes the first element in the list that satisfies the given [test].
  /// Returns true if an element was removed, otherwise false.
  bool removeFirstWhere(bool Function(T) test) {
    for (T element in this) {
      if (test(element)) {
        remove(element);
        return true;
      }
    }
    return false;
  }

  /// Checks if the list is empty or only contains null values.
  bool get isEmptyOrNull => every((element) => element == null);

  /// Returns a new list with the elements in reverse order.
  List<T> get reversedList => reversed.toList();

  /// Converts each element in the list to another type using the [convert] function.
  /// Returns a new list containing the converted elements.
  List<E> mapToList<E>(E Function(T) convert) {
    return map(convert).toList();
  }

  /// Groups the elements in the list according to the [keyFunction].
  /// Returns a map where each key corresponds to a list of elements that share that key.
  Map<K, List<T>> groupBy<K>(K Function(T) keyFunction) {
    return fold(<K, List<T>>{}, (Map<K, List<T>> map, T element) {
      final K key = keyFunction(element);
      map.putIfAbsent(key, () => []).add(element);
      return map;
    });
  }

  /// Returns a new list containing only the unique elements from the original list.
  List<T> get unique => toSet().toList();
}

/// Common num list extensions
extension NumListExtensions on List<num> {
  /// Calculates the sum of all elements in the list.
  /// Returns the sum as a number.
  /// Example usage:
  /// ```dart
  /// [1, 2, 3].sum => 6
  /// ```
  num get sum => isEmpty ? 0 : reduce((value, element) => value + element);

  /// Calculates the average value of all elements in the list.
  /// Returns 0 if the list is empty to avoid division by zero.
  /// Otherwise, returns the sum of all elements divided by the count of elements.
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].average => 2.5
  /// ```
  num get average => isEmpty ? 0 : sum / length;
}

/// Common num list extensions
extension IntListExtensions on List<int> {
  /// Calculates the sum of all elements in the list.
  /// Returns the sum as a number.
  /// Example usage:
  /// ```dart
  /// [1, 2, 3].sum => 6
  /// ```
  int get sum => isEmpty ? 0 : reduce((value, element) => value + element);

  /// Calculates the average value of all elements in the list.
  /// Returns 0 if the list is empty to avoid division by zero.
  /// Otherwise, returns the sum of all elements divided by the count of elements.
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].average => 2.5
  /// ```
  double get average => isEmpty ? 0 : sum / length;
}

/// Common num list extensions
extension DoubleListExtensions on List<double> {
  /// Calculates the sum of all elements in the list.
  /// Returns the sum as a number.
  /// Example usage:
  /// ```dart
  /// [1, 2, 3].sum => 6
  /// ```
  double get sum => isEmpty ? 0 : reduce((value, element) => value + element);

  /// Calculates the average value of all elements in the list.
  /// Returns 0 if the list is empty to avoid division by zero.
  /// Otherwise, returns the sum of all elements divided by the count of elements.
  /// Example:
  /// ```dart
  /// [1, 2, 3, 4].average => 2.5
  /// ```
  double get average => isEmpty ? 0 : sum / length;
}
