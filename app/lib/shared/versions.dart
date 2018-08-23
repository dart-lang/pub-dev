// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_semver/pub_semver.dart';

import 'utils.dart' show isNewer;

// update this whenever one of the other versions change
final String runtimeVersion = '2018.08.22';
final Version semanticRuntimeVersion = new Version.parse(runtimeVersion);

// keep in-sync with SDK version in .travis.yml, .mono_repo.yml and Dockerfile
final String runtimeSdkVersion = '2.1.0-dev.1.0';
final String toolEnvSdkVersion = '2.0.0';

// keep in-sync with app/pubspec.yaml
final String panaVersion = '0.11.9';
final Version semanticPanaVersion = new Version.parse(panaVersion);

final String flutterVersion = '0.6.2';
final Version semanticFlutterVersion = new Version.parse(flutterVersion);

final String dartdocVersion = '0.20.3';
final Version semanticDartdocVersion = new Version.parse(dartdocVersion);

/// The version of our customization going into the output of the dartdoc static
/// HTML files.
final String customizationVersion = '0.0.2';
final Version semanticCustomizationVersion =
    new Version.parse(customizationVersion);

// Version that control the dartdoc serving.
// Pin this to a specific version when there is a coordinated upgrade of the
// generated documentation template or style. The new version can generate the
// docs without any traffic sent to it, while the old won't accidentally serve
// them.
final dartdocServingRuntime = new Version.parse(runtimeVersion);

// Version that marks the default runtime version for analyzer entries created
// before the runtime version was tracked.
// TODO: remove hardcoded runtime version after the deploy is solid
final analyzerRuntimeEpoch = '2018.3.8';

// Version that marks the default runtime version for dartdoc entries created
// before the runtime version was tracked.
// TODO: remove hardcoded runtime version after the deploy is solid
final dartdocRuntimeEpoch = '2018.3.8';

/// Whether the given runtime version (stored with the dartdoc entry) should
/// be displayed on the live site (or a coordinated upgrade is in progress).
bool shouldServeDartdoc(String storedRuntimeVersion) {
  final stored = new Version.parse(storedRuntimeVersion ?? dartdocRuntimeEpoch);
  return !isNewer(dartdocServingRuntime, stored);
}
