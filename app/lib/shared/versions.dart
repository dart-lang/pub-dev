// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_semver/pub_semver.dart';

import 'utils.dart' show isNewer;

// update this whenever one of the other versions change
final String runtimeVersion = '2018.6.15';
final Version semanticRuntimeVersion = new Version.parse(runtimeVersion);

// keep in-sync with SDK version in .travis.yml, .mono_repo.yml and Dockerfile
final String sdkVersion = '2.0.0-dev.63.0';
final Version semanticSdkVersion = new Version.parse(sdkVersion);

// keep in-sync with app/pubspec.yaml
final String panaVersion = '0.11.3';
final Version semanticPanaVersion = new Version.parse(panaVersion);

// keep in-sync with app/script/setup-flutter.sh
final String flutterVersion = '0.5.4';
final Version semanticFlutterVersion = new Version.parse(flutterVersion);

// keep in-sync with SDK version in .mono_repo.yml and Dockerfile
final String dartdocVersion = '0.20.0';
final Version semanticDartdocVersion = new Version.parse(dartdocVersion);

/// The version of our customization going into the output of the dartdoc static
/// HTML files.
final String customizationVersion = '0.0.2';
final Version semanticCustomizationVersion =
    new Version.parse(customizationVersion);

// Version that control the dartdoc serving.
final dartdocServingRuntime = new Version.parse('2018.6.15');

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
