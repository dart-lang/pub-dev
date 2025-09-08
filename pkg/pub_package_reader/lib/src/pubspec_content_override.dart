// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:yaml/yaml.dart' as yaml;
import 'package:yaml_edit/yaml_edit.dart';

import 'pub_semver_2.1.0_parser.dart';

final _logger = Logger('pubspec_yaml_override');

/// Packages with bad versions as detected by
/// https://github.com/dart-lang/pub_semver/pull/63
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

/// The strict version parsing fix will be part of this SDK release.
final _maxSdkVersion = Version(2, 17, 0);
final _defaultSdkVersionRange = VersionRange(
  min: Version(2, 12, 0),
  includeMin: true,
  max: _maxSdkVersion,
  includeMax: false,
);

/// Override pubspec.yaml if needed:
///
/// - If the archive was created before 2022-01-01, we may need to update the
///   version number, version constraint and SDK constraints, as `pub_semver`
///   accepted separator characters other than `.`.
///   https://github.com/dart-lang/pub_semver/pull/63
String overridePubspecYamlIfNeeded({
  required String pubspecYaml,
  required DateTime published,
}) {
  // quick checks to skip overrides
  if (published.year >= 2022) {
    return pubspecYaml;
  }

  try {
    return _fixupBrokenVersionAndConstraints(pubspecYaml);
  } on FormatException catch (e, st) {
    _logger.info('Unable to parse pubspec.', e, st);
  }
  // fallback: don't override
  return pubspecYaml;
}

/// Fixes broken version and version constraints in [pubspecYaml] and returns a new YAML string.
///
/// Prior to [pub_semver#63] version numbers and version constraints were accepted with any
/// character as separator, instead of requiring  `.` (dot). This occurred because the regular expression
/// in `package:pub_semver` didn't escape dots as `\.`, but just contained `.` (dot, meaning any character). (see https://github.com/dart-lang/pub_semver/commit/cee044a3dc8)
///
/// Thus, package versions published prior to 2022-01-01, may contain _version numbers_,
/// _version constraints_ and _SDK constraints_ that don't use `.` (dot) as separator. As removing
/// these _package versions_ would break existing users, this function will rewrite the version numbers
/// and version constraints to have a valid format equivalent to how older versions of `pub_semver`
/// would have interpreted the version number / version constraints.
///
/// [pub_semver#63]: https://github.com/dart-lang/pub_semver/pull/63
String _fixupBrokenVersionAndConstraints(String pubspecYaml) {
  final root = yaml.loadYaml(pubspecYaml);
  if (root is! Map) {
    _logger.warning(
      'Unable to parse YAML for package, in _fixupBrokenVersionAndConstraints!',
    );
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
    try {
      if (c.isVersion) {
        final v = parsePossiblyBrokenVersion(c.value);
        final updated = v.toString();
        if (updated == c.value) continue;
        // sanity check
        if (Version.parse(updated).toString() != updated) {
          throw FormatException(
            'Sanity check failed on version: `${c.value}`.',
          );
        }
        // do update
        editor.update(c.path, updated);
        hasBeenUpdated = true;
      } else {
        final vc = parsePossiblyBrokenVersionConstraint(c.value);
        final updated = vc.toString();
        if (updated == c.value) continue;
        // sanity check
        if (VersionConstraint.parse(updated).toString() != updated) {
          throw FormatException(
            'Sanity check failed on version constraint: `${c.value}`.',
          );
        }
        // do update
        editor.update(c.path, updated);
        hasBeenUpdated = true;
      }
    } on FormatException catch (e, st) {
      print(e);
      print(st);
      _logger.shout('Failed to fix broken version in package:$name', e, st);
      return pubspecYaml;
    }
  }
  if (!hasBeenUpdated) {
    return pubspecYaml;
  }

  // If there was any version correction, we should restrict the SDK version
  // range to disallow 2.17.0, which should have the fixed `package:pub_semver`.
  try {
    final path = ['environment', 'sdk'];
    final sdkValue = editor.parseAt(path).value?.toString();
    final parsed = VersionConstraint.parse(sdkValue ?? '');
    if (parsed is VersionRange) {
      final newRange = VersionRange(
        min: parsed.min,
        includeMin: parsed.includeMin,
        max: Version.parse('2.17.0'),
        includeMax: false,
      );
      editor.update(path, newRange.toString());
    } else {
      editor.update(path, _defaultSdkVersionRange.toString());
    }
  } on ArgumentError catch (_) {
    // no update
  } on FormatException catch (_) {
    // no update
  }

  final fixedPubspecYaml = editor.toString();
  if (fixedPubspecYaml == pubspecYaml) {
    _logger.warning(
      'Updating pubspec.yaml in package:$name failed while fixing versions.',
    );
  }

  return '# Compatibility rewrites applied by pub.dev\n$fixedPubspecYaml';
}

class _VersionEditCandidate {
  final List<Object> path;
  final String value;
  final bool isVersion;

  _VersionEditCandidate(this.path, this.value, {this.isVersion = false});
}

List<_VersionEditCandidate> _detectVersionEditCandidates(Map root) {
  final paths = <_VersionEditCandidate>[];

  final version = root['version'];
  if (version is String) {
    paths.add(_VersionEditCandidate(['version'], version, isVersion: true));
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
          paths.add(
            _VersionEditCandidate([
              dependencyKey,
              pkg,
              'version',
            ], value['version'] as String),
          );
        } else if (value is String) {
          paths.add(_VersionEditCandidate([dependencyKey, pkg], value));
        }
      }
    }
  }

  return paths;
}
