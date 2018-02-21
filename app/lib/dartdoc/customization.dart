// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:html/dom.dart';
import 'package:html/parser.dart' as html_parser;

class DartdocCustomizer {
  final String packageName;
  final String packageVersion;

  DartdocCustomizer(this.packageName, this.packageVersion);

  Future<bool> customizeFile(File file) async {
    final String oldContent = await file.readAsString();
    final String newContent = customizeHtml(oldContent);
    if (newContent != null && oldContent != newContent) {
      await file.writeAsString(newContent);
      return true;
    } else {
      return false;
    }
  }

  String customizeHtml(String html) {
    final doc = html_parser.parse(html);
    return doc.outerHtml;
  }
}

