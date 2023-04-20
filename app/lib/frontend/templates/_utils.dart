// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:path/path.dart' as p;

import '../../package/models.dart' show PackageVersionAsset;
import '../../shared/markdown.dart';
import '../dom/dom.dart' as d;

/// Renders a file content (e.g. markdown, dart source file) into HTML.
d.Node renderFile(
  PackageVersionAsset asset, {
  UrlResolverFn? urlResolverFn,
  String? baseUrl,
  bool isChangelog = false,
}) {
  final filename = asset.path!;
  final content = asset.textContent!;
  if (_isMarkdownFile(filename)) {
    return d.unsafeRawHtml(
      markdownToHtml(
        content,
        urlResolverFn: urlResolverFn,
        baseUrl: baseUrl,
        baseDir: p.dirname(filename),
        isChangelog: isChangelog,
      ),
    );
  } else if (_isDartFile(filename)) {
    return _renderDartCode(content);
  } else {
    return _renderPlainText(content);
  }
}

bool _isMarkdownFile(String filename) {
  final lc = filename.toLowerCase();
  return lc.endsWith('.md') ||
      lc.endsWith('.markdown') ||
      lc.endsWith('.mdown');
}

bool _isDartFile(String filename) => filename.toLowerCase().endsWith('.dart');

d.Node _renderDartCode(String text) =>
    d.markdown('````dart\n${text.trim()}\n````\n');

d.Node _renderPlainText(String text) =>
    d.div(classes: ['highlight'], child: d.pre(text: text));
