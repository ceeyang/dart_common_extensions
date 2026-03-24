import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:test/test.dart';

void main() {
  group('DateTimeExtensions', () {
    test('startOfDay returns the beginning of the day', () {
      final now = DateTime(2023, 4, 7, 12, 30);
      expect(now.startOfDay, DateTime(2023, 4, 7));
    });

    test('endOfDay returns the end of the day', () {
      final now = DateTime(2023, 4, 7, 12);
      expect(now.endOfDay, DateTime(2023, 4, 7, 23, 59, 59, 999, 999));
    });

    test('isSameDay checks if two dates are on the same day', () {
      final date1 = DateTime(2023, 4, 7);
      final date2 = DateTime(2023, 4, 7, 23, 59);
      expect(date1.isSameDay(date2), isTrue);
    });

    test('addBusinessDays skips weekends', () {
      final friday = DateTime(2023, 4, 7);
      final nextBusinessDay = friday.addBusinessDays(1);
      expect(nextBusinessDay.weekday, DateTime.monday);
    });

    test('subtractBusinessDays skips weekends', () {
      final monday = DateTime(2023, 4, 10);
      final previousBusinessDay = monday.subtractBusinessDays(1);
      expect(previousBusinessDay.weekday, DateTime.friday);
    });

    test('isWeekend checks if the date is on a weekend', () {
      final saturday = DateTime(2023, 4, 8);
      expect(saturday.isWeekend, isTrue);
    });

    test('isToday, isYesterday, isTomorrow work correctly', () {
      final now = DateTime.now();
      expect(now.isToday, isTrue);
      expect(now.subtract(const Duration(days: 1)).isYesterday, isTrue);
      expect(now.add(const Duration(days: 1)).isTomorrow, isTrue);
    });

    test('isLeapYear and daysInMonth work correctly', () {
      expect(DateTime(2024).isLeapYear, isTrue);
      expect(DateTime(2023).isLeapYear, isFalse);
      expect(DateTime(2024, 2).daysInMonth, 29);
      expect(DateTime(2023, 2).daysInMonth, 28);
    });

    test('isSameMonth and isSameYear work correctly', () {
      final d1 = DateTime(2023, 1, 1);
      final d2 = DateTime(2023, 1, 15);
      final d3 = DateTime(2023, 2, 1);
      final d4 = DateTime(2024, 1, 1);

      expect(d1.isSameMonth(d2), isTrue);
      expect(d1.isSameMonth(d3), isFalse);
      expect(d1.isSameYear(d3), isTrue);
      expect(d1.isSameYear(d4), isFalse);
    });

    test('nextDay and previousDay work correctly', () {
      final d = DateTime(2023, 1, 1);
      expect(d.nextDay.day, 2);
      expect(d.previousDay.day, 31);
      expect(d.previousDay.month, 12);
    });
  });

  group('DateTimeFormatExtensions', () {
    final now = DateTime(2023, 4, 7, 12, 0, 0);

    test('format returns formatted date string with given pattern', () {
      expect(now.format(pattern: 'MM/dd/yyyy'), '04/07/2023');
    });

    test('ymd returns date in yyyy-MM-dd format', () {
      expect(now.ymd, '2023-04-07');
    });
  });
}
