// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_dev/account/session_cookie.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:test/test.dart';

void main() {
  group('Client session cookie parsing', () {
    ClientSessionCookieStatus parse(String? lax, [String? strict]) {
      final cookies = {
        if (lax != null) clientSessionLaxCookieName: lax,
        if (strict != null) clientSessionStrictCookieName: strict,
      };
      try {
        final status = parseClientSessionCookies(cookies);
        if (!status.isPresent) {
          expect(status.sessionId, null);
        }
        if (status.isStrict) {
          expect(status.isPresent, true);
        }
        return status;
      } on ResponseException catch (e) {
        // check cookie reset headers
        final values = e.headers?[HttpHeaders.setCookieHeader] as List?;
        expect(values, isNotNull);
        expect(values, isNotEmpty);
        expect(values!.map((e) => e.toString()).toList(), [
          'pub-sid-insecure=""; Path=/; Max-Age=0; SameSite=Lax; HttpOnly',
          'PUB_SID_INSECURE=""; Path=/; Max-Age=0; SameSite=Lax; HttpOnly',
          'PUB_SSID_INSECURE=""; Path=/; Max-Age=0; SameSite=Lax; HttpOnly',
        ]);
        rethrow;
      }
    }

    test('both missing', () {
      final status = parse(null);
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
    });

    test('lax empty', () {
      final status = parse('');
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
    });

    test('strict empty', () {
      final status = parse('');
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
    });

    test('both empty', () {
      final status = parse('', '');
      expect(status.isPresent, false);
      expect(status.isStrict, false);
      expect(status.sessionId, null);
    });

    test('only lax present', () {
      final status = parse('1');
      expect(status.isPresent, true);
      expect(status.isStrict, false);
      expect(status.sessionId, '1');
    });

    test('only strict present', () {
      expect(() => parse(null, '1'), throwsA(isA<AuthenticationException>()));
    });

    test('both present, same values', () {
      final status = parse('1', '1');
      expect(status.isPresent, true);
      expect(status.isStrict, true);
      expect(status.sessionId, '1');
    });

    test('both present, different values', () {
      expect(() => parse('1', '2'), throwsA(isA<AuthenticationException>()));
    });
  });
}
