import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

void main() {
  group('DecimalMoneyExtensions tests', () {
    test('toMoney formatting works correctly', () {
      expect(Decimal.parse('1234.56').toMoney(), "1,234.56");
      expect(Decimal.parse('1234.567').toMoney(decimalDigits: 2), "1,234.57");
      expect(Decimal.parse('1234.567').toMoney(decimalDigits: 1), "1,234.6");
    });

    test('formatMoney formatting works correctly', () {
      expect(Decimal.parse('1234').formatMoney(symbol: '¥', decimalDigits: 0), "¥1,234");
      expect(Decimal.parse('1234.56').formatMoney(symbol: '\$', decimalDigits: 2), "\$1,234.56");
    });

    test('Negative and zero values', () {
      expect(Decimal.parse('-1234.56').toMoney(), "-1,234.56");
      expect(Decimal.zero.toMoney(), "0.00");
    });
  });

  group('DecimalPercentageExtension tests', () {
    test('toPercentage formatting works correctly', () {
      expect(Decimal.parse('0.1234').toPercentage(), "12.34%");
      expect(Decimal.parse('0.5').toPercentage(fractionDigits: 0), "50%");
      expect(Decimal.parse('0.5').toPercentage(fractionDigits: 1), "50.0%");
    });

    test('toPercentage caps at 100%', () {
      expect(Decimal.parse('1.0').toPercentage(), "100.00%");
      expect(Decimal.parse('1.2').toPercentage(), "100.00%");
      expect(Decimal.parse('100').toPercentage(), "100.00%");
    });

    test('toPercentage handles zero and negative values', () {
      expect(Decimal.zero.toPercentage(), "0.00%");
      expect(Decimal.parse('-0.1234').toPercentage(), "-12.34%");
    });
  });
}
