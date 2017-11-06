import 'package:test/test.dart' as ut;

void listEquals(a, b, [String message]) {
  ut.expect(b, ut.orderedEquals(a), reason: message);
}

void equals(a, b) {
  ut.expect(b, ut.equals(a));
}

void stringEquals(String a, String b, [String message]) {
  ut.expect(b, ut.equals(a), reason: message);
}

void isFalse(value) {
  ut.expect(value, ut.isFalse);
}
