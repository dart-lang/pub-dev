// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:collection/collection.dart';
import 'package:glob/glob.dart';
import 'package:path/path.dart' as p;
import 'package:yaml/yaml.dart';

/// Whether the package being tested uses the Polymer transformers at all.
///
/// This will be `null` until [_initialize] is called.
bool _usesPolymer;

/// The set of entry points passed in to the polymer transformer's config.
///
/// This will be `null` if no entrypoints are declared, indicating that all
/// entrypoints are supported.
Set<String> _entrypoints;

/// The $includes for the polymer transformer.
Set<Glob> _includes;

/// The $excludes for the polymer transformer.
Set<Glob> _excludes;

/// Returns whether [path] is an entrypoint transformed by the Polymer
/// transformer.
///
/// The Polymer transformer creates a bootstrapping wrapper script around the
/// entrypoints it's run on, so we need to know that so we can fetch the correct
/// source map file.
bool isPolymerEntrypoint(String path) {
  if (_usesPolymer == null) _initialize();
  if (!_usesPolymer) return false;

  if (_excludes != null) {
    // If there are any excludes, it must not match any of them.
    for (var exclude in _excludes) {
      if (exclude.matches(path)) return false;
    }
  }

  // If there are any includes, it must match one of them.
  if (_includes != null && !_includes.any((include) => include.matches(path))) {
    return false;
  }

  if (_entrypoints == null) return true;
  return _entrypoints.contains(path);
}

/// Initializes [_usesPolymer], [_entrypoints], [_includes], and [_excludes]
/// based on the contents of the pubspec.
///
/// This doesn't need to do any validation of the pubspec, since pub itself does
/// that before running the test executable.
void _initialize() {
  _usesPolymer = false;

  var pubspec = loadYaml(new File("pubspec.yaml").readAsStringSync());

  var transformers = pubspec['transformers'];
  if (transformers == null) {
    return;
  }

  for (var phase in transformers) {
    var phases = phase is List ? phase : [phase];
    for (var transformer in phases) {
      if (transformer is String) {
        if (transformer != "polymer") continue;
        _usesPolymer = true;
        return;
      }

      if (transformer.keys.single != "polymer") continue;
      _usesPolymer = true;

      var configuration = transformer.values.single;

      var entrypoints = configuration["entry_points"] as List;
      if (entrypoints != null) {
        _entrypoints = DelegatingSet.typed(entrypoints.toSet());
      }

      _includes = _parseGlobField(configuration, r"$includes");
      _excludes = _parseGlobField(configuration, r"$excludes");
      return;
    }
  }
}

/// Parses a glob field (either `$include` or `$exclude`).
Set<Glob> _parseGlobField(YamlMap configuration, String name) {
  if (!configuration.containsKey(name)) return null;
  var field = configuration[name];

  if (field is String) {
    return new Set.from([new Glob(field, context: p.url, recursive: true)]);
  }

  return new Set.from(field.map((node) {
    return new Glob(node, context: p.url, recursive: true);
  }));
}
