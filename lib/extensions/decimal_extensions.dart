part of '../dart_extensions.dart';

/// Decimal money formatting extensions
extension DecimalMoneyExtensions on Decimal {
  /// Formats the [Decimal] as a money string with thousand separators and a specified number of decimal places.
  ///
  /// Example:
  /// ```dart
  /// print(Decimal.parse('1234.56').toMoney(decimalDigits: 1)); // 1,234.6
  /// ```
  String toMoney({int decimalDigits = 2}) => formatMoney(decimalDigits: decimalDigits);

  /// Formats the [Decimal] as a money string with custom prefix, thousand separators and a specified number of decimal places.
  ///
  /// Example:
  /// ```dart
  /// print(Decimal.parse('1234.56').formatMoney(symbol: '¥', decimalDigits: 0)); // ¥1,235
  /// ```
  String formatMoney({String symbol = '', int decimalDigits = 2}) {
    // Convert Decimal to double for NumberFormat (as NumberFormat works with num)
    // Note: This may lose precision for extremely large numbers,
    // but typically sufficient for money formatting.
    final value = toDouble();
    final format = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: '$symbol#,##0${decimalDigits > 0 ? ".${"0" * decimalDigits}" : ""}',
    );
    return format.format(value);
  }
}
