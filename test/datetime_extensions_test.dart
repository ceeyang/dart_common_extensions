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
