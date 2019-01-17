// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:mustache/mustache.dart' as mustache;
import 'package:path/path.dart' as path;

import '../static_files.dart' show resolveAppDir;

final templateCache = new TemplateCache();

/// Loads, parses, caches and renders mustache templates.
class TemplateCache {
  /// The path to the directory which contains mustache templates.
  ///
  /// The path should not contain a trailing slash (e.g. "/tmp/views").
  final String _templateDirectory;

  /// A cache which keeps all used mustache templates parsed in memory.
  final Map<String, mustache.Template> _cachedMustacheTemplates = {};

  TemplateCache({String templateDirectory})
      : _templateDirectory = templateDirectory ??
            path.join(resolveAppDir(), 'lib/frontend/templates/views');

  /// Renders [template] with given [values].
  ///
  /// If [escapeValues] is `false`, values in `values` will not be escaped.
  String renderTemplate(String template, values, {bool escapeValues = true}) {
    final mustache.Template parsedTemplate =
        _cachedMustacheTemplates.putIfAbsent(template, () {
      final file = new File('$_templateDirectory/$template.mustache');
      return new mustache.Template(file.readAsStringSync(),
          htmlEscapeValues: escapeValues, lenient: true);
    });
    return parsedTemplate.renderString(values);
  }
}
