// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';

final _regenerateGoldens = false;

main() {
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
        'index.html',
        'index.json',
        'model/ApiElement-class.html',
        'model/ApiElement/ApiElement.fromJson.html',
        'model/ApiElement/ApiElement.html',
        'model/ApiElement/documentation.html',
        'model/ApiElement/hashCode.html',
        'model/ApiElement/href.html',
        'model/ApiElement/kind.html',
        'model/ApiElement/name.html',
        'model/ApiElement/noSuchMethod.html',
        'model/ApiElement/operator_equals.html',
        'model/ApiElement/parent.html',
        'model/ApiElement/runtimeType.html',
        'model/ApiElement/source.html',
        'model/ApiElement/toJson.html',
        'model/ApiElement/toString.html',
        'model/PubDartdocData-class.html',
        'model/PubDartdocData/PubDartdocData.fromJson.html',
        'model/PubDartdocData/PubDartdocData.html',
        'model/PubDartdocData/apiElements.html',
        'model/PubDartdocData/hashCode.html',
        'model/PubDartdocData/noSuchMethod.html',
        'model/PubDartdocData/operator_equals.html',
        'model/PubDartdocData/runtimeType.html',
        'model/PubDartdocData/toJson.html',
        'model/PubDartdocData/toString.html',
        'model/model-library.html',
        'pub-data.json',
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
        final actualMap = json.decode(await dataFile.readAsString());

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
