// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:html/parser.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/dartdoc/customization.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';

const String goldenDir = 'test/dartdoc/golden';

final _regenerateGoldens = false;

void main() {
  void expectGoldenFile(String content, String fileName) {
    // Making sure it is valid HTML
    final htmlParser = new HtmlParser(content, strict: true);
    final doc = htmlParser.parse();

    // Matching logo URLs with static files settings.
    // If this fails, update the hard-coded customization URL to match it.
    final logoElem = doc.documentElement.getElementsByTagName('img').first;
    expect(logoElem.attributes['src'].endsWith(staticUrls.dartLogoSvg), isTrue);

    if (_regenerateGoldens) {
      new File('$goldenDir/$fileName').writeAsStringSync(content);
      fail('Set `_regenerateGoldens` to `false` to run tests.');
    }
    final golden = new File('$goldenDir/$fileName').readAsStringSync();
    // Not sure why, but the dart 2 preview tests produce an additional newline
    // in the output.
    expect(content.split('\n').where((s) => s.isNotEmpty),
        golden.split('\n').where((s) => s.isNotEmpty));
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
