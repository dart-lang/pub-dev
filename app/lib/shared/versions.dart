// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_semver/pub_semver.dart';

import 'utils.dart' show isNewer;

/// The pattern of [runtimeVersion].
final RegExp runtimeVersionPattern = RegExp(r'\d{4}\.\d{2}\.\d{2}');

/// Represents a combined version of the overall toolchain and processing,
/// allowing easy check for data compatibility, age comparison and also reflects
/// whether an analysis needs to be re-done.
///
/// Increment the version when a change is significant enough to trigger
/// reprocessing, including: version change in pana, dartdoc, or the SDKs,
/// or when an feature or bugfix should be picked up by the analysis ASAP.
const String runtimeVersion = '2019.12.13';
final Version semanticRuntimeVersion = Version.parse(runtimeVersion);

/// The version which marks the earliest version of the data which we'd like to
/// keep during various GC processes. Data prior to this version is subject to
/// delete (unless there is another rule in place to keep it).
///
/// Make sure that at least two versions are kept here as the next candidates
/// when the version switch happens:
/// - 2019.12.13
/// - 2019.12.09
/// - 2019.11.29
/// - 2019.11.12
final String gcBeforeRuntimeVersion = '2019.11.01';

/// The versions which contain data that we should not fall back to.
final blacklistedRuntimeVersions = ['2019.12.05', '2019.12.05+1'];

// keep in-sync with SDK version in .travis.yml, .mono_repo.yml and Dockerfile
final String runtimeSdkVersion = '2.7.0';
final String toolEnvSdkVersion = '2.7.0';

// keep in-sync with app/pubspec.yaml
final String panaVersion = '0.13.2';
final Version semanticPanaVersion = Version.parse(panaVersion);

final String flutterVersion = '1.12.13+hotfix.5';
final Version semanticFlutterVersion = Version.parse(flutterVersion);

// keep in-sync with pkg/pub_dartdoc/pubspec.yaml
final String dartdocVersion = '0.29.1';
final Version semanticDartdocVersion = Version.parse(dartdocVersion);

// Version that control the dartdoc serving.
// Pin this to a specific version when there is a coordinated upgrade of the
// generated documentation template or style. The new version can generate the
// docs without any traffic sent to it, while the old won't accidentally serve
// them.
final dartdocServingRuntime = Version.parse(runtimeVersion);

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
  final stored = Version.parse(storedRuntimeVersion ?? dartdocRuntimeEpoch);
  return !isNewer(dartdocServingRuntime, stored);
}
