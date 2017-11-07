// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:source_span/source_span.dart';
import 'package:yaml/yaml.dart';

/// A user-defined test platform, based on an existing platform but with
/// different configuration.
class CustomPlatform {
  /// The human-friendly name of the platform.
  final String name;

  /// The location that [name] was defined in the configuration file.
  final SourceSpan nameSpan;

  /// The identifier used to look up the platform.
  final String identifier;

  /// The location that [identifier] was defined in the configuration file.
  final SourceSpan identifierSpan;

  /// The identifier of the platform that this extends.
  final String parent;

  /// The location that [parent] was defined in the configuration file.
  final SourceSpan parentSpan;

  /// The user's settings for this platform.
  final YamlMap settings;

  CustomPlatform(this.name, this.nameSpan, this.identifier, this.identifierSpan,
      this.parent, this.parentSpan, this.settings);
}
