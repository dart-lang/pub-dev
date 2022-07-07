// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final _regenerateGoldens = false;

void main() {
  Directory? tempDir;

  group('generate documentation on self', () {
    ProcessResult? pr;

    setUpAll(() async {
      tempDir = await Directory.systemTemp.createTemp();
      pr = await Process.run('dart', [
        'pub',
        'run',
        'pub_dartdoc',
        '--input',
        Directory.current.absolute.path,
        '--output',
        tempDir!.absolute.path,
        '--sanitize-html',
      ]);
    });

    tearDownAll(() async {
      if (tempDir != null) {
        await tempDir!.delete(recursive: true);
      }
    });

    test('successfull process', () {
      expect(pr!.exitCode, 0);
    });

    test('process uses reasonable memory', () {
      final lines = pr!.stdout.toString().split('\n');
      final memUseStr = lines.reversed
          .firstWhere((line) => line.contains('Max memory use:'))
          .split(':')
          .last;
      final memUse = int.parse(memUseStr);

      // Last 3 measurements:
      // 1038073856
      // 1041264640
      // 1039941632
      final maxMemUse = 1.04;
      expect(memUse, lessThan(maxMemUse * 1024 * 1024 * 1024));

      // Sanity check for the test.
      // Min memory use: 80% of max.
      expect(memUse, greaterThan(maxMemUse * 0.8 * 1024 * 1024 * 1024));
    });

    test('has content', () async {
      final files = await tempDir!
          .list(recursive: true)
          .where((fse) => fse is File)
          .cast<File>()
          .map((file) => p.relative(file.path, from: tempDir!.path))
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
        'static-assets/docs.dart.js',
        'static-assets/docs.dart.js.map',
        'static-assets/favicon.png',
        'static-assets/github.css',
        'static-assets/highlight.pack.js',
        'static-assets/play_button.svg',
        'static-assets/readme.md',
        'static-assets/styles.css',
      ]);
    });

    test(
      'document pub_dartdoc project',
      () async {
        final goldenFile = File('test/self-pub-data.json');
        final dataFile = File('${tempDir!.path}/pub-data.json');
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
