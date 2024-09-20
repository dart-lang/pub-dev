// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart' show PackageVersionAsset;
import '../../shared/markdown.dart';
import '../dom/dom.dart' as d;
import '../static_files.dart';

/// Renders a file content (e.g. markdown, dart source file) into HTML.
d.Node renderFile(
  PackageVersionAsset asset, {
  UrlResolverFn? urlResolverFn,
  bool isChangelog = false,
}) {
  final filename = asset.path!;
  final content = asset.textContent!;
  if (_isMarkdownFile(filename)) {
    return d.unsafeRawHtml(
      markdownToHtml(
        content,
        urlResolverFn: urlResolverFn,
        relativeFrom: filename,
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
    d.codeSnippet(language: 'dart', text: text.trim());

d.Node _renderPlainText(String text) =>
    d.div(classes: ['highlight'], child: d.pre(text: text));

d.Node foldableSection({
  required d.Node title,
  required Iterable<d.Node> children,
  Iterable<String>? buttonDivClasses,
}) {
  return d.div(
    classes: ['foldable-section', 'foldable'],
    children: [
      d.div(
        classes: ['foldable-button', ...?buttonDivClasses],
        children: [
          d.img(
            classes: ['foldable-icon'],
            image: d.Image(
              src: staticUrls
                  .getAssetUrl('/static/img/foldable-section-icon.svg'),
              alt: 'trigger folding of the section',
              width: 13,
              height: 6,
            ),
          ),
          title,
        ],
      ),
      d.div(
        classes: ['foldable-content'],
        children: children,
      ),
    ],
  );
}
