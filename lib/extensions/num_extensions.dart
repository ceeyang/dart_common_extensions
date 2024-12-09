part of '../dart_extensions.dart';

/// Num Conversion extensions
extension NumConversionExtensions on num {
  /// Attempts to convert the number to a [Decimal].
  ///
  /// Example:
  /// ```dart
  /// print(123.456.decimal); // Output: 123.456 (as a Decimal)
  /// print('abc'.decimal);   // Output: null
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
  /// print(1609459200000.toDateTime); // Output: 2021-01-01 00:00:00.000 (assuming milliseconds)
  /// print(1609459200000000.toDateTime); // Output: 2021-01-01 00:00:00.000 (assuming microseconds)
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
  Duration get secondsDuration => Duration(seconds: toInt());

  /// Creates a [Duration] object for milliseconds.
  ///
  /// Example:
  /// ```dart
  /// print(1500.millisecondsDuration); // Output: 0:00:01.500000
  /// ```
  Duration get millisecondsDuration => Duration(milliseconds: toInt());

  /// Creates a [Duration] object for microseconds.
  ///
  /// Example:
  /// ```dart
  /// print(1500000.microsecondsDuration); // Output: 0:00:01.500000
  /// ```
  Duration get microsecondsDuration => Duration(microseconds: toInt());

  /// Creates a [Duration] object for minutes.
  ///
  /// Example:
  /// ```dart
  /// print(1.minutesDuration); // Output: 0:01:00.000000
  /// ```
  Duration get minutesDuration => Duration(minutes: toInt());

  /// Creates a [Duration] object for hours.
  ///
  /// Example:
  /// ```dart
  /// print(1.hoursDuration); // Output: 1:00:00.000000
  /// ```
  Duration get hoursDuration => Duration(hours: toInt());

  /// Creates a [Duration] object for days.
  ///
  /// Example:
  /// ```dart
  /// print(1.daysDuration); // Output: 24:00:00.000000
  /// ```
  Duration get daysDuration => Duration(days: toInt());
}

/// Num custom functions extensions
extension NumCustomFuncsExtensions on num {
  /// Checks if the number is even.
  /// Returns true if the number is evenly divisible by 2, otherwise false.
  bool get isEven => this % 2 == 0;

  /// Checks if the number is odd.
  /// Returns true if the number is not evenly divisible by 2, otherwise false.
  bool get isOdd => !isEven;

  /// Generates a random number between 0 and this number.
  /// If this number is an integer, the result is an integer.
  /// If this number is a double, the result is a double scaled by this value.
  num get random => this is int ? Random().nextInt(this as int) : Random().nextDouble() * this;

  /// Counts the number of digits in this number.
  /// For example, calling this on 12345 would return 5.
  int get numberOfDigits => toString().length;

  /// Checks if the number is a prime number.
  /// A prime number is a natural number greater than 1 that cannot be formed
  /// by multiplying two smaller natural numbers.
  /// Returns true if the number is prime, otherwise false.
  bool get isPrime {
    if (this <= 1) return false;
    for (int i = 2; i <= sqrt(this); i++) {
      if (this % i == 0) return false;
    }
    return true;
  }

  /// Gets the absolute value of the integer.
  ///
  /// The absolute value is defined as the magnitude of a number regardless of its sign. For example,
  /// the absolute values of both -5 and 5 are 5.
  ///
  /// Returns the absolute value of the integer.
  int get absolute => toInt().abs();

  /// Causes the current Dart async function to wait for a given number of seconds.
  ///
  /// This extension method utilizes [Future.delayed] to introduce a delay
  /// in the execution flow. The duration of the delay is specified by the integer
  /// value of the calling object, representing the number of seconds.
  ///
  /// Example:
  /// ```
  /// await 5.secondsDelay(); // Waits for 5 seconds.
  /// ```
  Future<void> secondsDelay() => Future.delayed(secondsDuration);

  /// Causes the current Dart async function to wait for a given number of milliseconds.
  ///
  /// This method provides a mechanism for delaying execution by a specific duration
  /// defined in milliseconds. It leverages [Future.delayed] with the duration
  /// specified by the caller's integer value.
  ///
  /// Example:
  /// ```
  /// await 500.millisecondsDelay(); // Waits for 500 milliseconds.
  /// ```
  Future<void> millisecondsDelay() => Future.delayed(millisecondsDuration);

  /// Causes the current Dart async function to wait for a given number of microseconds.
  ///
  /// By employing [Future.delayed], this method introduces a delay in the execution
  /// flow for a duration specified in microseconds. The delay duration is determined
  /// by the integer value of the calling object.
  ///
  /// Note: The actual resolution of the delay might not be precise to the microsecond
  /// due to the limitations of the underlying system's timer resolution.
  ///
  /// Example:
  /// ```
  /// await 100000.microsecondsDelay(); // Waits for 100,000 microseconds.
  /// ```
  Future<void> microsecondsDelay() => Future.delayed(microsecondsDuration);
}

/// Num conversion to string extensions
extension NumToStringExtensions on num {
  /// Converts the number to a currency string format with an optional symbol prefix.
  ///
  /// The method formats the number according to the specified locale ('en_US' by default)
  /// and adds a currency symbol (defaults to '$') before the number. The resulting string
  /// is formatted with two decimal places.
  ///
  /// Parameters:
  ///   - [symbol] (optional): The currency symbol to prepend to the formatted number string.
  ///     Defaults to the dollar sign ('$').
  ///
  /// Returns:
  ///   A string representation of the number in currency format, including the specified
  ///   currency symbol.
  ///
  /// Example:
  /// ```
  /// print(123456.78.toCurrency(symbol: '€')); // Outputs: €123,456.78
  /// ```
  String toCurrency({String symbol = '\$'}) =>
      '$symbol${NumberFormat('#,##0.00', 'en_US').format(this)}';

  /// Converts the number to a binary (base-2) string representation.
  ///
  /// This method first converts the number to an integer using [toInt], then
  /// generates a binary string representation of that integer.
  ///
  /// Returns:
  ///   A string representing the binary representation of the number.
  ///
  /// Example:
  /// ```
  /// print(10.toBinaryString); // Outputs: 1010
  /// ```
  String get toBinaryString => toInt().toRadixString(2);

  /// Converts the number to a hexadecimal (base-16) string representation.
  ///
  /// Similar to [toBinaryString], this method first converts the number to an integer,
  /// then generates a hexadecimal string representation of that integer.
  ///
  /// Returns:
  ///   A string representing the hexadecimal representation of the number.
  ///
  /// Example:
  /// ```
  /// print(255.toHexString); // Outputs: ff
  /// ```
  String get toHexString => toInt().toRadixString(16);
}

/// Num conversion operator extensions
extension OperatorExtension on num {
  /// Generates a list of numbers from the current number to [other], inclusive.
  ///
  /// If [other] is greater than the current number, the list is generated in ascending order.
  /// If [other] is less than the current number, the list is generated in descending order.
  /// The method accounts for both integer and decimal numbers by rounding the generated
  /// range's length to the nearest integer.
  ///
  /// Parameters:
  ///   - [other]: The end point of the range.
  ///
  /// Returns:
  ///   A list of numbers starting from the current number to [other], inclusive.
  ///
  /// Example:
  /// ```
  /// print(1.rangeTo(5)); // Outputs: [1, 2, 3, 4, 5]
  /// print(5.rangeTo(1)); // Outputs: [5, 4, 3, 2, 1]
  /// ```
  List<num> rangeTo(num other) => this <= other
      ? List.generate((other - this + 1).toInt(), (index) => this + index)
      : List.generate((this - other + 1).toInt(), (index) => this - index).reversed.toList();

  /// Calculates the sum of all numbers in the range from the current number to [other], inclusive.
  ///
  /// This method leverages [rangeTo] to generate the range and then reduces it by summing
  /// all elements.
  ///
  /// Parameters:
  ///   - [other]: The end point of the range to sum to.
  ///
  /// Returns:
  ///   The sum of all numbers from the current number to [other].
  ///
  /// Example:
  /// ```
  /// print(1.sumTo(5)); // Outputs: 15 (1+2+3+4+5)
  /// ```
  num sumTo(num other) => rangeTo(other).reduce((value, element) => value + element);

  /// Raises the current number to the power of [exponent].
  ///
  /// This method calculates the current number raised to the specified [exponent].
  /// The result is converted to an integer.
  ///
  /// Parameters:
  ///   - [exponent]: The exponent to raise the current number to.
  ///
  /// Returns:
  ///   The current number raised to the power of [exponent], converted to an integer.
  ///
  /// Example:
  /// ```
  /// print(2.power(3)); // Outputs: 8 (2^3)
  /// ```
  num power(num exponent) => pow(this, exponent).toInt();

  /// Calculates the factorial of the integer.
  ///
  /// The factorial is defined as the product of all positive integers up to and including the integer itself.
  /// By definition, the factorial of 0 is 1, which serves as the base case for this recursive relationship.
  ///
  /// Returns the factorial value. Note that due to using the `int` type, the result may be subject to
  /// integer overflow limitations, especially with larger numbers.
  int get factorial => this == 0
      ? 1
      : List.generate(toInt(), (index) => index + 1).reduce((value, element) => value * element);
}

extension NumToDateTimeStringExtensions on num {
  /// Formats the current number as a date string in 'yyyy-MM-dd' format.
  ///
  /// Returns a string representation of the date in 'yyyy-MM-dd' format.
  String get ymd => DateFormats.ymd.format(toDateTime);

  /// Formats the current number as a date string in 'dd-MM-yyyy' format.
  ///
  /// Returns a string representation of the date in 'dd-MM-yyyy' format.
  String get dmy => DateFormats.dmy.format(toDateTime);

  /// Formats the current number as a date string in 'MM/dd/yyyy' format.
  ///
  /// Returns a string representation of the date in 'MM/dd/yyyy' format.
  String get mdy => DateFormats.mdy.format(toDateTime);

  /// Formats the current number as a date string in 'yyyy-MM' format.
  ///
  /// Returns a string representation of the date in 'yyyy-MM' format.
  String get yearMonth => DateFormats.yearMonth.format(toDateTime);

  /// Formats the current number as a date string in 'dd-MM' format.
  ///
  /// Returns a string representation of the date in 'dd-MM' format.
  String get dayMonth => DateFormats.dayMonth.format(toDateTime);

  /// Formats the current number as a time string in 'HH:mm' format.
  ///
  /// Returns a string representation of the time in 'HH:mm' format.
  String get hm => DateFormats.hm.format(toDateTime);

  /// Formats the current number as a time string in 'HH:mm:ss' format.
  ///
  /// Returns a string representation of the time in 'HH:mm:ss' format.
  String get hms => DateFormats.hms.format(toDateTime);

  /// Formats the current number as a date-time string in ISO 8601 format 'yyyy-MM-ddTHH:mm:ss'.
  ///
  /// Returns a string representation of the date and time in ISO 8601 format.
  String get iso8601 => DateFormats.iso8601.format(toDateTime);

  /// Formats the current number as a full date and time string in 'yyyy-MM-dd HH:mm:ss' format.
  ///
  /// Returns a string representation of the full date and time in 'yyyy-MM-dd HH:mm:ss' format.
  String get fullDateTime => DateFormats.fullDateTime.format(toDateTime);

  /// Formats the current number as a full date and time string in 'dd-MM-yyyy HH:mm:ss' format.
  ///
  /// Returns a string representation of the full date and time in 'dd-MM-yyyy HH:mm:ss' format.
  String get fullDateTimeDmy => DateFormats.fullDateTimeDmy.format(toDateTime);

  /// Formats the current number as a full date and time string in 'MM/dd/yyyy HH:mm:ss' format.
  ///
  /// Returns a string representation of the full date and time in 'MM/dd/yyyy HH:mm:ss' format.
  String get fullDateTimeMdy => DateFormats.fullDateTimeMdy.format(toDateTime);

  /// Formats the current number as a full date and time string in 'dd/MM/yyyy HH:mm:ss' format.
  ///
  /// Returns a string representation of the full date and time in 'dd/MM/yyyy HH:mm:ss' format.
  String get fullDateTimeDmY => DateFormats.fullDateTimeDmY.format(toDateTime);

  /// Formats the current number as a time string in 'HH:mm:ss' format.
  ///
  /// Returns a string representation of the time in 'HH:mm:ss' format.
  String get time => DateFormats.time.format(toDateTime);

  /// Formats the current number as a complete date-time string with timezone information in 'yyyy-MM-ddTHH:mm:ssZ' format.
  ///
  /// Returns a string representation of the complete date and time with timezone information.
  String get zonedDateTime => DateFormats.zonedDateTime.format(toDateTime);

  /// Formats the current number as a string only containing the month and year.
  ///
  /// Returns a string representation of the month and year.
  String get monthYear => DateFormats.monthYear.format(toDateTime);

  /// Formats the current number as a short date string, which is locale dependent.
  ///
  /// Returns a string representation of the short date, which is locale dependent.
  String get shortDate => DateFormats.shortDate.format(toDateTime);

  /// Formats the current number as a long date string, which is locale dependent.
  ///
  /// Returns a string representation of the long date, which is locale dependent.
  String get longDate => DateFormats.longDate.format(toDateTime);
}
