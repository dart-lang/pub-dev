// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:test/test.dart';

import 'package:pana/src/license.dart';

main() {
  Future expectFile(String path, LicenseFile expected) async {
    final relativePath = path.substring('test/licenses/'.length);
    expect(
        await detectLicenseInFile(new File(path), relativePath: relativePath),
        expected);
  }

  group('AGPL', () {
    test('explicit', () async {
      expect(detectLicenseInContent('GNU AFFERO GENERAL PUBLIC LICENSE'),
          new LicenseFile(null, 'AGPL'));
      await expectFile('test/licenses/agpl_v3.txt',
          new LicenseFile('agpl_v3.txt', 'AGPL', version: '3.0'));
    });
  });

  group('Apache', () {
    test('explicit', () async {
      expect(
          detectLicenseInContent(
              '   Apache License\n     Version 2.0, January 2004\n'),
          new LicenseFile(null, 'Apache', version: '2.0'));
      await expectFile('test/licenses/apache_v2.txt',
          new LicenseFile('apache_v2.txt', 'Apache', version: '2.0'));
    });
  });

  group('BSD', () {
    test('explicit', () async {
      await expectFile('test/licenses/bsd_2_clause.txt',
          new LicenseFile('bsd_2_clause.txt', 'BSD'));
      await expectFile('test/licenses/bsd_3_clause.txt',
          new LicenseFile('bsd_3_clause.txt', 'BSD'));
      await expectFile('test/licenses/bsd_revised.txt',
          new LicenseFile('bsd_revised.txt', 'BSD'));
    });
  });

  group('GPL', () {
    test('explicit', () async {
      expect(
          detectLicenseInContent([
            'GNU GENERAL PUBLIC LICENSE',
            'Version 2, June 1991'
          ].join('\n')),
          new LicenseFile(null, 'GPL', version: '2.0'));
      expect(detectLicenseInContent(['GNU GPL Version 2'].join('\n')),
          new LicenseFile(null, 'GPL', version: '2.0'));
      await expectFile('test/licenses/gpl_v3.txt',
          new LicenseFile('gpl_v3.txt', 'GPL', version: '3.0'));
    });
  });

  group('LGPL', () {
    test('explicit', () async {
      expect(
          detectLicenseInContent(
              '\nGNU LESSER GENERAL PUBLIC LICENSE\n    Version 3, 29 June 2007'),
          new LicenseFile(null, 'LGPL', version: '3.0'));
      await expectFile('test/licenses/lgpl_v3.txt',
          new LicenseFile('lgpl_v3.txt', 'LGPL', version: '3.0'));
    });
  });

  group('MIT', () {
    test('explicit', () async {
      expect(detectLicenseInContent('\n\n   The MIT license\n\n blah...'),
          new LicenseFile(null, 'MIT'));
      expect(detectLicenseInContent('MIT license\n\n blah...'),
          new LicenseFile(null, 'MIT'));
      await expectFile(
          'test/licenses/mit.txt', new LicenseFile('mit.txt', 'MIT'));
    });
  });

  group('MPL', () {
    test('explicit', () async {
      expect(
          detectLicenseInContent(
              '\n\n   Mozilla Public License Version 2.0\n\n blah...'),
          new LicenseFile(null, 'MPL', version: '2.0'));
      await expectFile('test/licenses/mpl_v2.txt',
          new LicenseFile('mpl_v2.txt', 'MPL', version: '2.0'));
    });
  });

  group('Unlicense', () {
    test('explicit', () async {
      expect(
          detectLicenseInContent(
              '\n\n   This is free and unencumbered software released into the public domain.\n'),
          new LicenseFile(null, 'Unlicense'));
      await expectFile('test/licenses/unlicense.txt',
          new LicenseFile('unlicense.txt', 'Unlicense'));
    });
  });

  group('unknown', () {
    test('empty content', () {
      expect(detectLicenseInContent(''), isNull);
    });
  });

  group('Directory scans', () {
    test('detect pana LICENSE', () async {
      expect(
          await detectLicensesInDir('.'), [new LicenseFile('LICENSE', 'BSD')]);
    });

    test('no license files', () async {
      expect(await detectLicensesInDir('lib/src'), []);
    });

    test('multiple license files', () async {
      expect(await detectLicensesInDir('test/licenses/multiple'), [
        new LicenseFile('LICENSE.core.txt', 'GPL', version: '3.0'),
        new LicenseFile('LICENSE.libs.txt', 'LGPL', version: '3.0'),
      ]);
    });
  });
}
