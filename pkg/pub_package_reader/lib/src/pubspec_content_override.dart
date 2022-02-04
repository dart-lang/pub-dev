// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart' as yaml;
import 'package:yaml_edit/yaml_edit.dart';

final _logger = Logger('pubspec_content_override');

/// The version regular expression that accepted any character as separator.
final _lenientRegExp = RegExp(r'(\d+).(\d+).(\d+)' // Version number.
    r'(-([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?' // Pre-release.
    r'(\+([0-9A-Za-z-]+(\.[0-9A-Za-z-]+)*))?' // Build.
    );

/// Packages with bad versions:
const _packagesWithBadVersions = <String>{
  'assets_audio_player_web',
  'bloc_pattern',
  'bokain_models',
  'built_collection',
  'built_redux',
  'built_redux_thunk',
  'built_value',
  'built_value_generator',
  'built_value_test',
  'built_viewmodel',
  'built_viewmodel_flutter_built_redux',
  'built_viewmodel_flutter_redux',
  'built_viewmodel_generator',
  'carp_context_package',
  'codemetrics',
  'fluttercontactpicker',
  'interactive_webview',
  'meta_types',
  'meta_types_generator',
  'meta_types_json',
  'meta_types_json_generator',
  'meta_types_redux',
  'meta_types_redux_generator',
  'mocktail',
  'mocktail_image_network',
  'polymer_interop',
};

/// Override pubspec.yaml content if needed:
///
/// - If the archive was created before 2022-01-01, we may need to update the
///   version number, version constraint and SDK constraints, as `pub_semver`
///   accepted separator characters other than `.`.
String overridePubspecContentIfNeeded({
  required String content,
  required DateTime created,
}) {
  // quick checks to skip overrides
  if (created.year >= 2022) {
    return content;
  }

  try {
    return _fixupBrokenVersionAndConstraints(content);
  } on FormatException catch (e, st) {
    _logger.info('Unable to parse pubspec.', e, st);
  }
  // fallback: don't override content
  return content;
}

/// Fixes broken version and version constraints in [pubspecYaml] and returns a new YAML string.
///
/// Prior to [pub_semver#63] version numbers and version constraints were accepted with any
/// character as separate, instead of requiring  `.` (dot). This occurred because the regular expression
/// in `package:pub_semver` didn't escape dots as `\.`, but just contained `.` (dot, meaning any character).
///
/// Thus, package versions published prior to 2022-01-01, maybe contain _version numbers_,
/// _version constraints_ and _SDK constraints_ that doesn't use `.` (dot) as separator. As removing
/// these _package versions_ would break existing users, this function will rewrite the version numbers
/// and version constraints to have a valid format equivalent to how older versions of `pub_semver`
/// would have interpreted the version number / version constraints.
///
/// [pub_semver#63]: https://github.com/dart-lang/pub_semver/pull/63
String _fixupBrokenVersionAndConstraints(String pubspecYaml) {
  final root = yaml.loadYaml(pubspecYaml);
  if (root is! Map) {
    _logger.warning(
        'Unable to parse YAML for package, in _fixupBrokenVersionAndConstraints!');
    return pubspecYaml; // return original as no changes can be made
  }

  // sanity check on the name again, now with parsed yaml
  final name = root['name'];
  if (name is! String || !_packagesWithBadVersions.contains(name)) {
    return pubspecYaml; // return original as no changes needed
  }

  final editor = YamlEditor(pubspecYaml);
  var hasBeenUpdated = false;
  for (final c in _detectVersionEditCandidates(root)) {
    final updated = c.value.replaceAllMapped(_lenientRegExp, (match) {
      final major = int.parse(match[1]!);
      final minor = int.parse(match[2]!);
      final patch = int.parse(match[3]!);
      final pre = match[5];
      final build = match[8];
      return Version(major, minor, patch, pre: pre, build: build).toString();
    });
    if (updated != c.value) {
      editor.update(c.path, updated);
      hasBeenUpdated = true;
    }
  }

  final fixedPubspecYaml = editor.toString();
  if (hasBeenUpdated && fixedPubspecYaml == pubspecYaml) {
    _logger.warning('Updating pubspec.yaml while fixing versions failed.');
  }
  return fixedPubspecYaml;
}

class _VersionEditCandidate {
  final List<Object> path;
  final String value;

  _VersionEditCandidate(this.path, this.value);
}

List<_VersionEditCandidate> _detectVersionEditCandidates(Map root) {
  final paths = <_VersionEditCandidate>[];

  final version = root['version'];
  if (version is String) {
    paths.add(_VersionEditCandidate(['version'], version));
  }

  final env = root['environment'];
  if (env is Map) {
    for (final key in env.keys.map((k) => k.toString())) {
      final value = env[key];
      if (value is String) {
        paths.add(_VersionEditCandidate(['environment', key], value));
      }
    }
  }

  final dependencyKeys = [
    'dependencies',
    'dev_dependencies',
    'dependency_overrides',
  ];
  for (final dependencyKey in dependencyKeys) {
    final deps = root[dependencyKey];
    if (deps is Map) {
      for (final pkg in deps.keys.map((e) => e.toString())) {
        final value = deps[pkg];
        if (value is Map && value['version'] is String) {
          paths.add(_VersionEditCandidate(
              [dependencyKey, pkg, 'version'], value['version'] as String));
        } else if (value is String) {
          paths.add(_VersionEditCandidate([dependencyKey, pkg], value));
        }
      }
    }
  }

  return paths;
}
