// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

import '../plugin/customizable_platform.dart';

/// User-defined settings for a built-in test platform.
class PlatformSettings {
  /// The identifier used to look up the platform being overridden.
  final String identifier;

  /// The location that [identifier] was defined in the configuration file.
  final SourceSpan identifierSpan;

  /// The user's settings for this platform.
  ///
  /// This is a list of settings, from most global to most specific, that will
  /// eventually be merged using [CustomizablePlatform.mergePlatformSettings].
  final List<YamlMap> settings;

  PlatformSettings(this.identifier, this.identifierSpan, List<YamlMap> settings)
      : settings = new List.unmodifiable(settings);
}
