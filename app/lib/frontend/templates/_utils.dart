// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:path/path.dart' as p;

import '../../package/model_properties.dart' show FileObject;
import '../../shared/markdown.dart';

const HtmlEscape htmlAttrEscape = HtmlEscape(HtmlEscapeMode.attribute);

/// Renders a file content (e.g. markdown, dart source file) into HTML.
String renderFile(
  FileObject file,
  String baseUrl, {
  bool isChangelog = false,
}) {
  final filename = file.filename;
  final content = file.text;
  if (content != null) {
    if (_isMarkdownFile(filename)) {
      return markdownToHtml(content, baseUrl,
          baseDir: p.dirname(filename), isChangelog: isChangelog);
    } else if (_isDartFile(filename)) {
      return _renderDartCode(content);
    } else {
      return _renderPlainText(content);
    }
  }
  return null;
}

String _escapeAngleBrackets(String msg) =>
    const HtmlEscape(HtmlEscapeMode.element).convert(msg);

bool _isMarkdownFile(String filename) {
  final lc = filename.toLowerCase();
  return lc.endsWith('.md') ||
      lc.endsWith('.markdown') ||
      lc.endsWith('.mdown');
}

bool _isDartFile(String filename) => filename.toLowerCase().endsWith('.dart');

String _renderDartCode(String text) =>
    markdownToHtml('````dart\n${text.trim()}\n````\n', null);

String _renderPlainText(String text) =>
    '<div class="highlight"><pre>${_escapeAngleBrackets(text)}</pre></div>';

/// Encode [value] as JSON in a `<script>` safe format.
///
/// This allows embedding in `<script>` tags, typically used for
/// `<script type='application/json'>` or `<script type='ld+json'>`.
String encodeScriptSafeJson(Object value) => json
    .encode(value)
    .replaceAll(r'<!--', r'<\!--') // escape <!-- to prevent HTML comments
    .replaceAll(r'</', r'<\/'); // escape </ to prevent </script> tags
