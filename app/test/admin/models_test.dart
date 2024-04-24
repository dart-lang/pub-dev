// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/models.dart';
import 'package:test/test.dart';

void main() {
  group('ModerationSubject', () {
    test('Invalid values', () {
      expect(ModerationSubject.tryParse(''), null);
      expect(ModerationSubject.tryParse('x:x'), null);
      expect(ModerationSubject.tryParse('package'), null);
      expect(ModerationSubject.tryParse('package:'), null);
    });

    test('package', () {
      final ms = ModerationSubject.tryParse('package:x');
      expect(ms!.kind, ModerationSubjectKind.package);
      expect(ms.localName, 'x');
      expect(ms.package, 'x');
      expect(ms.version, isNull);
      expect(ms.publisherId, isNull);
    });

    test('package version', () {
      final ms = ModerationSubject.tryParse('package-version:x/1.0.0');
      expect(ms!.kind, ModerationSubjectKind.packageVersion);
      expect(ms.localName, 'x/1.0.0');
      expect(ms.package, 'x');
      expect(ms.version, '1.0.0');
      expect(ms.publisherId, isNull);
    });

    test('publisher', () {
      final ms = ModerationSubject.tryParse('publisher:example.com');
      expect(ms!.kind, ModerationSubjectKind.publisher);
      expect(ms.localName, 'example.com');
      expect(ms.package, isNull);
      expect(ms.version, isNull);
      expect(ms.publisherId, 'example.com');
    });
  });
}
