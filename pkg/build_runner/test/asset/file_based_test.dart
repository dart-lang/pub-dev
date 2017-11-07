// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
@TestOn('vm')
import 'dart:io';

import 'package:glob/glob.dart';
import 'package:path/path.dart' as path;
import 'package:test/test.dart';

import 'package:build_runner/build_runner.dart';

import '../common/common.dart';

final PackageGraph packageGraph =
    new PackageGraph.forPath('test/fixtures/basic_pkg');
final String newLine = Platform.isWindows ? '\r\n' : '\n';

void main() {
  group('FileBasedAssetReader', () {
    final reader = new FileBasedAssetReader(packageGraph);

    test('can read any application package files', () async {
      expect(await reader.readAsString(makeAssetId('basic_pkg|hello.txt')),
          'world$newLine');
      expect(await reader.readAsString(makeAssetId('basic_pkg|lib/hello.txt')),
          'world$newLine');
      expect(await reader.readAsString(makeAssetId('basic_pkg|web/hello.txt')),
          'world$newLine');
    });

    test('can read package dependency files in the lib dir', () async {
      expect(
          await reader.readAsString(makeAssetId('a|lib/a.txt')), 'A$newLine');
    });

    test('can check for existence of any application package files', () async {
      expect(await reader.canRead(makeAssetId('basic_pkg|hello.txt')), isTrue);
      expect(
          await reader.canRead(makeAssetId('basic_pkg|lib/hello.txt')), isTrue);
      expect(
          await reader.canRead(makeAssetId('basic_pkg|web/hello.txt')), isTrue);

      expect(await reader.canRead(makeAssetId('basic_pkg|a.txt')), isFalse);
      expect(await reader.canRead(makeAssetId('basic_pkg|lib/a.txt')), isFalse);
    });

    test('can check for existence of package dependency files in lib',
        () async {
      expect(await reader.canRead(makeAssetId('a|lib/a.txt')), isTrue);
      expect(await reader.canRead(makeAssetId('a|lib/b.txt')), isFalse);
    });

    test('throws when attempting to read a non-existent file', () async {
      expect(reader.readAsString(makeAssetId('basic_pkg|foo.txt')),
          throwsA(assetNotFoundException));
      expect(reader.readAsString(makeAssetId('a|lib/b.txt')),
          throwsA(assetNotFoundException));
      expect(reader.readAsString(makeAssetId('foo|lib/bar.txt')),
          throwsA(packageNotFoundException));
    });

    test('can list files based on glob', () async {
      expect(
          reader
              .findAssets(new Glob('{lib,web}/**'), packageName: 'basic_pkg')
              .toList(),
          unorderedEquals([
            makeAssetId('basic_pkg|lib/hello.txt'),
            makeAssetId('basic_pkg|web/hello.txt'),
          ]));
    });

    test('can get lastModified time for files', () async {
      expect(await reader.lastModified(makeAssetId('basic_pkg|hello.txt')),
          new isInstanceOf<DateTime>());
    });

    test('lastModified throws AssetNotFoundException appropriately', () async {
      expect(reader.lastModified(makeAssetId('basic_pkg|foo.txt')),
          throwsA(assetNotFoundException));
    });
  });

  group('FileBasedAssetWriter', () {
    final writer = new FileBasedAssetWriter(packageGraph);

    test('can output and delete files in the application package', () async {
      var id = makeAssetId('basic_pkg|test_file.txt');
      var content = 'test';
      await writer.writeAsString(id, content);
      var file = new File(path.join('test', 'fixtures', id.package, id.path));
      expect(await file.exists(), isTrue);
      expect(await file.readAsString(), content);

      await writer.delete(id);
      expect(await file.exists(), isFalse);
    });
  });
}
