// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:markdown/markdown.dart' as md;

/// Creates an [Element] with Markdown-formatted content.
Future<Element> markdown(String text) async {
  return DivElement()
    ..setInnerHtml(
      md.markdownToHtml(text),
      validator: NodeValidator(uriPolicy: _UnsafeUriPolicy()),
    );
}

/// Allows any [Uri].
///
/// This shouldn't be a problem as we only render HTML we trust.
class _UnsafeUriPolicy implements UriPolicy {
  @override
  bool allowsUri(String uri) {
    return true;
  }
}
