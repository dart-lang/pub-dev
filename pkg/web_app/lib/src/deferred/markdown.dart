// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:js_interop';

import 'package:markdown/markdown.dart' as md;
import 'package:web/web.dart';

/// Creates an [Element] with Markdown-formatted content.
Element markdown(String text) {
  final div = HTMLDivElement();
  div.setHTMLUnsafe(md.markdownToHtml(text).toJS);
  return div;
}
