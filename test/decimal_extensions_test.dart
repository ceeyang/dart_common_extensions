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
}
