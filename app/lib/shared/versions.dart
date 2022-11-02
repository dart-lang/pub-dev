// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/pana.dart' as pana;
import 'package:pub_semver/pub_semver.dart';

/// The pattern of [runtimeVersion], should be updated to reflect the current
/// date the change happened, e.g. `2020.02.18`
///
/// While the format follows the semantic version pattern, we do not support
/// extra values (e.g. build numbers or pre-release versions).
///
/// If there is ever a need to have multiple runtimeVersions on the same date, it is suggested that
/// a future dates are used.
final RegExp runtimeVersionPattern = RegExp(r'^\d{4}\.\d{2}\.\d{2}$');

/// The list (and priority order) of runtimeVersions where version-specific data
/// is accepted from.
///
/// Make sure that at least two versions are kept here as the next candidates
/// when the version switch happens.
const acceptedRuntimeVersions = <String>[
  // The current [runtimeVersion].
  '2022.11.02',
  // Fallback runtime versions.
  '2022.10.27',
  '2022.09.29',
];

/// Represents a combined version of the overall toolchain and processing,
/// allowing easy check for data compatibility, age comparison and also reflects
/// whether an analysis needs to be re-done.
///
/// Increment the version when a change is significant enough to trigger
/// reprocessing, including: risk of data corruption in analysis, version change
/// in pana, dartdoc, or the SDKs, or when an feature or bugfix should be picked
/// up by the analysis ASAP.
final String runtimeVersion = acceptedRuntimeVersions.first;

/// The list of runtime versions to use when looking for past version-specific
/// data.
final fallbackRuntimeVersions = acceptedRuntimeVersions.skip(1).toList();

/// The version which marks the earliest version of the data which we'd like to
/// keep during various GC processes. Data prior to this version is subject to
/// delete (unless there is another rule in place to keep it).
final gcBeforeRuntimeVersion = acceptedRuntimeVersions.last;

/// Returns true if the given version should be considered as obsolete and can
/// be deleted.
bool shouldGCVersion(String version) =>
    version.compareTo(gcBeforeRuntimeVersion) < 0;

// keep in-sync with SDK version in .mono_repo.yml and Dockerfile
final String runtimeSdkVersion = '2.18.0';
final String toolStableDartSdkVersion = '2.18.4';
final String toolStableFlutterSdkVersion = '3.3.7';
final String toolPreviewDartSdkVersion = '2.19.0-255.2.beta';
final String toolPreviewFlutterSdkVersion = '3.4.0-34.1.pre';

final semanticToolStableDartSdkVersion =
    Version.parse(toolStableDartSdkVersion);
final semanticToolStableFlutterSdkVersion =
    Version.parse(toolStableFlutterSdkVersion);

// Value comes from package:pana.
final String panaVersion = pana.packageVersion;

// keep in-sync with pkg/pub_dartdoc/pubspec.yaml
final String dartdocVersion = '6.1.1';

/// Whether the given runtime version (stored with the dartdoc entry) should
/// be displayed on the live site (or a coordinated upgrade is in progress).
bool shouldServeDartdoc(String? storedRuntimeVersion) {
  if (storedRuntimeVersion == null) return false;
  return acceptedRuntimeVersions.contains(storedRuntimeVersion);
}
