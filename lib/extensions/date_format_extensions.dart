part of '../dart_extensions.dart';

/// Extension on [DateFormat] to provide easy access to common date formats.
/// Dart expands static variables and needs to be called with the extended name
///
/// example:
/// ```dart
/// DateFormats.ymd
/// ```
///
extension DateFormats on DateFormat {
  /// Provides a [DateFormat] instance for "yyyy-MM-dd" format.
  static DateFormat get ymd => DateFormat('yyyy-MM-dd');

  /// Provides a [DateFormat] instance for "dd-MM-yyyy" format.
  static DateFormat get dmy => DateFormat('dd-MM-yyyy');

  /// Provides a [DateFormat] instance for "MM/dd/yyyy" format, commonly used in the US.
  static DateFormat get mdy => DateFormat('MM/dd/yyyy');

  /// Provides a [DateFormat] instance for ISO 8601 standard format "yyyy-MM-ddTHH:mm:ss".
  static DateFormat get iso8601 => DateFormat('yyyy-MM-ddTHH:mm:ss');

  /// Provides a [DateFormat] instance for full date and time format "yyyy-MM-dd HH:mm:ss".
  static DateFormat get fullDateTime => DateFormat('yyyy-MM-dd HH:mm:ss');

  /// Provides a [DateFormat] instance for time format "HH:mm:ss".
  static DateFormat get time => DateFormat('HH:mm:ss');

  /// Provides a [DateFormat] instance for a complete date-time format with timezone information "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'".
  static DateFormat get zonedDateTime => DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");

  /// Provides a [DateFormat] instance for a format including only the month and year "MMMM yyyy".
  static DateFormat get monthYear => DateFormat('MMMM yyyy');

  /// Provides a [DateFormat] instance for short date format, which is locale dependent.
  static DateFormat get shortDate => DateFormat.yMd();

  /// Provides a [DateFormat] instance for long date format, which is locale dependent.
  static DateFormat get longDate => DateFormat.yMMMMd();
}