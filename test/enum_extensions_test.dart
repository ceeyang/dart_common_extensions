import 'package:dart_common_extensions/dart_extensions.dart';
import 'package:test/test.dart';

enum Status { active, inactive, pending }

void main() {
  group('EnumExtensions Tests', () {
    test('next works correctly in a cyclic manner', () {
      expect(Status.active.next(Status.values), Status.inactive);
      expect(Status.inactive.next(Status.values), Status.pending);
      expect(Status.pending.next(Status.values), Status.active);
    });

    test('previous works correctly in a cyclic manner', () {
      expect(Status.active.previous(Status.values), Status.pending);
      expect(Status.pending.previous(Status.values), Status.inactive);
      expect(Status.inactive.previous(Status.values), Status.active);
    });
  });
}
