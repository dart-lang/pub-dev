// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/email.dart';

void main() {
  group('EmailAddress.parse', () {
    void validateParse(String input, String name, String email) {
      final parsed = new EmailAddress.parse(input);
      expect(parsed.name, name);
      expect(parsed.email, email);
    }

    test('empty', () {
      validateParse('', null, null);
    });

    test('John Doe', () {
      validateParse('John Doe', 'John Doe', null);
      validateParse('<John Doe>', '<John Doe>', null);
      validateParse('John <Doe>', 'John <Doe>', null);
      validateParse('<John> <Doe>', '<John> <Doe>', null);
    });

    test('John Doe <email>', () {
      validateParse('John Doe <john.doe@example.com>', 'John Doe',
          'john.doe@example.com');
    });

    test('John Doe inline email', () {
      validateParse(
          'John Doe john.doe@example.com', 'John Doe', 'john.doe@example.com');
      validateParse(
          'John john.doe@example.com Doe', 'John Doe', 'john.doe@example.com');
    });

    test('email only', () {
      validateParse('john.doe@example.com', null, 'john.doe@example.com');
      validateParse('<john.doe@example.com>', null, 'john.doe@example.com');
    });
  });

  group('EmailAddress format', () {
    test('empty', () {
      expect(new EmailAddress(null, null).toString(), null);
    });

    test('name only', () {
      expect(new EmailAddress('John Doe', null).toString(), 'John Doe');
    });

    test('email only', () {
      expect(new EmailAddress(null, 'john.doe@example.com').toString(),
          'john.doe@example.com');
    });

    test('composite', () {
      expect(new EmailAddress('John Doe', 'john.doe@example.com').toString(),
          'John Doe <john.doe@example.com>');
    });
  });
}
