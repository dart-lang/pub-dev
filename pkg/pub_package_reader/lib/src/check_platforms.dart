// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:yaml/yaml.dart';

import '../pub_package_reader.dart' show ArchiveIssue;

final _supportedKeys = <String>{
  'android',
  'ios',
  'linux',
  'macos',
  'web',
  'windows',
};

/// Checks when the pubspec has platforms specified:
/// - only supported platform keys are present
/// - no platform-specific configuration is present
Iterable<ArchiveIssue> checkPlatforms(String pubspecContent) sync* {
  final map = loadYaml(pubspecContent);
  if (map is! Map) return;
  if (!map.containsKey('platforms')) return;
  final platforms = map['platforms'];

  if (platforms == null) return;
  if (platforms is Map) {
    for (final key in platforms.keys) {
      if (!_supportedKeys.contains(key)) {
        yield ArchiveIssue('Unsupported platform key: `$key`.');
      }

      final value = platforms[key];
      if (value == null || (value is Map && value.isEmpty)) continue;
      yield ArchiveIssue('Unsupported platform config for `$key`: `$value`.');
    }
  } else {
    yield ArchiveIssue('Unsupported platforms value: `$platforms`.');
  }
}
