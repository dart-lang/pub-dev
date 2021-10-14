// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:pub_dev/dartdoc/dartdoc_sanitizer.dart';
import 'package:test/test.dart';

import 'customization_test.dart';

void main() {
  test('accept golden files', () async {
    final files = Directory(goldenDir)
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.html'))
        .where((f) => !f.path.endsWith('.out.html'))
        // dygraph templates are not updated to the latest dartdoc
        .where((f) => !f.path.contains('/dygraph_'))
        .toList();

    int _level(String path) {
      if (path.endsWith('_index.html')) return 0;
      if (path.endsWith('_class.html')) return 1;
      if (path.endsWith('_field.html')) return 2;
      if (path.endsWith('_constructor.html')) return 2;
      return 1;
    }

    for (final f in files) {
      final level = _level(f.path);
      final rs = sanitizeDartdocHtml(await f.readAsString(), level);
      expect(rs.passed, isTrue, reason: f.path);
    }
  });

  test('unauthorized <script> is removed', () {
    final rs = sanitizeDartdocHtml(
        '<html><body><p>1</p><script src="x.js"></script><p>2</p></body></html>',
        0);
    expect(rs.passed, false);
    expect(rs.contentHtml,
        '<html><head></head><body><p>1</p><p>2</p></body></html>');
  });

  test('onclick="" is removed', () {
    final rs = sanitizeDartdocHtml(
        '<html><body><p>1</p><div onclick="window.alert(\'x\');"></div><p>2</p></html>',
        0);
    expect(rs.passed, false);
    expect(rs.contentHtml,
        '<html><head></head><body><p>1</p><div></div><p>2</p></body></html>');
  });

  test('<iframe> is removed', () {
    final rs = sanitizeDartdocHtml(
        '<html><body><p>1</p><iframe src="x.html"></iframe><p>2</p></html>', 0);
    expect(rs.passed, false);
    expect(rs.contentHtml,
        '<html><head></head><body><p>1</p><p>2</p></body></html>');
  });
}
