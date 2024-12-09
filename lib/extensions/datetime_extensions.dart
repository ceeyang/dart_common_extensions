part of '../dart_extensions.dart';

/// DateTime common extensions
extension DateTimeExtensions on DateTime {
  /// Returns the start of the day for this DateTime object.
  ///
  /// Example:
  /// ```dart
  /// var now = DateTime.now();
  /// var start = now.startOfDay;
  /// print(start); // Output: "YYYY-MM-DD 00:00:00.000"
  /// ```
  DateTime get startOfDay => DateTime(year, month, day);

  /// Returns the end of the day for this DateTime object.
  ///
  /// Example:
  /// ```dart
  /// var now = DateTime.now();
  /// var end = now.endOfDay;
  /// print(end); // Output: "YYYY-MM-DD 23:59:59.999"
  /// ```
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59, 999, 999);

  /// Determines whether two `DateTime` objects are on the same day.
  ///
  /// Example:
  /// ```dart
  /// var date1 = DateTime(2023, 1, 1);
  /// var date2 = DateTime(2023, 1, 1, 23, 59, 59);
  /// print(date1.isSameDay(date2)); // Output: true
  /// ```
  bool isSameDay(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }

  /// Adds a specified number of business days, skipping weekends.
  ///
  /// Example:
  /// ```dart
  /// var friday = DateTime(2023, 1, 6);
  /// var nextBusinessDay = friday.addBusinessDays(1);
  /// print(nextBusinessDay); // Output: Monday's date
  /// ```
  DateTime addBusinessDays(int count) {
    var daysToAdd = count;
    var date = this;
    while (daysToAdd > 0) {
      date = date.add(1.daysDuration);
      if (date.weekday != DateTime.saturday && date.weekday != DateTime.sunday) {
        daysToAdd--;
      }
    }
    return date;
  }

  /// Subtracts a specified number of business days, skipping weekends.
  ///
  /// Example:
  /// ```dart
  /// var monday = DateTime(2023, 1, 9);
  /// var previousBusinessDay = monday.subtractBusinessDays(1);
  /// print(previousBusinessDay); // Output: Friday's date
  /// ```
  DateTime subtractBusinessDays(int count) {
    var daysToSubtract = count;
    var date = this;
    while (daysToSubtract > 0) {
      date = date.subtract(1.daysDuration);
      if (date.weekday != DateTime.saturday && date.weekday != DateTime.sunday) {
        daysToSubtract--;
      }
    }
    return date;
  }

  /// Checks if the given date is on a weekend.
  ///
  /// Example:
  /// ```dart
  /// var saturday = DateTime(2023, 1, 7);
  /// print(saturday.isWeekend); // Output: true
  /// ```
  bool get isWeekend => weekday == DateTime.saturday || weekday == DateTime.sunday;
}

/// DateTime common format extensions，returns formatted date strings.
extension DateTimeFormatExtensions on DateTime {
  /// Formats the `DateTime` object into a string using the provided [pattern].
  /// If no pattern is provided, 'yyyy-MM-dd' is used by default.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().format(pattern: 'MM/dd/yyyy')); // Output: "04/07/2023"
  /// ```
  String format({String pattern = 'yyyy-MM-dd'}) => DateFormat(pattern).format(this);

  /// Quick access to the 'yyyy-MM-dd' date format string.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().ymd); // Output: "2023-04-07"
  /// ```
  String get ymd => DateFormats.ymd.format(this);

  /// Formats the `DateTime` into 'dd-MM-yyyy' format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().dmy); // Output: "07-04-2023"
  /// ```
  String get dmy => DateFormats.dmy.format(this);

  /// Formats the `DateTime` into 'MM/dd/yyyy', American style date format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().mdy); // Output: "04/07/2023"
  /// ```
  String get mdy => DateFormats.mdy.format(this);

  /// Formats the `DateTime` into 'yyyy-MM' format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().yearMonth); // Output: "2023-04"
  /// ```
  String get yearMonth => DateFormats.yearMonth.format(this);

  /// Formats the `DateTime` into 'dd-MM' format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().dayMonth); // Output: "07-04"
  /// ```
  String get dayMonth => DateFormats.dayMonth.format(this);

  /// Formats the `DateTime` into 'HH:mm' format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().hm); // Output: "12:00"
  /// ```
  String get hm => DateFormats.hm.format(this);

  /// Formats the `DateTime` into 'HH:mm:ss' format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().hms); // Output: "12:00:00"
  /// ```
  String get hms => DateFormats.hms.format(this);

  /// Formats the `DateTime` into ISO 8601 standard format 'yyyy-MM-ddTHH:mm:ss'.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().iso8601); // Output: "2023-04-07T12:00:00"
  /// ```
  String get iso8601 => DateFormats.iso8601.format(this);

  /// Formats the `DateTime` into a full date and time string 'yyyy-MM-dd HH:mm:ss'.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().fullDateTime); // Output: "2023-04-07 12:00:00"
  /// ```
  String get fullDateTime => DateFormats.fullDateTime.format(this);

  /// Formats the `DateTime` into 'dd-MM-yyyy HH:mm:ss' format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().fullDateTimeDmy); // Output: "07-04-2023 12:00:00"
  /// ```
  String get fullDateTimeDmy => DateFormats.fullDateTimeDmy.format(this);

  /// Formats the `DateTime` into 'MM/dd/yyyy HH:mm:ss' format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().fullDateTimeMdy); // Output: "04/07/2023 12:00:00"
  /// ```
  String get fullDateTimeMdy => DateFormats.fullDateTimeMdy.format(this);

  /// Formats the `DateTime` into 'dd/MM/yyyy HH:mm:ss' format.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().fullDateTimeDmY); // Output: "07/04/2023 12:00:00"
  /// ```
  String get fullDateTimeDmY => DateFormats.fullDateTimeDmY.format(this);

  /// Formats the `DateTime` into a time format string 'HH:mm:ss'.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().time); // Output: "12:00:00"
  /// ```
  String get time => DateFormats.time.format(this);

  /// Formats the `DateTime` into a complete date-time string with timezone information.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().zonedDateTime); // Output: "2023-04-07T12:00:00.000Z"
  /// ```
  String get zonedDateTime => DateFormats.zonedDateTime.format(this);

  /// Formats the `DateTime` into a string only containing the month and year.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().monthYear); // Output: "April 2023"
  /// ```
  String get monthYear => DateFormats.monthYear.format(this);

  /// Formats the `DateTime` into a short date format, which is locale dependent.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().shortDate); // Output: "4/7/2023" for en_US locale
  /// ```
  String get shortDate => DateFormats.shortDate.format(this);

  /// Formats the `DateTime` into a long date format, which is locale dependent.
  ///
  /// Example:
  /// ```dart
  /// print(DateTime.now().longDate); // Output: "April 7, 2023" for en_US locale
  /// ```
  String get longDate => DateFormats.longDate.format(this);
}
