part of '../dart_extensions.dart';

/// String common type conversions extensions
extension StringConversionExtensions on String {
  /// Converts the string to an integer. Returns null if the conversion fails.
  ///
  /// Example:
  /// ```dart
  /// print('12'.toInt); // Output: 12
  /// print('12.34'.toInt); // Output: 12 (truncated conversion)
  /// print('abc'.toInt); // Output: 0
  /// ```
  int get toInt => toNum.toInt();

  /// Converts the string to a double. Returns null if the conversion fails.
  ///
  /// Example:
  /// ```dart
  /// print('12.34'.toDouble); // Output: 12.34
  /// print('abc'.toDouble); // Output: 0.00
  /// ```
  double get toDouble => toNum.toDouble();

  /// Converts the string to a num (which can be either int or double).
  /// Returns null if the conversion fails.
  ///
  /// Example:
  /// ```dart
  /// print('123'.toNum); // Output: 123
  /// print('123.45'.toNum); // Output: 123.45
  /// print('abc'.toNum); // Output: 0
  /// ```
  num get toNum => num.tryParse(this) ?? 0;

  /// Converts the string to a Decimal. Returns null if the conversion fails.
  /// Requires the `decimal` package.
  ///
  /// Example:
  /// ```dart
  /// print('123.45'.toDecimal); // Output: Decimal(123.45) assuming decimal is implemented
  /// print('abc'.toDecimal); // Output: 0
  /// ```
  Decimal get toDecimal => Decimal.tryParse(this) ?? Decimal.zero;

  /// Attempts to parse the string into a DateTime object.
  /// Returns null if the parsing fails.
  ///
  /// Example:
  /// ```dart
  /// print('2023-01-01'.toDate); // Output: Instance of 'DateTime' for 2023-01-01
  /// print('1643723400'.toDate); // Output: Instance of 'DateTime' for 2022-02-01
  /// print('abc'.toDate); // Output: Instance of 'DateTime' for 1970-01-01 00:00:00 GMT
  /// ```
  DateTime get toDate => toDateTime;
  DateTime get toDateTime {
    try {
      if (isEmpty) return DateTime.utc(1970, 1, 1);

      // 尝试解析时间戳
      if (isNumeric) {
        final num = int.tryParse(this);
        if (num != null) return num.toDateTime;
      }

      // 尝试解析日期字符串
      final date = DateTime.tryParse(this);
      if (date != null) return date;

      return DateTime.utc(1970, 1, 1);
    } catch (e) {
      return DateTime.utc(1970, 1, 1);
    }
  }

  /// Converts the string to a Uri object. Returns null if the conversion fails or the URL is invalid.
  DateTime get utc1970 => DateTime.utc(1970, 1, 1);

  /// Converts the string to a Uri object. Returns null if the conversion fails or the URL is invalid.
  ///
  /// Example:
  /// ```dart
  /// print('https://example.com'.toUri); // Output: Instance of 'Uri'
  /// print('abc'.toUri); // Output: null
  /// ```
  Uri? get toUri => isValidUrl ? Uri.tryParse(this) : null;

  /// Attempts to convert the string to a boolean value. Supports "true" and "false", case-insensitive.
  ///
  /// Example:
  /// ```dart
  /// print('true'.toBool); // Output: true
  /// print('False'.toBool); // Output: false
  /// print('abc'.toBool); // Output: false
  /// ```
  bool get toBool => bool.tryParse(this) ?? false;

  /// Attempts to decode the string as a JSON object. Returns null if decoding fails.
  ///
  /// Example:
  /// ```dart
  /// print('{"key": "value"}'.toJson); // Output: {key: value}
  /// print('abc'.toJson); // Output: null
  /// ```
  dynamic get toJson {
    try {
      return json.decode(this);
    } catch (e) {
      return null;
    }
  }

  /// Attempts to decode the string as a List<dynamic> from JSON. Returns an empty list if decoding fails.
  ///
  /// Example:
  /// ```dart
  /// print('["a", "b", "c"]'.toList); // Output: [a, b, c]
  /// print('abc'.toList); // Output: []
  /// ```
  List<dynamic> get toList {
    try {
      return json.decode(this) as List<dynamic>;
    } catch (e) {
      return [];
    }
  }

  /// Converts a comma-separated string into a List<int>. Fails silently for non-numeric parts.
  ///
  /// Example:
  /// ```dart
  /// print('1,2,3'.toIntList); // Output: [1, 2, 3]
  /// print('1,a,3'.toIntList); // Output: [1, 3]
  /// ```
  List<int> get toIntList =>
      split(',').map((s) => int.tryParse(s)).where((i) => i != null).cast<int>().toList();

  /// Converts a comma-separated string into a List<double>. Fails silently for non-numeric parts.
  ///
  /// Example:
  /// ```dart
  /// print('1.0,2.0,3.0'.toDoubleList); // Output: [1.0, 2.0, 3.0]
  /// print('1.0,a,3.0'.toDoubleList); // Output: [1.0, 3.0]
  /// ```
  List<double> get toDoubleList =>
      split(',').map((s) => double.tryParse(s)).where((i) => i != null).cast<double>().toList();
}

/// String encoding processing extensions
extension StringEncodeExtensions on String {
  /// Encodes the string into a base64 encoded string.
  /// Useful for encoding data that needs to be stored or transferred as plain text.
  ///
  /// Example usage:
  /// ```dart
  /// print('Hello World'.base64Encoded); // Output: 'SGVsbG8gV29ybGQ='
  /// ```
  String get base64Encoded => base64Encode(utf8.encode(this));

  /// Decodes a base64 encoded string back into a regular string.
  /// This is the inverse operation of base64 encoding.
  ///
  /// Example usage:
  /// ```dart
  /// print('SGVsbG8gV29ybGQ='.base64Decoded); // Output: 'Hello World'
  /// ```
  String get base64Decoded => utf8.decode(base64.decode(this));

  /// Encodes the string as a URL component, making it safe to include in a URL query.
  /// It percent-encodes reserved characters, such as spaces.
  ///
  /// Example usage:
  /// ```dart
  /// print('Hello World'.urlEncoded); // Output: 'Hello%20World'
  /// ```
  String get urlEncoded => Uri.encodeComponent(this);

  /// Decodes a URL-encoded string back into a regular string.
  /// This is the inverse operation of URL encoding.
  ///
  /// Example usage:
  /// ```dart
  /// print('Hello%20World'.urlDecoded); // Output: 'Hello World'
  /// ```
  String get urlDecoded => Uri.decodeComponent(this);
}

/// String format extensions
extension StringFormatExtensions on String {
  /// Checks if the string is either null, empty, or contains only whitespace characters.
  /// This is useful for validating input fields where a meaningful string is required.
  ///
  /// Example:
  /// ```dart
  /// print('   '.isNullOrWhiteSpace); // Output: true
  /// print('word'.isNullOrWhiteSpace); // Output: false
  /// ```
  bool get isNullOrWhiteSpace => trim().isEmpty;

  /// Determines whether the string consists solely of numeric characters (0-9).
  /// This can be used to validate if a string represents a valid integer.
  ///
  /// Example:
  /// ```dart
  /// print('1234'.isNumeric); // Output: true
  /// print('12a4'.isNumeric); // Output: false
  /// ```
  bool get isNumeric => RegExp(r'^\d+$').hasMatch(this);

  /// Checks if the string contains only English alphabet characters (A-Z, a-z).
  /// This can be useful for validating names or words that should not include numbers or symbols.
  ///
  /// Example:
  /// ```dart
  /// print('Hello'.isEnglish); // Output: true
  /// print('Hello123'.isEnglish); // Output: false
  /// ```
  bool get isEnglish => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Verifies that the string is composed entirely of Chinese characters.
  /// It can be used for validating input meant to be in Chinese without any foreign characters.
  ///
  /// Example:
  /// ```dart
  /// print('你好'.isChinese); // Output: true
  /// print('Hello你好'.isChinese); // Output: false
  /// ```
  bool get isChinese => RegExp(r'^[\u4e00-\u9fa5]+$').hasMatch(this);

  /// Determines if the string is a valid Chinese mobile phone number based on the pattern.
  ///
  /// Example:
  /// ```dart
  /// print('13912345678'.isChineseMobile); // Output: true
  /// print('10086'.isChineseMobile); // Output: false
  /// ```
  bool get isChineseMobile => RegExp(r'^1[3-9]\d{9}$').hasMatch(this);

  /// Checks if the string is in a valid email format.
  ///
  /// Example:
  /// ```dart
  /// print('user@example.com'.isEmail); // Output: true
  /// print('user@example'.isEmail); // Output: false
  /// ```
  bool get isEmail => RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(this);

  /// Determines whether the string is a valid URL.
  ///
  /// Example:
  /// ```dart
  /// print('https://example.com'.isValidUrl); // Output: true
  /// print('example.com'.isValidUrl); // Output: false
  /// ```
  bool get isValidUrl => RegExp(r'^(https?:\/\/)?'
          r'([\w-]+(\.[\w-]+)+)'
          r'([\/\w -]*)'
          r'(\?[\w- ;,./?%&=]*)?'
          r'(#[\w-]*)?$')
      .hasMatch(this);

  /// Checks if the string is a valid hexadecimal number.
  ///
  /// Example:
  /// ```dart
  /// print('AFFE'.isValidHex); // Output: true
  /// print('GHIJK'.isValidHex); // Output: false
  /// ```
  bool get isValidHex => RegExp(r'^[0-9A-Fa-f]+$').hasMatch(this);
}

/// String common function extensions
extension StringCustomFunctionExtensions on String {
  /// Returns a provided alternative string [val] if the original string is empty.
  /// If [val] is null, it defaults to an empty string.
  ///
  /// Example:
  /// ```dart
  /// print(''.onEmpty('default')); // Output: 'default'
  /// print('text'.onEmpty('default')); // Output: 'text'
  /// ```
  String? onEmpty(String? val) => isEmpty ? (val ?? '') : this;

  /// Tries to parse the string into a specified enum type [T].
  /// Returns null if the parsing fails. This method requires the list of all enum values
  /// [enumValues] to check against.
  ///
  /// Example:
  /// ```dart
  /// enum Colors { red, green, blue }
  /// print('green'.toEnum(Colors.values)); // Output: Colors.green
  /// print('purple'.toEnum(Colors.values)); // Output: null
  /// ```
  T? toEnum<T>(List<T> enumValues) => enumValues
      .firstWhereOrNull((e) => e.toString().split('.').last == this || e.toString() == this);

  /// Capitalizes the first letter of the string.
  /// Returns the original string if it is empty.
  ///
  /// Example:
  /// ```dart
  /// print('hello'.capitalize); // Output: 'Hello'
  /// ```
  String get capitalize => isNotEmpty ? '${this[0].toUpperCase()}${substring(1)}' : '';

  /// Removes all spaces from the string.
  ///
  /// Example:
  /// ```dart
  /// print('Hello World'.removeAllSpaces); // Output: 'HelloWorld'
  /// ```
  String get removeAllSpaces => replaceAll(' ', '');

  /// Reverses the string.
  ///
  /// Example:
  /// ```dart
  /// print('hello'.reversed); // Output: 'olleh'
  /// ```
  String get reversed => String.fromCharCodes(runes.toList().reversed);

  /// Replaces the first occurrence of the substring [from] with [replace].
  /// If [from] is not found in the string, returns the original string.
  ///
  /// Example:
  /// ```dart
  /// print('Hello World'.replaceFirst('World', 'There')); // Output: 'Hello There'
  /// ```
  String replaceFirst(String from, String replace) {
    int pos = indexOf(from);
    return pos < 0 ? this : '${substring(0, pos)}$replace${substring(pos + from.length)}';
  }

  /// Replaces the last occurrence of the substring [from] with [to].
  /// If [from] is not found in the string, returns the original string.
  ///
  /// Example:
  /// ```dart
  /// print('Hello World World'.replaceLast('World', 'There')); // Output: 'Hello World There'
  /// ```
  String replaceLast(String from, String to) {
    int lastAsteriskIndex = lastIndexOf(from);
    if (lastAsteriskIndex != -1) {
      return substring(0, lastAsteriskIndex) + to + substring(lastAsteriskIndex + 1);
    } else {
      return this;
    }
  }

  /// Inserts the string [str] at the specified [index] within the original string.
  /// Throws [RangeError] if [index] is out of bounds.
  ///
  /// Example:
  /// ```dart
  /// print('Hello World'.insert(6, 'Beautiful ')); // Output: 'Hello Beautiful World'
  /// ```
  String insert(int index, String str) {
    if (index < 0 || index > length) {
      throw RangeError('Index out of bounds');
    }
    return '${substring(0, index)}$str${substring(index)}';
  }

  /// Repeats the string [times] number of times.
  ///
  /// Example:
  /// ```dart
  /// print('abc'.repeat(3)); // Output: 'abcabcabc'
  /// ```
  String repeat(int times) => List.filled(times, this).join();

  /// 安全地截取字符串，如果字符串长度不够，则返回原字符串。
  ///
  /// 例如：
  /// ```dart
  /// '12345678'.safeSubString(0, 20); // '12345678'
  /// ```
  String safeSubstring(int startIndex, int endIndex) {
    if (startIndex < 0) startIndex = 0;
    if (endIndex > length) endIndex = length;
    return substring(startIndex, endIndex);
  }
}

extension StringToDateTimeStringExtensions on String {
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
