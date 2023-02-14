// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/session_cookie.dart';
import 'package:test/test.dart';

void main() {
  group('Client session cookie parsing', () {
    ClientSessionCookieStatus parse(String? lax, [String? strict]) {
      final cookies = [
        if (lax != null) '$clientSessionLaxCookieName=$lax',
        if (strict != null) '$clientSessionStrictCookieName=$strict',
      ].join('; ');
      final status = parseClientSessionCookies(cookies);
      if (!status.isPresent || status.needsReset || !status.isValid) {
        expect(status.sessionId, null);
      }
      if (status.isStrict) {
        expect(status.isPresent, true);
      }
      return status;
    }

    test('both missing', () {
      final status = parse(null);
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
      expect(status.needsReset, false);
      expect(status.isValid, false);
    });

    test('lax empty', () {
      final status = parse('');
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
      expect(status.needsReset, false);
      expect(status.isValid, false);
    });

    test('strict empty', () {
      final status = parse('');
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
      expect(status.needsReset, false);
      expect(status.isValid, false);
    });

    test('both empty', () {
      final status = parse('', '');
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
      expect(status.needsReset, false);
      expect(status.isValid, false);
    });

    test('only lax present', () {
      final status = parse('1');
      expect(status.isPresent, true);
      expect(status.isStrict, false);
      expect(status.sessionId, '1');
      expect(status.needsReset, false);
      expect(status.isValid, true);
    });

    test('only strict present', () {
      final status = parse(null, '1');
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
      expect(status.needsReset, true);
      expect(status.isValid, false);
    });

    test('both present, same values', () {
      final status = parse('1', '1');
      expect(status.isPresent, true);
      expect(status.isStrict, true);
      expect(status.sessionId, '1');
      expect(status.needsReset, false);
      expect(status.isValid, true);
    });

    test('both present, different values', () {
      final status = parse('1', '2');
      expect(status.isPresent, true);
      expect(status.isStrict, true);
      expect(status.sessionId, null);
      expect(status.needsReset, true);
      expect(status.isValid, false);
    });
  });
}
