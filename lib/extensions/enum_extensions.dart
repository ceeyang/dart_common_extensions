part of '../dart_extensions.dart';

/// Common Enum extensions
extension EnumExtensions on Enum {
  /// Returns the next enum value in a cyclic manner.
  ///
  /// Example:
  /// ```dart
  /// enum Status { active, inactive }
  /// print(Status.active.next(Status.values)); // Status.inactive
  /// ```
  T next<T extends Enum>(List<T> values) {
    return values[(index + 1) % values.length];
  }

  /// Returns the previous enum value in a cyclic manner.
  ///
  /// Example:
  /// ```dart
  /// enum Status { active, inactive }
  /// print(Status.active.previous(Status.values)); // Status.inactive
  /// ```
  T previous<T extends Enum>(List<T> values) {
    return values[(index - 1 + values.length) % values.length];
  }
}
