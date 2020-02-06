// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:mustache/mustache.dart' as mustache;
import 'package:path/path.dart' as path;

import '../request_context.dart';
import '../static_files.dart' show resolveAppDir, staticUrls;

final templateCache = TemplateCache();
final _logger = Logger('templates.cache');

/// The directory that contains the mustache files.
final templateViewsDir =
    path.join(resolveAppDir(), 'lib/frontend/templates/views');

/// Loads, parses, caches and renders mustache templates.
class TemplateCache {
  /// A cache which keeps all used (lenient) mustache templates parsed in memory.
  final _lenientTemplates = <String, mustache.Template>{};

  /// A cache which keeps all used (strict) mustache templates parsed in memory.
  final _strictTemplates = <String, mustache.Template>{};

  TemplateCache() {
    update();
  }

  /// Updates all the cached templates by reloading them from disk.
  void update() {
    _lenientTemplates.clear();
    _strictTemplates.clear();
    _loadDirectory(templateViewsDir);
  }

  void _loadDirectory(String templateFolder) {
    Directory(templateFolder)
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.mustache'))
        .forEach(
      (file) {
        final relativePath = path.relative(file.path, from: templateFolder);
        final name = path.withoutExtension(relativePath);
        _lenientTemplates[name] =
            mustache.Template(file.readAsStringSync(), lenient: true);
        _strictTemplates[name] = mustache.Template(file.readAsStringSync());
      },
    );
  }

  mustache.Template _getTemplate(String name, bool strict) {
    final templates = strict ? _strictTemplates : _lenientTemplates;
    mustache.Template parsedTemplate;
    if (requestContext.isExperimental) {
      final dirName = path.dirname(name);
      final expFileName = '${path.basename(name)}_experimental';
      final expTemplate =
          dirName == '.' ? expFileName : path.join(dirName, expFileName);
      parsedTemplate = templates[expTemplate];
    }
    parsedTemplate ??= templates[name];
    if (parsedTemplate == null) {
      throw ArgumentError('Template $name was not found.');
    }
    return parsedTemplate;
  }

  /// Renders [template] with given [values].
  String renderTemplate(String template, Map<String, Object> values) {
    final data = {
      'static_assets': staticUrls.assets,
      ...values,
    };
    // try strict rendering first
    try {
      return _getTemplate(template, true).renderString(data);
    } on mustache.TemplateException catch (e, st) {
      _logger.warning(
          '[strict-template-failed] Strict template rendering failed for $template',
          e,
          st);
    }
    // fallback: lenient rendering
    return _getTemplate(template, false).renderString(data);
  }
}
