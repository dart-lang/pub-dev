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
        'pub_dartdoc_data/ApiElement-class.html',
        'pub_dartdoc_data/ApiElement/ApiElement.fromJson.html',
        'pub_dartdoc_data/ApiElement/ApiElement.html',
        'pub_dartdoc_data/ApiElement/documentation.html',
        'pub_dartdoc_data/ApiElement/hashCode.html',
        'pub_dartdoc_data/ApiElement/href.html',
        'pub_dartdoc_data/ApiElement/kind.html',
        'pub_dartdoc_data/ApiElement/name.html',
        'pub_dartdoc_data/ApiElement/noSuchMethod.html',
        'pub_dartdoc_data/ApiElement/operator_equals.html',
        'pub_dartdoc_data/ApiElement/parent.html',
        'pub_dartdoc_data/ApiElement/runtimeType.html',
        'pub_dartdoc_data/ApiElement/source.html',
        'pub_dartdoc_data/ApiElement/toJson.html',
        'pub_dartdoc_data/ApiElement/toString.html',
        'pub_dartdoc_data/PubDartdocData-class.html',
        'pub_dartdoc_data/PubDartdocData/PubDartdocData.fromJson.html',
        'pub_dartdoc_data/PubDartdocData/PubDartdocData.html',
        'pub_dartdoc_data/PubDartdocData/apiElements.html',
        'pub_dartdoc_data/PubDartdocData/hashCode.html',
        'pub_dartdoc_data/PubDartdocData/noSuchMethod.html',
        'pub_dartdoc_data/PubDartdocData/operator_equals.html',
        'pub_dartdoc_data/PubDartdocData/runtimeType.html',
        'pub_dartdoc_data/PubDartdocData/toJson.html',
        'pub_dartdoc_data/PubDartdocData/toString.html',
        'pub_dartdoc_data/pub_dartdoc_data-library.html',
        'pub_data_generator/PubDataGenerator-class.html',
        'pub_data_generator/PubDataGenerator/PubDataGenerator.html',
        'pub_data_generator/PubDataGenerator/generate.html',
        'pub_data_generator/PubDataGenerator/hashCode.html',
        'pub_data_generator/PubDataGenerator/noSuchMethod.html',
        'pub_data_generator/PubDataGenerator/onFileCreated.html',
        'pub_data_generator/PubDataGenerator/operator_equals.html',
        'pub_data_generator/PubDataGenerator/runtimeType.html',
        'pub_data_generator/PubDataGenerator/toString.html',
        'pub_data_generator/PubDataGenerator/writtenFiles.html',
        'pub_data_generator/fileName-constant.html',
        'pub_data_generator/pub_data_generator-library.html',
        'static-assets/URI.js',
        'static-assets/css/bootstrap.css',
        'static-assets/css/bootstrap.css.map',
        'static-assets/css/bootstrap.min.css',
        'static-assets/favicon.png',
        'static-assets/github.css',
        'static-assets/highlight.pack.js',
        'static-assets/play_button.svg',
        'static-assets/readme.md',
        'static-assets/script.js',
        'static-assets/sdk_footer_text.html',
        'static-assets/styles.css',
        'static-assets/typeahead.bundle.min.js',
      ]);
    });

    test(
      'document pub_dartdoc project',
      () async {
        final goldenFile = new File('test/self-pub-data.json');
        final dataFile = new File('${tempDir.path}/pub-data.json');
        final fileContent = await dataFile.readAsString();
        final actualMap = json.decode(fileContent);

        // inherited toString() should not show up
        expect(fileContent.contains('PubDataGenerator.toString'), isFalse);

        if (_regenerateGoldens) {
          final content = new JsonEncoder.withIndent('  ').convert(actualMap);
          await goldenFile.writeAsString(content);
          fail('Set `_regenerateGoldens` to `false` to run tests.');
        }

        final expectedMap = json.decode(await goldenFile.readAsString());
        expect(expectedMap, actualMap);
      },
      timeout: new Timeout(const Duration(minutes: 5)),
    );
  }, timeout: new Timeout(const Duration(minutes: 5)));
}
