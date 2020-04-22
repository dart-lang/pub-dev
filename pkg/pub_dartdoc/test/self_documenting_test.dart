// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final _regenerateGoldens = false;

void main() {
  Directory tempDir;

  group('generate documentation on self', () {
    setUpAll(() async {
      tempDir = await Directory.systemTemp.createTemp();
      final pr = await Process.run('pub', [
        'run',
        'pub_dartdoc',
        '--input',
        Directory.current.path,
        '--output',
        tempDir.path,
      ]);
      expect(pr.exitCode, 0);
    });

    tearDownAll(() async {
      if (tempDir != null) {
        await tempDir.delete(recursive: true);
      }
    });

    test('has content', () async {
      final files = await tempDir
          .list(recursive: true)
          .where((fse) => fse is File)
          .cast<File>()
          .map((file) => p.relative(file.path, from: tempDir.path))
          .toList();
      files.sort();
      expect(files, [
        '__404error.html',
        'categories.json',
        'index.html',
        'index.json',
        'pub-data.json',
        'pub_data_generator/PubDataGenerator-class.html',
        'pub_data_generator/PubDataGenerator/PubDataGenerator.html',
        'pub_data_generator/PubDataGenerator/generate.html',
        'pub_data_generator/PubDataGenerator/toString.html',
        'pub_data_generator/fileName-constant.html',
        'pub_data_generator/pub_data_generator-library.html',
        'static-assets/URI.js',
        'static-assets/css/bootstrap.css',
        'static-assets/css/bootstrap.min.css',
        'static-assets/favicon.png',
        'static-assets/github.css',
        'static-assets/highlight.pack.js',
        'static-assets/play_button.svg',
        'static-assets/readme.md',
        'static-assets/script.js',
        'static-assets/sdk_footer_text.html',
        'static-assets/sdk_footer_text.md',
        'static-assets/styles.css',
        'static-assets/typeahead.bundle.min.js',
      ]);
    });

    test(
      'document pub_dartdoc project',
      () async {
        final goldenFile = File('test/self-pub-data.json');
        final dataFile = File('${tempDir.path}/pub-data.json');
        final fileContent = await dataFile.readAsString();
        final actualMap = json.decode(fileContent);

        // inherited toString() should not show up
        expect(fileContent.contains('PubDataGenerator.toString'), isFalse);

        if (_regenerateGoldens) {
          final content = JsonEncoder.withIndent('  ').convert(actualMap);
          await goldenFile.writeAsString(content);
          fail('Set `_regenerateGoldens` to `false` to run tests.');
        }

        final expectedMap = json.decode(await goldenFile.readAsString());
        expect(expectedMap, actualMap);
      },
      timeout: Timeout(const Duration(minutes: 5)),
    );
  }, timeout: Timeout(const Duration(minutes: 5)));
}
