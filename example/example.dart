import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:decimal/decimal.dart';

enum TestEnum { valA, valB, valC }

enum Status { active, inactive }

class MyObject {
  String doSomething() => 'Done';
  @override
  String toString() => 'MyObjectInstance';
}

void main() async {
  // --- Object Extensions ---
  print('--- Object Extensions ---');
  final someObject = MyObject();
  var result = someObject.let((it) => it.doSomething());
  print('Result from let: $result');
  someObject.also((it) => print('Processed: $it'));

  print(someObject.isNull); // false
  print(someObject.isNotNull); // true

  final String? nullableString = null;
  print('nullableString.isNull: ${nullableString.isNull}'); // true

  // --- String Extensions ---
  print('\n--- String Extensions ---');
  print('12'.toInt); // Output: 12
  print('12.34'.toDouble); // Output: 12.34
  print('123.45'.toNum); // Output: 123.45
  print('1234.567'.toMoney(decimalDigits: 1)); // Output: 1,234.6
  print('1234.56'.formatMoney(symbol: '¥', decimalDigits: 0)); // Output: ¥1,235
  print('2023-01-01'.toDate); // Output: Instance of 'DateTime' for 2023-01-01
  print('https://example.com'.toUri); // Output: Instance of 'Uri'
  print('true'.toBool); // Output: true
  print('0.1234'.toPercentage()); // Output: 12.34%
  print('1.2'.toPercentage()); // Output: 100.00%
  print('{"key": "value"}'.toJson); // Output: {key: value}
  print('1,2,3'.toIntList); // Output: [1, 2, 3]
  print('1.0,2.0,3.0'.toDoubleList); // Output: [1.0, 2.0, 3.0]

  print('Hello World'.base64Encoded); // Output: 'SGVsbG8gV29ybGQ='
  print('SGVsbG8gV29ybGQ='.base64Decoded); // Output: 'Hello World'
  print('Hello World'.urlEncoded); // Output: 'Hello%20World'
  print('Hello%20World'.urlDecoded); // Output: 'Hello World'

  print('   '.isNullOrWhiteSpace); // Output: true
  print('1234'.isNumeric); // Output: true
  print('Hello'.isEnglish); // Output: true
  print('你好'.isChinese); // Output: true
  print('13912345678'.isChineseMobile); // Output: true
  print('user@example.com'.isEmail); // true
  print('192.168.1.1'.isIP); // true
  print('{"a":1}'.isJson); // true
  print('SGVsbG8='.isBase64); // true
  print('https://example.com/index.html'.isValidUrl); // true
  print('http://localhost:8080/api/users'.isValidUrl); // true
  print('AFFE'.isValidHex); // true

  print('hello_world'.toCamelCase); // helloWorld
  print('helloWorld'.toSnakeCase); // hello_world
  print('hello-world'.toKebabCase); // hello-world
  print('hello world'.toTitleCase); // Hello World

  print('This is a long text'.truncate(10)); // 'This is a ...'
  print('Long Text'.limit(4)); // 'Long...'
  print('prefix_text'.removePrefix('prefix_')); // 'text'
  print('text_suffix'.removeSuffix('_suffix')); // 'text'
  print('user@example.com'.substringBefore('@')); // 'user'
  print('user@example.com'.substringAfter('@')); // 'example.com'

  print(''.onEmpty('default')); // Output: 'default'
  print('hello'.capitalize); // Output: 'Hello'
  print('Hello World'.removeAllSpaces); // Output: 'HelloWorld'
  print('hello'.reversed); // Output: 'olleh'
  print('Hello World'.replaceFirst('World', 'There')); // Output: 'Hello There'
  print('Hello World World'.replaceLast('World', 'There')); // Output: 'Hello World There'
  print('Hello World'.insert(6, 'Beautiful ')); // Output: 'Hello Beautiful World'
  print('abc'.repeat(3)); // Output: 'abcabcabc'

  print('valA'.toEnum(TestEnum.values)); // Output: TestEnum.valA
  print('TestEnum.valA'.toEnum(TestEnum.values)); // Output: TestEnum.valA

  // DateTime String Format Extensions
  print('2023-01-01'.ymd); // Output: "2023-01-01"
  print('2023-01-01'.dmy); // Output: "01-01-2023"
  print('2023-01-01'.mdy); // Output: "01/01/2023"
  print('2023-01-01'.yearMonth); // Output: "2023-01"
  print('2023-01-01'.dayMonth); // Output: "01-01"
  print('2023-01-01 15:30:45'.hm); // Output: "15:30"
  print('2023-01-01 15:30:45'.hms); // Output: "15:30:45"
  print('2023-01-01'.iso8601); // Output: "2023-01-01T00:00:00"
  print('2023-01-01'.fullDateTime); // Output: "2023-01-01 00:00:00"
  print('2023-01-01'.fullDateTimeDmy); // Output: "01-01-2023 00:00:00"
  print('2023-01-01'.fullDateTimeMdy); // Output: "01/01/2023 00:00:00"
  print('2023-01-01'.fullDateTimeDmY); // Output: "01/01/2023 00:00:00"
  print('2023-01-01 15:30:45'.time); // Output: "15:30:45"
  print('2023-01-01'.zonedDateTime); // Output: "2023-01-01T00:00:00.000Z"
  print('2023-01-01'.monthYear); // Output: "January 2023"
  print('2023-01-01'.shortDate); // Output: "1/1/2023" (locale dependent)
  print('2023-01-01'.longDate); // Output: "January 1, 2023" (locale dependent)

  // Also works with timestamp strings
  print('1672531200000'.ymd); // Output: "2023-01-01"
  print('1672531200000'.fullDateTime); // Output: "2023-01-01 00:00:00"

  // Invalid date strings will return 1970-01-01 (Unix epoch) formatted according to the pattern
  print('invalid-date'.ymd); // Output: "1970-01-01"

  // --- Num Extensions ---
  print('\n--- Num Extensions ---');
  print(123.456.decimal); // Output: 123.456 (as a Decimal)
  print(5.toList); // Output: [0, 1, 2, 3, 4]
  print(1609459200000.toDateTime); // Output: 2021-01-01 00:00:00.000 (assuming milliseconds)
  print(1609459200000.ymd); // Output: '2021-01-01'
  print(60.secondsDuration); // Output: 0:01:00.000000
  print(1.5.days); // Duration of 36 hours
  print(10.seconds); // Duration of 10 seconds
  print(1024.toFileSize()); // Output: 1.00 KB
  print(0.1234.toPercentage()); // Output: 12.34%
  print(Decimal.parse('0.5').toPercentage(fractionDigits: 0)); // Output: 50%

  print(2.isEven); // Output: true
  print(3.isOdd); // Output: true
  print((5.random).toString()); // Output: Random number between 0 and 5
  print(12345.numberOfDigits); // Output: 5
  print(5.isPrime); // Output: true
  print((-5).absolute); // Output: 5
  print('Waiting 500ms for delay example...');
  await 500.millisecondsDelay(); // Using small delay for example

  print(123456.78.toCurrency(symbol: '€')); // Outputs: €123,456.78
  print(1234.567.toMoney(decimalDigits: 1)); // Outputs: 1,234.6
  print(1234.56.formatMoney(symbol: '¥', decimalDigits: 0)); // Outputs: ¥1,235
  print(10.toBinaryString); // Outputs: 1010
  print(255.toHexString); // Outputs: ff

  print(1.rangeTo(5)); // Outputs: [1, 2, 3, 4, 5]
  print(5.rangeTo(1)); // Outputs: [5, 4, 3, 2, 1]
  print(1.sumTo(5)); // Outputs: 15 (1+2+3+4+5)
  print(2.power(3).toInt()); // Outputs: 8 (2^3)

  // --- Map Extensions ---
  print('\n--- Map Extensions ---');
  var mapExample = {'first': 1, 'second': 2};
  print(mapExample.getOrDefault('third', 0)); // Output: 0
  print(mapExample.getOrNull('third')); // Output: null
  print(mapExample.toJsonString()); // Output: '{"first": 1, "second": 2}'
  print(mapExample.toJsonStringWithIndent(4)); // Outputs a formatted JSON string with 4 spaces indentation
  print(mapExample.invert()); // Output: {1: 'first', '2': 'second'}
  print(mapExample.filterKeys((key) => key.startsWith('f'))); // Output: {'first': 1}
  print(mapExample.filterValues((value) => value > 1)); // Output: {'second': 2}

  var map1 = {'first': 1, 'second': 2};
  var map2 = {'second': 3, 'third': 4};
  print(map1.merge(map2)); // Output: {'first': 1, 'second': 3, 'third': 4}
  print(map1.merge(map2, (v1, v2) => v1 + v2)); // Output: {'first': 1, 'second': 5, 'third': 4}

  print({'a': 1, 'b': 2}.pick(['a'])); // {'a': 1}
  print({'a': 1, 'b': 2}.omit(['a'])); // {'b': 2}
  print({'a': 1}.mapKeys((k, v) => k.toUpperCase())); // {'A': 1}
  print({'a': 1}.mapValues((k, v) => v + 1)); // {'a': 2}
  print({'a': 1}.any((k, v) => v > 0)); // true
  print({'a': 1}.all((k, v) => v > 0)); // true

  // --- List Extensions ---
  print('\n--- List Extensions ---');
  List<int> intList = [1, 2, 3, 4, 5];
  List<String> stringList = ['a', 'b', 'c', 'd', 'e'];

  print(intList.random); // Output: (Random element from the list)
  print(stringList.safeElementAt(2)); // Output: c
  print(stringList.safeElementAt(10)); // Output: null
  print(intList.firstWhereOrNull((item) => item > 3)); // Output: 4
  print(intList.shuffled); // Output: [2, 4, 1, 3, 5] (example shuffled list)
  print(intList.chunked(2)); // Output: [[1, 2], [3, 4], [5]]
  print(stringList.firstWhereOrElse((item) => item == 'b', 'No matches')); // Output: b
  print(stringList.firstWhereOrElse((item) => item == 'f', 'No matches')); // Output: No matches
  intList.addIfNotContains(6);
  print(intList); // Output: [1, 2, 3, 4, 5, 6]
  bool removed = intList.removeFirstWhere((item) => item == 2);
  print(removed); // Output: true
  print(intList); // Output: [1, 3, 4, 5, 6]
  print(intList.reversedList); // Output: [6, 5, 4, 3, 1]
  print(stringList.mapToList((item) => item.toUpperCase())); // Output: ['A', 'B', 'C', 'D', 'E']
  print(intList.mapIndexed((i, e) => '$i: $e').toList()); // ['0: 1', '1: 3', ...]
  print(intList.distinctBy((e) => e % 2).toList()); // [1, 4]
  print([1, 2, 3, 4].windowed(2).toList()); // [[1, 2], [2, 3], [3, 4]]
  print([1, 2].zip(['a', 'b']).toList()); // [[1, 'a'], [2, 'b']]
  print(intList.count((i) => i > 3)); // 2
  print(intList.groupBy((item) => item % 2 == 0 ? 'even' : 'odd')); // Output: {'odd': [1, 3, 5], 'even': [4, 6]}
  List<num> nums = [1, 2, 3, 4];
  print(nums.sum); // Output: 10
  print(nums.average); // Output: 2.5
  print(nums.max); // 4
  print(nums.min); // 1
  print(['a', 'ab'].sumBy((s) => s.length)); // 3

  // --- DateTime Extensions ---
  print('\n--- DateTime Extensions ---');
  DateTime now = DateTime.now();
  DateTime specificDate = DateTime(2023, 1, 1);

  print(now.startOfDay); // Output: "YYYY-MM-DD 00:00:00.000"
  print(now.endOfDay); // Output: "YYYY-MM-DD 23:59:59.999"
  print(now.isSameDay(specificDate)); // Output: false
  DateTime friday = DateTime(2023, 1, 6);
  print(friday.addBusinessDays(1)); // Outputs the next Monday's date
  DateTime monday = DateTime(2023, 1, 9);
  print(monday.subtractBusinessDays(1)); // Outputs the previous Friday's date
  DateTime saturday = DateTime(2023, 1, 7);
  print(saturday.isWeekend); // Output: true

  // DateTime Format Extensions Usage
  // Formatting DateTime object into different patterns
  print(now.format(pattern: 'MM/dd/yyyy')); // Output: e.g., "04/07/2023"
  print(now.ymd); // Output: e.g., "2023-04-07"
  print(now.dmy); // Output: e.g., "07-04-2023"
  print(now.mdy); // Output: e.g., "04/07/2023"
  print(now.iso8601); // Output: e.g., "2023-04-07T12:00:00"
  print(now.fullDateTime); // Output: e.g., "2023-04-07 12:00:00"
  print(now.time); // Output: e.g., "12:00:00"
  print(now.zonedDateTime); // Output: e.g., "2023-04-07T12:00:00.000Z"
  print(now.monthYear); // Output: e.g., "April 2023"
  print(now.shortDate); // Output: based on locale, e.g., "4/7/2023"
  print(now.longDate); // Output: based on locale, e.g., "April 7, 2023"

  print(now.isToday); // true
  print(now.nextDay); // DateTime for tomorrow
  print(now.isSameMonth(DateTime(2023, 1, 1)));
  print(now.isLeapYear); // true/false
  print(now.daysInMonth); // 28/29/30/31

  // --- Enum Extensions ---
  print('\n--- Enum Extensions ---');
  print(Status.active.next(Status.values)); // Status.inactive
  print(Status.inactive.previous(Status.values)); // Status.active
}
