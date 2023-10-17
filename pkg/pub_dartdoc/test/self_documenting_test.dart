// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:pub_dartdoc/src/index_to_pubdata.dart';
import 'package:pub_dartdoc_data/dartdoc_index.dart';
import 'package:pub_dartdoc_data/pub_dartdoc_data.dart';
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
        'pub_dartdoc/pubDartDoc.html',
        'pub_dartdoc/pub_dartdoc-library-sidebar.html',
        'pub_dartdoc/pub_dartdoc-library.html',
        'pub_data_generator/PubDataGenerator-class-sidebar.html',
        'pub_data_generator/PubDataGenerator-class.html',
        'pub_data_generator/PubDataGenerator/PubDataGenerator.html',
        'pub_data_generator/PubDataGenerator/generate.html',
        'pub_data_generator/PubDataGenerator/toString.html',
        'pub_data_generator/fileName-constant.html',
        'pub_data_generator/pub_data_generator-library-sidebar.html',
        'pub_data_generator/pub_data_generator-library.html',
        'search.html',
        'static-assets/docs.dart.js',
        'static-assets/docs.dart.js.map',
        'static-assets/favicon.png',
        'static-assets/github.css',
        'static-assets/highlight.pack.js',
        'static-assets/play_button.svg',
        'static-assets/readme.md',
        'static-assets/search.svg',
        'static-assets/styles.css',
      ]);
    });

    test(
      'document pub_dartdoc project',
      () async {
        final goldenFile = File(p.join('test', 'self-pub-data.json'));
        final dataFile = File(p.join(tempDir!.path, 'pub-data.json'));
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
        expect(actualMap, expectedMap);
      },
    );

    test('processing index.json', () async {
      final tempFile = File(p.join('test', 'temp.index.json'));
      final indexJsonContent = tempFile.existsSync()
          ? await tempFile.readAsString()
          : await File(p.join(tempDir!.path, 'index.json')).readAsString();
      await tempFile.writeAsString(
          JsonEncoder.withIndent('  ').convert(json.decode(indexJsonContent)));
      final index = DartdocIndex.parseJsonText(indexJsonContent);
      final data = dataFromDartdocIndex(index);

      final goldenFile = File(p.join('test', 'self-pub-data.json'));
      final expectedMap = json.decode((await goldenFile.readAsString())
          .replaceAll('[PubDartdocData]', 'PubDartdocData')
          .replaceAll('`pub-data.json`', 'pub-data.json'));
      final expectedData =
          PubDartdocData.fromJson(expectedMap as Map<String, dynamic>);

      data.apiElements!.sort((a, b) {
        if (a.kind == 'library') return -1;
        if (b.kind == 'library') return 1;
        if (a.kind == 'function') return -1;
        if (b.kind == 'function') return 1;
        if (a.kind == 'class') return -1;
        if (b.kind == 'class') return 1;
        if (a.kind == 'top-level constant') return -1;
        if (b.kind == 'top-level constant') return 1;
        final ia = expectedData.apiElements!
            .indexWhere((e) => e.name == a.name && e.parent == a.parent);
        final ib = expectedData.apiElements!
            .indexWhere((e) => e.name == b.name && e.parent == b.parent);
        return ia.compareTo(ib);
      });
      expect(json.decode(json.encode(data.toJson())), expectedMap);
    });
  }, timeout: Timeout(const Duration(minutes: 5)));
}
