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
    if (fileName.endsWith('.html')) {
      // Making sure it is valid HTML
      final htmlParser = new HtmlParser(content, strict: true);
      final doc = htmlParser.parse();

      // Matching logo URLs with static files settings.
      // If this fails, update the hard-coded customization URL to match it.
      final logoElem = doc.documentElement.getElementsByTagName('img').first;
      expect(
          logoElem.attributes['src'].endsWith(staticUrls.dartLogoSvg), isTrue);
    }
    if (_regenerateGoldens) {
      new File('$goldenDir/$fileName').writeAsStringSync(content);
    }

    final golden = new File('$goldenDir/$fileName').readAsStringSync();
    // Not sure why, but the dart 2 preview tests produce an additional newline
    // in the output.
    expect(content.split('\n').where((s) => s.isNotEmpty),
        golden.split('\n').where((s) => s.isNotEmpty));
  }

  group('pana 0.10.2', () {
    final prevCustomizer = new DartdocCustomizer('pana', '0.12.2', false);
    final latestCustomizer = new DartdocCustomizer('pana', '0.12.2', true);

    void expectMatch(String name) {
      test(name, () {
        final inputName = 'pana_0.12.2_$name.html';
        final outputName = 'pana_0.12.2_$name.out.html';
        final diffName = 'pana_0.12.2_$name.latest.diff';
        final html = new File('$goldenDir/$inputName').readAsStringSync();
        final prevResult = prevCustomizer.customizeHtml(html) ?? html;
        final latestResult = latestCustomizer.customizeHtml(html) ?? html;
        expectGoldenFile(prevResult, outputName);
        expectGoldenFile(_miniDiff(prevResult, latestResult), diffName);

        if (_regenerateGoldens) {
          fail('Set `_regenerateGoldens` to `false` to run tests.');
        }
      });
    }

    expectMatch('index');
    expectMatch('license_file_class');
    expectMatch('license_file_constructor');
    expectMatch('license_file_name_field');
    expectMatch('pretty_json');
  });
}

String _miniDiff(String text1, String text2) {
  final lines1 = text1.split('\n');
  final lines2 = text2.split('\n');

  final report = <String>[];

  while (lines1.isNotEmpty || lines2.isNotEmpty) {
    if (lines2.isEmpty) {
      for (String line in lines1) {
        report.add('- $line');
      }
      break;
    }
    if (lines1.isEmpty) {
      for (String line in lines2) {
        report.add('+ $line');
      }
      break;
    }
    if (lines1.last == lines2.last) {
      lines1.removeLast();
      lines2.removeLast();
      continue;
    }
    if (lines1.first == lines2.first) {
      lines1.removeAt(0);
      lines2.removeAt(0);
      continue;
    }
    final index1in2 = lines2.indexOf(lines1.first);
    final index2in1 = lines1.indexOf(lines2.first);
    if (index1in2 == -1) {
      final line = lines1.removeAt(0);
      report.add('- $line');
      continue;
    }
    if (index2in1 == -1) {
      final line = lines2.removeAt(0);
      report.add('+ $line');
      continue;
    }
    if (index1in2 > index2in1) {
      final line = lines1.removeAt(0);
      report.add('- $line');
      continue;
    } else {
      final line = lines2.removeAt(0);
      report.add('+ $line');
      continue;
    }
  }

  return report.map((s) => '$s\n').join();
}
