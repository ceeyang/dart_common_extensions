part of '../dart_extensions.dart';

/// Num Conversion extensions
extension NumConversionExtensions on num {
  /// Attempts to convert the number to a [Decimal].
  ///
  /// Example:
  /// ```dart
  /// print(123.456.decimal); // Output: 123.456 (as a Decimal)
  /// ```
  Decimal get decimal => Decimal.tryParse(toString()) ?? Decimal.zero;

  /// Generates a list of integers from 0 up to (but not including) this integer.
  ///
  /// Example:
  /// ```dart
  /// print(5.toList); // Output: [0, 1, 2, 3, 4]
  /// ```
  List<int> get toList => List.generate(toInt(), (index) => index);

  /// Converts this number to a [DateTime] object based on the number of digits.
  ///
  /// Example:
  /// ```dart
  /// print(1609459200000.toDateTime); // Output: 2021-01-01 00:00:00.000
  /// ```
  DateTime get toDateTime {
    if (numberOfDigits == 10) {
      // Assuming seconds and converting to milliseconds
      return DateTime.fromMillisecondsSinceEpoch(toInt() * 1000);
    } else if (numberOfDigits == 13) {
      return DateTime.fromMillisecondsSinceEpoch(toInt()); // Assuming milliseconds
    } else if (numberOfDigits == 16) {
      return DateTime.fromMicrosecondsSinceEpoch(toInt()); // Assuming microseconds
    }
    return DateTime.utc(1970, 1,
        1); // Default to Unix Epoch time if the number of digits does not match any known timestamp format
  }

  /// Creates a [Duration] object representing a number of seconds.
  ///
  /// Example:
  /// ```dart
  /// print(60.secondsDuration); // Output: 0:01:00.000000
  /// ```
  Duration get secondsDuration => seconds;

  /// Creates a [Duration] object for milliseconds.
  ///
  /// Example:
  /// ```dart
  /// print(1500.millisecondsDuration); // Output: 0:00:01.500000
  /// ```
  Duration get millisecondsDuration => milliseconds;

  /// Creates a [Duration] object for microseconds.
  ///
  /// Example:
  /// ```dart
  /// print(1500000.microsecondsDuration); // Output: 0:00:01.500000
  /// ```
  Duration get microsecondsDuration => microseconds;

  /// Creates a [Duration] object for minutes.
  ///
  /// Example:
  /// ```dart
  /// print(1.minutesDuration); // Output: 0:01:00.000000
  /// ```
  Duration get minutesDuration => minutes;

  /// Creates a [Duration] object for hours.
  ///
  /// Example:
  /// ```dart
  /// print(1.hoursDuration); // Output: 1:00:00.000000
  /// ```
  Duration get hoursDuration => hours;

  /// Creates a [Duration] object for days.
  ///
  /// Example:
  /// ```dart
  /// print(1.daysDuration); // Output: 24:00:00.000000
  /// ```
  Duration get daysDuration => days;

  /// Returns a [Duration] representing this number in microseconds.
  Duration get microseconds => Duration(microseconds: toInt());

  /// Returns a [Duration] representing this number in milliseconds.
  Duration get milliseconds => Duration(microseconds: (this * 1000).toInt());

  /// Returns a [Duration] representing this number in seconds.
  Duration get seconds => Duration(microseconds: (this * 1000 * 1000).toInt());

  /// Returns a [Duration] representing this number in minutes.
  Duration get minutes => Duration(microseconds: (this * 1000 * 1000 * 60).toInt());

  /// Returns a [Duration] representing this number in hours.
  Duration get hours => Duration(microseconds: (this * 1000 * 1000 * 60 * 60).toInt());

  /// Returns a [Duration] representing this number in days.
  Duration get days => Duration(microseconds: (this * 1000 * 1000 * 60 * 60 * 24).toInt());
}

/// Num custom functions extensions
extension NumCustomFuncsExtensions on num {
  /// Checks if the number is even.
  ///
  /// Example:
  /// ```dart
  /// print(2.isEven); // true
  /// ```
  bool get isEven => this % 2 == 0;

  /// Checks if the number is odd.
  ///
  /// Example:
  /// ```dart
  /// print(3.isOdd); // true
  /// ```
  bool get isOdd => !isEven;

  /// Generates a random number between 0 and this number.
  /// If this number is an integer, the result is an integer.
  /// If this number is a double, the result is a double scaled by this value.
  ///
  /// Example:
  /// ```dart
  /// print(10.random); // random int 0-9
  /// ```
  num get random => this is int ? Random().nextInt(this as int) : Random().nextDouble() * this;

  /// Counts the number of digits in this number.
  ///
  /// Example:
  /// ```dart
  /// print(12345.numberOfDigits); // 5
  /// ```
  int get numberOfDigits => toString().length;

  /// Checks if the number is a prime number.
  ///
  /// Example:
  /// ```dart
  /// print(7.isPrime); // true
  /// ```
  bool get isPrime {
    if (this <= 1) return false;
    for (int i = 2; i <= sqrt(this); i++) {
      if (this % i == 0) return false;
    }
    return true;
  }

  /// Gets the absolute value of the integer.
  ///
  /// Example:
  /// ```dart
  /// print((-5).absolute); // 5
  /// ```
  int get absolute => toInt().abs();

  /// Causes the current Dart async function to wait for a given number of seconds.
  ///
  /// Example:
  /// ```dart
  /// await 5.secondsDelay(); // Waits for 5 seconds.
  /// ```
  Future<void> secondsDelay() => Future.delayed(secondsDuration);

  /// Causes the current Dart async function to wait for a given number of milliseconds.
  ///
  /// Example:
  /// ```dart
  /// await 500.millisecondsDelay(); // Waits for 500 milliseconds.
  /// ```
  Future<void> millisecondsDelay() => Future.delayed(millisecondsDuration);

  /// Causes the current Dart async function to wait for a given number of microseconds.
  ///
  /// Example:
  /// ```dart
  /// await 100000.microsecondsDelay(); // Waits for 100,000 microseconds.
  /// ```
  Future<void> microsecondsDelay() => Future.delayed(microsecondsDuration);
}

/// Num conversion to string extensions
extension NumToStringExtensions on num {
  /// Converts the number to a currency string format with an optional symbol prefix.
  ///
  /// Example:
  /// ```dart
  /// print(123456.78.toCurrency(symbol: '€')); // Outputs: €123,456.78
  /// ```
  String toCurrency({String symbol = '\$'}) => formatMoney(symbol: symbol);

  /// Formats the number as a money string with thousand separators and a specified number of decimal places.
  ///
  /// Example:
  /// ```dart
  /// print(1234.56.toMoney(decimalDigits: 1)); // 1,234.6
  /// ```
  String toMoney({int decimalDigits = 2}) => formatMoney(decimalDigits: decimalDigits);

  /// Formats the number as a money string with custom prefix, thousand separators and a specified number of decimal places.
  ///
  /// Example:
  /// ```dart
  /// print(1234.56.formatMoney(symbol: '¥', decimalDigits: 0)); // ¥1,235
  /// ```
  String formatMoney({String symbol = '', int decimalDigits = 2}) {
    final format = NumberFormat.currency(
      symbol: symbol,
      decimalDigits: decimalDigits,
      customPattern: '$symbol#,##0${decimalDigits > 0 ? '.${'0' * decimalDigits}' : ''}',
    );
    return format.format(this);
  }


  /// Converts the number to a binary (base-2) string representation.
  ///
  /// Example:
  /// ```dart
  /// print(10.toBinaryString); // Outputs: 1010
  /// ```
  String get toBinaryString => toInt().toRadixString(2);

  /// Converts the number to a hexadecimal (base-16) string representation.
  ///
  /// Example:
  /// ```dart
  /// print(255.toHexString); // Outputs: ff
  /// ```
  String get toHexString => toInt().toRadixString(16);

  /// Converts the number (bytes) to a human-readable file size string.
  ///
  /// Example:
  /// ```dart
  /// print(1024.toFileSize()); // Output: 1.00 KB
  /// ```
  String toFileSize({int decimals = 2}) {
    if (this <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(this) / log(1024)).floor();
    if (i == 0) return "${toInt()} B";
    return '${(this / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}

/// Num conversion operator extensions
extension OperatorExtension on num {
  /// Generates a list of numbers from the current number to [other], inclusive.
  ///
  /// Example:
  /// ```dart
  /// print(1.rangeTo(5)); // Outputs: [1, 2, 3, 4, 5]
  /// ```
  List<num> rangeTo(num other) => this <= other
      ? List.generate((other - this + 1).toInt(), (index) => this + index)
      : List.generate((this - other + 1).toInt(), (index) => this - index).reversed.toList();

  /// Calculates the sum of all numbers in the range from the current number to [other], inclusive.
  ///
  /// Example:
  /// ```dart
  /// print(1.sumTo(5)); // Outputs: 15 (1+2+3+4+5)
  /// ```
  num sumTo(num other) => rangeTo(other).reduce((value, element) => value + element);

  /// Raises the current number to the power of [exponent].
  ///
  /// Example:
  /// ```dart
  /// print(2.power(3)); // Outputs: 8 (2^3)
  /// ```
  num power(num exponent) => pow(this, exponent).toInt();

  /// Calculates the factorial of the integer.
  ///
  /// Example:
  /// ```dart
  /// print(5.factorial); // 120
  /// ```
  int get factorial => this == 0
      ? 1
      : List.generate(toInt(), (index) => index + 1).reduce((value, element) => value * element);
}

/// Extension for formatting [num] values as date/time strings assuming they are timestamps.
extension NumToDateTimeStringExtensions on num {
  /// Formats the current number as a date string in 'yyyy-MM-dd' format.
  ///
  /// Example:
  /// ```dart
  /// print(1609459200000.ymd); // 2021-01-01
  /// ```
  String get ymd => DateFormats.ymd.format(toDateTime);

  /// Formats the current number as a date string in 'dd-MM-yyyy' format.
  ///
  /// Example:
  /// ```dart
  /// print(1609459200000.dmy); // 01-01-2021
  /// ```
  String get dmy => DateFormats.dmy.format(toDateTime);

  /// Formats the current number as a date string in 'MM/dd/yyyy' format.
  ///
  /// Example:
  /// ```dart
  /// print(1609459200000.mdy); // 01/01/2021
  /// ```
  String get mdy => DateFormats.mdy.format(toDateTime);

  /// Formats the current number as a date string in 'yyyy-MM' format.
  String get yearMonth => DateFormats.yearMonth.format(toDateTime);

  /// Formats the current number as a date string in 'dd-MM' format.
  String get dayMonth => DateFormats.dayMonth.format(toDateTime);

  /// Formats the current number as a time string in 'HH:mm' format.
  String get hm => DateFormats.hm.format(toDateTime);

  /// Formats the current number as a time string in 'HH:mm:ss' format.
  String get hms => DateFormats.hms.format(toDateTime);

  /// Formats the current number as a date-time string in ISO 8601 format 'yyyy-MM-ddTHH:mm:ss'.
  String get iso8601 => DateFormats.iso8601.format(toDateTime);

  /// Formats the current number as a full date and time string in 'yyyy-MM-dd HH:mm:ss' format.
  String get fullDateTime => DateFormats.fullDateTime.format(toDateTime);

  /// Formats the current number as a full date and time string in 'dd-MM-yyyy HH:mm:ss' format.
  String get fullDateTimeDmy => DateFormats.fullDateTimeDmy.format(toDateTime);

  /// Formats the current number as a full date and time string in 'MM/dd/yyyy HH:mm:ss' format.
  String get fullDateTimeMdy => DateFormats.fullDateTimeMdy.format(toDateTime);

  /// Formats the current number as a full date and time string in 'dd/MM/yyyy HH:mm:ss' format.
  String get fullDateTimeDmY => DateFormats.fullDateTimeDmY.format(toDateTime);

  /// Formats the current number as a time string in 'HH:mm:ss' format.
  String get time => DateFormats.time.format(toDateTime);

  /// Formats the current number as a complete date-time string with timezone information in 'yyyy-MM-ddTHH:mm:ssZ' format.
  String get zonedDateTime => DateFormats.zonedDateTime.format(toDateTime);

  /// Formats the current number as a string only containing the month and year.
  String get monthYear => DateFormats.monthYear.format(toDateTime);

  /// Formats the current number as a short date string, which is locale dependent.
  String get shortDate => DateFormats.shortDate.format(toDateTime);

  /// Formats the current number as a long date string, which is locale dependent.
  String get longDate => DateFormats.longDate.format(toDateTime);
}
