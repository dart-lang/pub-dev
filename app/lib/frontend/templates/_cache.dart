// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:mustache/mustache.dart' as mustache;
import 'package:path/path.dart' as path;

import '../static_files.dart' show resolveAppDir;

final templateCache = TemplateCache();

/// Loads, parses, caches and renders mustache templates.
class TemplateCache {
  /// A cache which keeps all used mustache templates parsed in memory.
  final Map<String, mustache.Template> _parsedMustacheTemplates = {};

  TemplateCache() {
    _loadDirectory(path.join(resolveAppDir(), 'lib/frontend/templates/views'));
  }

  void _loadDirectory(String dirPath) {
    Directory(dirPath)
        .listSync(recursive: true)
        .where((fse) => fse is File)
        .cast<File>()
        .where((f) => f.path.endsWith('.mustache'))
        .forEach(
      (file) {
        final t = mustache.Template(file.readAsStringSync(), lenient: true);
        final relativePath = path.relative(file.path, from: dirPath);
        final ext = path.extension(relativePath);
        final simplePath =
            relativePath.substring(0, relativePath.length - ext.length);
        _parsedMustacheTemplates[simplePath] = t;
      },
    );
  }

  /// Renders [template] with given [values].
  String renderTemplate(String template, values) {
    final parsedTemplate = _parsedMustacheTemplates[template];
    if (parsedTemplate == null) {
      throw Exception('Template $template was not found.');
    }
    return parsedTemplate.renderString(values);
  }
}
