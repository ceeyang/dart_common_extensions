import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:decimal/decimal.dart';

void main() {
  // 1. String Extensions
  print('--- String Extensions ---');
  print('1234.567'.toMoney(decimalDigits: 1)); // 1,234.6
  print('hello_world'.toCamelCase); // helloWorld
  print('user@example.com'.substringBefore('@')); // user

  // 2. Num Extensions
  print('\n--- Num Extensions ---');
  print(1234.56.formatMoney(symbol: '¥', decimalDigits: 0)); // ¥1,235
  print(5.days.inHours); // 120
  print(1024.toFileSize()); // 1.00 KB

  // 3. Decimal Extensions
  print('\n--- Decimal Extensions ---');
  final decimal = Decimal.parse('1234567.89');
  print(decimal.toMoney()); // 1,234,567.89
  print(decimal.formatMoney(symbol: '\$', decimalDigits: 0)); // $1,234,568

  // 4. Object Extensions
  print('\n--- Object Extensions ---');
  final String? maybeNull = 'Hello' as String?;
  maybeNull?.let((it) => print('Length: ${it.length}')); // Length: 5

  // 5. DateTime Extensions
  print('\n--- DateTime Extensions ---');
  final now = DateTime.now();
  print(now.ymd); // e.g., 2026-04-07
  print(now.addBusinessDays(5).fullDateTime); // 5 business days from now
}
