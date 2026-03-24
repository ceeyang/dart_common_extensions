part of '../dart_extensions.dart';

/// Extension methods for [Object] to provide common utility functions.
extension ObjectExtensions<T extends Object> on T {
  /// Calls the specified function [f] with as its argument and returns the result.
  ///
  /// Example:
  /// ```dart
  /// int? result = 'hello'.let((s) => s.length); // result = 5
  /// ```
  R let<R>(R Function(T) f) => f(this);

  /// Calls the specified function [f] with as its argument and returns [this].
  ///
  /// Example:
  /// ```dart
  /// var user = User().also((u) => u.name = 'John');
  /// ```
  T also(void Function(T) f) {
    f(this);
    return this;
  }
}

/// Extension methods for nullable [Object]
extension NullableObjectExtensions<T extends Object> on T? {
  /// Returns [true] if this object is null.
  ///
  /// Example:
  /// ```dart
  /// String? name;
  /// print(name.isNull); // true
  /// ```
  bool get isNull => this == null;

  /// Returns [true] if this object is not null.
  ///
  /// Example:
  /// ```dart
  /// String? name = 'John';
  /// print(name.isNotNull); // true
  /// ```
  bool get isNotNull => this != null;
}
