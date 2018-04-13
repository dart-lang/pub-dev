// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:html/parser.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/dartdoc/customization.dart';

const String goldenDir = 'test/dartdoc/golden';

final _regenerateGoldens = false;

void main() {
  void expectGoldenFile(String content, String fileName) {
    // Making sure it is valid HTML
    final htmlParser = new HtmlParser(content, strict: true);
    htmlParser.parse();

    if (_regenerateGoldens) {
      new File('$goldenDir/$fileName').writeAsStringSync(content);
      fail('Set `_regenerateGoldens` to `false` to run tests.');
    }
    final golden = new File('$goldenDir/$fileName').readAsStringSync();
    expect(content.split('\n'), golden.split('\n'));
  }

  group('pana 0.10.2', () {
    final customization = new DartdocCustomizer('pana', '0.10.2+0');

    void expectMatch(String name) {
      test(name, () {
        final inputName = 'pana_0.10.2_$name.html';
        final outputName = 'pana_0.10.2_$name.out.html';
        final html = new File('$goldenDir/$inputName').readAsStringSync();
        final result = customization.customizeHtml(html) ?? html;
        expectGoldenFile(result, outputName);
      });
    }

    expectMatch('index');
    expectMatch('license_file_class');
    expectMatch('license_file_constructor');
    expectMatch('license_file_name_field');
    expectMatch('pretty_json');
  });
}
