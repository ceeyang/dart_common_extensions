import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('NumExtensions tests', () {
    test('toDecimal converts num to Decimal', () {
      expect(10.5.decimal, equals(Decimal.parse('10.5')));
    });

    test('toDateTime converts int to DateTime', () {
      expect(1609459200000000.toDateTime,
          equals(DateTime.fromMicrosecondsSinceEpoch(1609459200000000)));
      expect(1609459200000.toDateTime,
          equals(DateTime.fromMillisecondsSinceEpoch(1609459200000)));
    });

    test('toList generates list from 0 to n-1', () {
      expect(5.toList, equals([0, 1, 2, 3, 4]));
    });

    test('Check num positive, negative, even, and odd properties', () {
      num value = 5;
      expect(value.isEven, isFalse);
      expect(value.isOdd, isTrue);
    });

    test('Check prime number', () {
      expect(5.isPrime, isTrue);
      expect(4.isPrime, isFalse);
    });

    test('Calculate factorial', () {
      expect(5.factorial, equals(120));
    });

    test('Calculate number of digits', () {
      expect(12345.numberOfDigits, equals(5));
      expect(12345.22.numberOfDigits, equals(8));
    });

    test('Get absolute value', () {
      expect((-5).absolute, equals(5));
      expect((-10).absolute, equals(10));
      expect((10).absolute, equals(10));
    });

    test('Duration getters work correctly', () {
      expect(5.days.inDays, 5);
      expect(1.5.days.inHours, 36);
      expect(10.hours.inHours, 10);
      expect(1.5.hours.inMinutes, 90);
      expect(30.minutes.inMinutes, 30);
      expect(60.seconds.inSeconds, 60);
      expect(500.milliseconds.inMilliseconds, 500);
      expect(100.microseconds.inMicroseconds, 100);
    });

    test('toFileSize formatting works correctly', () {
      expect(1024.toFileSize(), "1.00 KB");
      expect((1024 * 1024).toFileSize(), "1.00 MB");
      expect(500.toFileSize(), "500 B");
    });

    test('toMoney and formatMoney formatting works correctly', () {
      expect(1234.56.toMoney(), "1,234.56");
      expect(1234.567.toMoney(), "1,234.57"); // Default 2 decimal places with rounding
      expect(1234.567.toMoney(decimalDigits: 1), "1,234.6");
      expect(1234.formatMoney(symbol: '¥', decimalDigits: 0), "¥1,234");
      expect(1234.56.formatMoney(symbol: '\$', decimalDigits: 2), "\$1,234.56");
      expect((-1234.56).toMoney(), "-1,234.56");
      expect(0.toMoney(), "0.00");
    });

    test('toPercentage formatting works correctly', () {
      expect(0.1234.toPercentage(), "12.34%");
      expect(0.5.toPercentage(fractionDigits: 0), "50%");
      expect(0.5.toPercentage(fractionDigits: 1), "50.0%");
    });

    test('toPercentage caps at 100%', () {
      expect(1.0.toPercentage(), "100.00%");
      expect(1.2.toPercentage(), "100.00%");
      expect(100.toPercentage(), "100.00%");
    });

    test('toPercentage handles zero and negative values', () {
      expect(0.toPercentage(), "0.00%");
      expect((-0.1234).toPercentage(), "-12.34%");
    });
  });
}
