import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:decimal/decimal.dart';
import 'package:test/test.dart';

enum TestEnum { enumA, enumB, enumC }

void main() {
  group('ConversionExtensions Tests', () {
    test('toInt converts string to int', () {
      expect('123'.toInt, equals(123));
      expect('123.22'.toInt, equals(123));
      expect('abc'.toInt, equals(0));
    });

    test('toDouble converts string to double', () {
      expect('123.45'.toDouble, equals(123.45));
      expect('123'.toDouble, equals(123));
      expect('123.23232'.toDouble, equals(123.23232));
      expect('123abc'.toDouble, equals(0));
    });

    test('toNum converts string to num', () {
      expect('123'.toNum, equals(123));
      expect('123.45'.toNum, equals(123.45));
      expect('abc'.toNum, equals(0));
    });

    test('toDecimal converts string to Decimal', () {
      expect('123.45'.toDecimal, equals(Decimal.parse('123.45')));
      expect('abc'.toDecimal, equals(Decimal.zero));
    });

    test('toDate converts string to DateTime', () {
      expect('2020-01-01'.toDate, equals(DateTime(2020, 1, 1)));
    });

    test('toUri converts string to Uri', () {
      expect('https://example.com'.toUri, equals(Uri.parse('https://example.com')));
      expect(''.toUri, isNull);
      expect('23333'.toUri, isNull);
      expect('example.com'.toUri, equals(Uri.parse('example.com')));
    });

    test('toBool converts "true" and "false" correctly', () {
      expect("true".toBool, isTrue);
      expect("false".toBool, isFalse);
      expect("not a boolean".toBool, isFalse);
    });

    test('toJson converts string to JSON object', () {
      expect('{"key":"value"}'.toJson, equals({"key": "value"}));
      expect('invalid json'.toJson, isNull);
    });

    test('toIntList converts comma-separated string to List<int>', () {
      expect('1,2,3'.toIntList, equals([1, 2, 3]));
      expect('1,a,3'.toIntList, equals([1, 3]));
    });

    test('toDoubleList converts comma-separated string to List<double>', () {
      expect('1.0,2.0,3.0'.toDoubleList, equals([1.0, 2.0, 3.0]));
      expect('1.0,a,3.0'.toDoubleList, equals([1.0, 3.0]));
    });

    test('Successfully parses an enum value', () {
      expect('enumA'.toEnum(TestEnum.values), TestEnum.enumA);
      expect('TestEnum.enumB'.toEnum(TestEnum.values), TestEnum.enumB);
      expect('b'.toEnum(TestEnum.values), isNull);
      expect(''.toEnum(TestEnum.values), isNull);
    });

    test('toMoney and formatMoney on String works correctly', () {
      expect('1234.56'.toMoney(), "1,234.56");
      expect('1234.567'.toMoney(decimalDigits: 1), "1,234.6");
      expect('1234'.formatMoney(symbol: '¥', decimalDigits: 0), "¥1,234");
      expect('abc'.toMoney(), "0.00"); // Default for invalid strings
    });

    test('toPercentage on String works correctly', () {
      expect('0.1234'.toPercentage(), "12.34%");
      expect('0.5'.toPercentage(fractionDigits: 0), "50%");
      expect('1.2'.toPercentage(), "100.00%");
      expect('abc'.toPercentage(), "0.00%");
    });
  });

  group('EncodeExtensions tests', () {
    test('Base64 encode and decode', () {
      const originalText = "Hello, World!";
      final encoded = originalText.base64Encoded;
      final decoded = encoded.base64Decoded;
      expect(encoded, isNot(equals(originalText)));
      expect(decoded, equals(originalText));
    });

    test('URL encode and decode', () {
      const originalText = "https://www.example.com/search?query=flutter development";
      final encoded = originalText.urlEncoded;
      final decoded = encoded.urlDecoded;
      expect(encoded, isNot(equals(originalText)));
      expect(decoded, equals(originalText));
    });
  });

  group('FormatExtensions tests', () {
    test('isNullOrWhiteSpace correctly identifies empty or whitespace strings', () {
      expect("".isNullOrWhiteSpace, isTrue);
      expect(" ".isNullOrWhiteSpace, isTrue);
      expect("\t\n".isNullOrWhiteSpace, isTrue);
      expect("not empty".isNullOrWhiteSpace, isFalse);
    });

    test('isNumeric correctly identifies numeric strings', () {
      expect("123".isNumeric, isTrue);
      expect("00123".isNumeric, isTrue);
      expect("12.3".isNumeric, isFalse);
      expect("abc".isNumeric, isFalse);
    });

    test('isEnglish correctly identifies English alphabet strings', () {
      expect("abcXYZ".isEnglish, isTrue);
      expect("abc XYZ".isEnglish, isFalse);
      expect("123".isEnglish, isFalse);
    });

    test('isChinese correctly identifies Chinese character strings', () {
      expect("汉字".isChinese, isTrue);
      expect("汉字ABC".isChinese, isFalse);
      expect("123".isChinese, isFalse);
    });

    test('isChineseMobile correctly identifies Chinese mobile numbers', () {
      expect("13800138000".isChineseMobile, isTrue);
      expect("12345678901".isChineseMobile, isFalse);
      expect("abc".isChineseMobile, isFalse);
    });

    test('isEmail correctly identifies email addresses', () {
      expect("email@example.com".isEmail, isTrue);
      expect("email@example".isEmail, isFalse);
      expect("@example.com".isEmail, isFalse);
    });

    test('isValidUrl correctly identifies URLs', () {
      // Valid URLs
      expect('http://example.com'.isValidUrl, isTrue);
      expect('https://example.com'.isValidUrl, isTrue);
      expect('https://www.example.com'.isValidUrl, isTrue);
      
      // Valid URLs with paths
      expect('https://www.example.com/path/to/resource'.isValidUrl, isTrue);
      expect('https://example.com/index.html'.isValidUrl, isTrue);
      expect('https://pai-statics.nppuat.com/20260418/775efba1cdf6f2f9a0e5430f20a0f094.jpeg'.isValidUrl, isTrue);
      
      // Valid URLs with query parameters and anchors
      expect('https://www.example.com?query=string'.isValidUrl, isTrue);
      expect('https://example.com/path?param1=value1&param2=value2'.isValidUrl, isTrue);
      expect('https://example.com#section-1'.isValidUrl, isTrue);
      expect('https://example.com/path?query=string#hash'.isValidUrl, isTrue);
      
      // Valid URLs without protocol
      expect('www.example.com'.isValidUrl, isTrue);
      expect('example.com'.isValidUrl, isTrue);
      expect('example.co.uk'.isValidUrl, isTrue);
      
      // Valid URLs with localhost and IPs
      expect('http://localhost'.isValidUrl, isTrue);
      expect('http://localhost:8080'.isValidUrl, isTrue);
      expect('http://localhost:3000/api/users'.isValidUrl, isTrue);
      expect('http://192.168.1.1'.isValidUrl, isTrue);
      expect('https://10.0.0.5:443/status'.isValidUrl, isTrue);

      // Invalid URLs
      expect('http://'.isValidUrl, isFalse);
      expect('https://'.isValidUrl, isFalse);
      expect('https:// example.com'.isValidUrl, isFalse); // contains space in domain
      expect('htp://example.com'.isValidUrl, isFalse); // invalid protocol
      expect(''.isValidUrl, isFalse); // empty string
      expect('www.example .com'.isValidUrl, isFalse); // space in domain
    });

    test('isValidHex correctly identifies hex strings', () {
      expect("ABC123".isValidHex, isTrue);
      expect("abc123".isValidHex, isTrue);
      expect("123G".isValidHex, isFalse);
    });

    test('isIP correctly identifies IP addresses', () {
      expect("192.168.1.1".isIP, isTrue);
      expect("2001:0db8:85a3:0000:0000:8a2e:0370:7334".isIP, isTrue);
      expect("abc.def.ghi.jkl".isIP, isFalse);
      expect("256.256.256.256".isIP, isFalse);
      expect("".isIP, isFalse);
    });

    test('isBase64 correctly identifies base64 strings', () {
      expect("SGVsbG8=".isBase64, isTrue);
      expect("invalid base64!".isBase64, isFalse);
      expect("".isBase64, isTrue);
    });

    test('isJson correctly identifies JSON strings', () {
      expect('{"key": "value"}'.isJson, isTrue);
      expect('[1, 2, 3]'.isJson, isTrue);
      expect('{"a":1, "b":["x", "y"]}'.isJson, isTrue);
      expect('not json'.isJson, isFalse);
      expect('{ "key": invalid }'.isJson, isFalse);
      expect(''.isJson, isFalse);
    });

    test('Case conversions work correctly', () {
      expect("hello_world".toCamelCase, equals("helloWorld"));
      expect("hello-world".toCamelCase, equals("helloWorld"));
      expect("HelloWorld".toSnakeCase, equals("hello_world"));
      expect("HelloWorld".toKebabCase, equals("hello-world"));
      expect("hello world".toTitleCase, equals("Hello World"));
      expect("hello_world".toTitleCase, equals("Hello World"));
    });

    test('truncate and limit correctly shorten strings', () {
      expect("Hello World".truncate(5), equals("Hello..."));
      expect("Hi".truncate(5), equals("Hi"));
      expect("Hello World".limit(5), equals("Hello..."));
      expect("Test".limit(10), equals("Test"));
    });

    test('removePrefix and removeSuffix work correctly', () {
      expect("pre_text".removePrefix("pre_"), equals("text"));
      expect("text".removePrefix("pre_"), equals("text"));
      expect("text_suf".removeSuffix("_suf"), equals("text"));
      expect("text".removeSuffix("_suf"), equals("text"));
      expect("".removePrefix("a"), equals(""));
    });

    test('substringBefore and substringAfter work correctly', () {
      expect("user@example.com".substringBefore("@"), equals("user"));
      expect("user@example.com".substringAfter("@"), equals("example.com"));
      expect("no_delimiter".substringBefore("@"), equals("no_delimiter"));
      expect("no_delimiter".substringAfter("@"), equals("no_delimiter"));
      expect("u@e@m".substringBefore("@"), equals("u"));
      expect("u@e@m".substringAfter("@"), equals("e@m"));
    });
    test('ymd correctly formats date strings in yyyy-MM-dd format, including timestamps', () {
      expect("2023-01-01".ymd, "2023-01-01");
      expect("2023-01-01T12:00:00".ymd, "2023-01-01");
      expect("2023-01-01T12:00:00Z".ymd, "2023-01-01");
      expect("2023-01-01T12:00:00+00:00".ymd, "2023-01-01");
      expect("abc".ymd, "1970-01-01"); // Default date for invalid input
      expect("1643723400".ymd, "2022-02-01"); // Unix timestamp
    });

    test('dmy correctly formats date strings in dd-MM-yyyy format, including timestamps', () {
      expect("2023-01-01".dmy, "01-01-2023");
      expect("2023-01-01T12:00:00".dmy, "01-01-2023");
      expect("2023-01-01T12:00:00Z".dmy, "01-01-2023");
      expect("2023-01-01T12:00:00+00:00".dmy, "01-01-2023");
      expect("abc".dmy, "01-01-1970"); // Default date for invalid input
      expect("1643723400".dmy, "01-02-2022"); // Unix timestamp
    });

    test('mdy correctly formats date strings in MM/dd/yyyy format, including timestamps', () {
      expect("2023-01-01".mdy, "01/01/2023");
      expect("2023-01-01T12:00:00".mdy, "01/01/2023");
      expect("2023-01-01T12:00:00Z".mdy, "01/01/2023");
      expect("2023-01-01T12:00:00+00:00".mdy, "01/01/2023");
      expect("abc".mdy, "01/01/1970"); // Default date for invalid input
      expect("1643723400".mdy, "02/01/2022"); // Unix timestamp
    });

    test('yearMonth correctly formats date strings in yyyy-MM format, including timestamps', () {
      expect("2023-01-01".yearMonth, "2023-01");
      expect("2023-01-01T12:00:00".yearMonth, "2023-01");
      expect("2023-01-01T12:00:00Z".yearMonth, "2023-01");
      expect("2023-01-01T12:00:00+00:00".yearMonth, "2023-01");
      expect("abc".yearMonth, "1970-01"); // Default date for invalid input
      expect("1643723400".yearMonth, "2022-02"); // Unix timestamp
    });

    test('dayMonth correctly formats date strings in dd-MM format, including timestamps', () {
      expect("2023-01-01".dayMonth, "01-01");
      expect("2023-01-01T12:00:00".dayMonth, "01-01");
      expect("2023-01-01T12:00:00Z".dayMonth, "01-01");
      expect("2023-01-01T12:00:00+00:00".dayMonth, "01-01");
      expect("abc".dayMonth, "01-01"); // Default date for invalid input
      expect("1643723400".dayMonth, "01-02"); // Unix timestamp
    });

    test('hm correctly formats time strings in HH:mm format, including timestamps', () {
      expect("2023-01-01T12:00:00".hm, "12:00");
      expect("2023-01-01T12:00:00Z".hm, "12:00");
      expect("2023-01-01T12:00:00+00:00".hm, "12:00");
      expect("abc".hm, "00:00"); // Default time for invalid input
    });

    test('hms correctly formats time strings in HH:mm:ss format, including timestamps', () {
      expect("2023-01-01T12:00:00".hms, "12:00:00");
      expect("2023-01-01T12:00:00Z".hms, "12:00:00");
      expect("2023-01-01T12:00:00+00:00".hms, "12:00:00");
      expect("abc".hms, "00:00:00"); // Default time for invalid input
    });

    test('iso8601 correctly formats date-time strings in ISO 8601 format, including timestamps',
        () {
      expect("2023-01-01T12:00:00".iso8601, "2023-01-01T12:00:00");
      expect("abc".iso8601, "1970-01-01T00:00:00"); // Default date-time for invalid input
    });

    test(
        'fullDateTime correctly formats date-time strings in yyyy-MM-dd HH:mm:ss format, including timestamps',
        () {
      expect("2023-01-01T12:00:00".fullDateTime, "2023-01-01 12:00:00");
    });
  });
}
