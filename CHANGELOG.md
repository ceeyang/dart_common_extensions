## 0.0.6
- Add `DecimalMoneyExtensions` for financial formatting of `Decimal` types.
- Add `example/example.dart` for better documentation.
- Improved documentation comments and fixed dartdoc formatting issues to improve package score.
- Shortened project description in `pubspec.yaml`.

## 0.0.5
- Add `toMoney()` and `formatMoney()` extensions to `num` and `String` for convenient financial formatting.
- Support custom prefixes and variable decimal places for financial formatting.
- Fixed `analysis_options.yaml` to include correctly installed lint package.

## 0.0.4

- Add `ObjectExtensions`: `let`, `also`, `isNull`, `isNotNull`.
- Add `EnumExtensions`: `next`, `previous` for cyclic navigation.
- Add `IterableExtensions`: `windowed`, `zip`, `count`, `mapIndexed`, `whereIndexed`, `forEachIndexed`, `distinctBy`.
- Add `ListExtensions`: `min`, `max`, `sumBy`, `averageBy`.
- Add `StringExtensions`: `isIP`, `isJson`, `isBase64`, `limit`, `truncate`, `substringBefore`, `substringAfter`, `removePrefix`, `removeSuffix`, and case conversions (`toCamelCase`, `toSnakeCase`, etc.).
- Add `DateTimeExtensions`: `isToday`, `nextDay`, `isLeapYear`, `daysInMonth`.
- Add `NumExtensions`: Fractional duration getters (e.g., `1.5.days`), `toFileSize` formatting.
- Refactor `min`/`max` in `NumListExtensions` for better type compatibility.
- Comprehensive unit tests (100+ cases) for all new and existing extensions.
- update README with more examples.

## 0.0.3

- Add `toDate` extension for string to date conversion
- Add `toDateTime` extension for string to date time conversion
- Add `StringToDateTimeStringExtensions` extension 方便日期字符串转换

## 0.0.2

- 添加支持的平台

## 0.0.1

- Initial release.
- Added String extensions for type conversion and formatting
- Added DateTime extensions for calculations and formatting
- Added List extensions for common operations
- Added Map extensions for data manipulation
- Added Num extensions for conversion and formatting
