part of '../dart_extensions.dart';

/// Common Map extensions
extension MapExtensions<K, V> on Map<K, V> {
  /// Retrieves the value for the specified [key] from the map.
  /// If the key does not exist, returns the provided [defaultValue].
  ///
  /// Example:
  /// ```dart
  /// var map = {'first': 1, 'second': 2};
  /// print(map.getOrDefault('third', 0)); // Output: 0
  /// ```
  V? getOrDefault(K key, V defaultValue) {
    return containsKey(key) ? this[key] : defaultValue;
  }

  /// Retrieves the value for the specified [key] from the map.
  /// If the key does not exist, returns null.
  ///
  /// Example:
  /// ```dart
  /// var map = {'first': 1, 'second': 2};
  /// print(map.getOrNull('third')); // Output: null
  /// ```
  V? getOrNull(K key) {
    return containsKey(key) ? this[key] : null;
  }

  /// Converts the map to a JSON string.
  ///
  /// Example:
  /// ```dart
  /// var map = {'name': 'John', 'age': 30};
  /// print(map.toJsonString()); // Output: '{"name":"John","age":30}'
  /// ```
  String toJsonString() {
    return jsonEncode(this);
  }

  /// Converts the map to a formatted JSON string, with specified indentation.
  ///
  /// Example:
  /// ```dart
  /// var map = {'name': 'John', 'age': 30};
  /// print(map.toJsonStringWithIndent()); // Output: formatted JSON string
  /// ```
  String toJsonStringWithIndent([int spaces = 2]) {
    return JsonEncoder.withIndent(' ' * spaces).convert(this);
  }

  /// Inverts the map by swapping its keys and values. Assumes that the values are unique.
  ///
  /// Example:
  /// ```dart
  /// var map = {'first': 'John', 'second': 'Doe'};
  /// print(map.invert()); // Output: {'John': 'first', 'Doe': 'second'}
  /// ```
  Map<V, K> invert() => map((key, value) => MapEntry(value, key));

  /// Filters the map based on a condition applied to its keys.
  ///
  /// Example:
  /// ```dart
  /// var map = {'first': 1, 'second': 2, 'third': 3};
  /// print(map.filterKeys((key) => key.startsWith('f'))); // Output: {'first': 1}
  /// ```
  Map<K, V> filterKeys(bool Function(K key) predicate) =>
      Map.fromEntries(entries.where((entry) => predicate(entry.key)));

  /// Filters the map based on a condition applied to its values.
  ///
  /// Example:
  /// ```dart
  /// var map = {'first': 1, 'second': 2, 'third': 3};
  /// print(map.filterValues((value) => value > 1)); // Output: {'second': 2, 'third': 3}
  /// ```
  Map<K, V> filterValues(bool Function(V value) predicate) =>
      Map.fromEntries(entries.where((entry) => predicate(entry.value)));

  /// Merges this map with another [other] map. For duplicate keys, [resolve] determines the final value.
  ///
  /// Example:
  /// ```dart
  /// var map1 = {'first': 1, 'second': 2};
  /// var map2 = {'second': 3, 'third': 4};
  /// print(map1.merge(map2, (v1, v2) => v1 + v2)); // Output: {'first': 1, 'second': 5, 'third': 4}
  /// ```
  Map<K, V> merge(Map<K, V> other, V Function(V v1, V v2)? resolve) {
    final Map<K, V> result = Map<K, V>.from(this);
    other.forEach((key, value) {
      if (result.containsKey(key) && resolve != null) {
        result[key] = resolve.call(result[key] as V, value);
      } else {
        result[key] = value;
      }
    });
    return result;
  }
}
