# Financial Formatting

To format numbers as money (thousand separators, fixed decimals), use `package:intl`.

## Patterns
- `#,##0.00`: Standard format with two decimal places and thousand separators.

## Extension Implementation
In this project, we use `toMoney({int decimalDigits = 2})` for default formatting and `formatMoney({String symbol = '', int decimalDigits = 2})` for custom prefixes and decimal control.

### num.toMoney({int decimalDigits = 2})
Returns a string formatted with thousand separators and the specified number of decimal places.

### num.formatMoney({String symbol = '', int decimalDigits = 2})
Prepends the symbol to the formatted string and controls decimal precision.

### String.toMoney() / formatMoney()
Automatically parses the string using `num.tryParse` (defaulting to `0` if invalid) before formatting.

## Usage
```dart
1234.567.toMoney(decimalDigits: 1); // 1,234.6
'1234.56'.formatMoney(symbol: '¥', decimalDigits: 0); // ¥1,235
```
