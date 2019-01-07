// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';
import 'package:retry/retry.dart';

void main() {
  group('RetryOptions', () {
    test('default delay', () {
      // Since this test is random we'll run it a 1k times...
      for (var j = 0; j < 1000; j++) {
        final ivt = [
          0,
          400,
          800,
          1600,
          3200,
          6400,
          12800,
          25600,
        ];
        final r = RetryOptions();
        for (int i = 0; i < ivt.length; i++) {
          final d = r.delay(i).inMilliseconds;
          expect(d, inInclusiveRange(ivt[i] * 0.74, ivt[i] * 1.26));
        }
      }
    });

    test('retry (success)', () async {
      int count = 0;
      final r = RetryOptions();
      final f = r.retry(() {
        count++;
        return true;
      });
      expect(f, completion(isTrue));
      expect(count, equals(1));
    });

    test('retry (unhandled exception)', () async {
      int count = 0;
      final r = RetryOptions(
        maxAttempts: 5,
      );
      final f = r.retry(() {
        count++;
        throw Exception('Retry will fail');
      });
      await expectLater(f, throwsA(isException));
      expect(count, equals(1));
    });

    test('retry (retryIf, exhaust retries)', () async {
      int count = 0;
      final r = RetryOptions(
        maxAttempts: 5,
        maxDelay: Duration(),
      );
      final f = r.retry(() {
        count++;
        throw FormatException('Retry will fail');
      }, retryIf: (e) => e is FormatException);
      await expectLater(f, throwsA(isFormatException));
      expect(count, equals(5));
    });

    test('retry (success after 2)', () async {
      int count = 0;
      final r = RetryOptions(
        maxAttempts: 5,
        maxDelay: Duration(),
      );
      final f = r.retry(() {
        count++;
        if (count == 1) {
          throw FormatException('Retry will be okay');
        }
        return true;
      }, retryIf: (e) => e is FormatException);
      await expectLater(f, completion(isTrue));
      expect(count, equals(2));
    });

    test('retry (unhandled on 2nd try)', () async {
      int count = 0;
      final r = RetryOptions(
        maxAttempts: 5,
        maxDelay: Duration(),
      );
      final f = r.retry(() {
        count++;
        if (count == 1) {
          throw FormatException('Retry will be okay');
        }
        throw Exception('unhandled thing');
      }, retryIf: (e) => e is FormatException);
      await expectLater(f, throwsA(isException));
      expect(count, equals(2));
    });
  });
}
