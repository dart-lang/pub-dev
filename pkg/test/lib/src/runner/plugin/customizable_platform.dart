// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:yaml/yaml.dart';

import '../../backend/test_platform.dart';
import 'platform.dart';

/// An interface for [PlatformPlugin]s that support per-platform customization.
///
/// If a [PlatformPlugin] implements this, the user will be able to override the
/// [TestPlatform]s it supports using the
/// [`override_platforms`][override_platforms] configuration field, and define
/// new platforms based on them using the [`define_platforms`][define_platforms]
/// field. The custom settings will be passed to the plugin using
/// [customizePlatform].
///
/// [override_platforms]: https://github.com/dart-lang/test/blob/master/doc/configuration.md#override_platforms
/// [define_platforms]: https://github.com/dart-lang/test/blob/master/doc/configuration.md#define_platforms
///
/// Plugins that implement this **must** support children of recognized
/// platforms (created by [TestPlatform.extend]) in their [loadChannel] or
/// [load] methods.
abstract class CustomizablePlatform<T> extends PlatformPlugin {
  /// Parses user-provided [settings] for a custom platform into a
  /// plugin-defined format.
  ///
  /// The [settings] come from a user's configuration file. The parsed output
  /// will be passed to [customizePlatform].
  ///
  /// Subclasses should throw [SourceSpanFormatException]s if [settings]
  /// contains invalid configuration. Unrecognized fields should be ignored if
  /// possible.
  T parsePlatformSettings(YamlMap settings);

  /// Merges [settings1] with [settings2] and returns a new settings object that
  /// includes the configuration of both.
  ///
  /// When the settings conflict, [settings2] should take priority.
  ///
  /// This is used to merge global settings with local settings, or a custom
  /// platform's settings with its parent's.
  T mergePlatformSettings(T settings1, T settings2);

  /// Defines user-provided [settings] for [platform].
  ///
  /// The [platform] is a platform this plugin was declared to accept when
  /// registered with [Loader.registerPlatformPlugin], or a platform whose
  /// [TestPlatform.parent] is one of those platforms. Subclasses should
  /// customize the behavior for these platforms when [loadChannel] or [load] is
  /// called with the given [platform], using the [settings] which are parsed by
  /// [parsePlatformSettings]. This is guaranteed to be called before either
  /// `load` method.
  void customizePlatform(TestPlatform platform, T settings);
}
