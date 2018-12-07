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

  group('reflowByteText', () {
    test('small text', () {
      expect(reflowBodyText(''), '');
      expect(reflowBodyText('a'), 'a');
      expect(reflowBodyText('a b c'), 'a b c');
      expect(reflowBodyText('a\nb\nc'), 'a\nb\nc');
    });

    test('empty lines', () {
      expect(reflowBodyText('line 1\n\nline 2\n\n\nline 3'),
          'line 1\n\nline 2\n\n\nline 3');
    });

    test('long line', () {
      expect(
          reflowBodyText(
              'line 0\nabc def ghi jkl mno pqr stu vwx yz0 123 456 789 abc def ghi jkl '
              'mno pqr stu vwx yz0 123 456 789 abc def ghi jkl mno pqr stu vwx '
              'yz0 123 456 789 abc def ghi jkl mno pqr stu vwx yz0 123 456 789\nline 2'),
          'line 0\n'
          'abc def ghi jkl mno pqr stu vwx yz0 123 456 789 abc def ghi jkl mno pqr\n'
          'stu vwx yz0 123 456 789 abc def ghi jkl mno pqr stu vwx yz0 123 456 789\n'
          'abc def ghi jkl mno pqr stu vwx yz0 123 456 789\n'
          'line 2');
    });

    test('long word', () {
      expect(
          reflowBodyText(
              'sdhfbdskhfgbdfhgbdgdfgkdhsfvdkhfvddhjfbgkdhjfbgsdkhjfbgksdjhfgbdskfhgb'),
          'sdhfbdskhfgbdfhgbdgdfgkdhsfvdkhfvddhjfbgkdhjfbgsdkhjfbgksdjhfgbdskfhgb');
      expect(
          reflowBodyText(
              'abcdefg sdhfbdskhfgbdfhgbdgdfgkdhsfvdkhfvddhjfbgkdhjfbgsdkhjfbgksdjhfgbdskfhgb'),
          'abcdefg sdhfbdskhfgbdfhgbdgdfgkdhsfvdkhfvddhjfbgkdhjfbgsdkhjfbgksdjhfgbdskfhgb');
      expect(
          reflowBodyText(
              'abcdefg sdhfbdskhfgbdfhgbdgdfgkdhsfvdkhfvddhjfbgkdhjfbgsdkhjfbgksdjhfgbdskfhgb abcdefg'),
          'abcdefg sdhfbdskhfgbdfhgbdgdfgkdhsfvdkhfvddhjfbgkdhjfbgsdkhjfbgksdjhfgbdskfhgb\n'
          'abcdefg');
    });
  });

  group('Package uploaded email', () {
    test('2 uploaders', () {
      final message = createPackageUploadedEmail(
        packageName: 'pkg_foo',
        packageVersion: '1.0.0',
        uploaderEmail: 'uploader@example.com',
        authorizedUploaders: [
          new EmailAddress('Joe', 'joe@example.com'),
          new EmailAddress(null, 'uploader@example.com')
        ],
      );
      expect(message.from.toString(), 'Pub Site Admin <pub@dartlang.org>');
      expect(message.recipients.map((e) => e.toString()).toList(), [
        'Joe <joe@example.com>',
        'uploader@example.com',
      ]);
      expect(message.subject, 'Package upload on pub: pkg_foo 1.0.0');
      expect(
          message.bodyText,
          'Dear package maintainer,\n'
          '\n'
          'uploader@example.com uploaded a new version of package pkg_foo: 1.0.0\n'
          '\n'
          'If you think this is a mistake or fraud, file an issue on GitHub:\n'
          'https://github.com/dart-lang/pub-dartlang-dart/issues\n'
          '\n'
          'Pub Site Admin\n');
    });
  });

  group('Uploaders', () {
    test('uploader verification', () {
      final message = createUploaderVerificationEmail(
        packageName: 'pkg_foo',
        activeAccountEmail: 'active@example.com',
        addedUploaderEmail: 'uploader@example.com',
        verificationUrl:
            'https://pub.dartlang.org/verification/add-uploader/abcdef1234567890',
      );
      expect(message.from.toString(), 'Pub Site Admin <pub@dartlang.org>');
      expect(message.recipients.map((e) => e.toString()).toList(),
          ['uploader@example.com']);
      expect(message.subject, 'Pub invitation to collaborate: pkg_foo');
      expect(
          message.bodyText,
          'Dear package maintainer,\n'
          '\n'
          'active@example.com invited you to collaborate on pkg_foo and added you\n'
          'as uploader. You can see the package on the following URL:\n'
          'https://pub.dartlang.org/packages/pkg_foo\n'
          '\n'
          'If you want to accept the invitation, click on the following URL:\n'
          'https://pub.dartlang.org/verification/add-uploader/abcdef1234567890\n'
          '\n'
          'If you think this is a mistake or fraud, file an issue on GitHub:\n'
          'https://github.com/dart-lang/pub-dartlang-dart/issues\n'
          '\n'
          'Pub Site Admin\n');
    });
  });
}
