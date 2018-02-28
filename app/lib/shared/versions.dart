// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_semver/pub_semver.dart';

import 'utils.dart' show isNewer;

// keep in-sync with app/pubspec.yaml
final String panaVersion = '0.10.3';
final Version semanticPanaVersion = new Version.parse(panaVersion);

// keep in-sync with app/script/setup-flutter.sh
final String flutterVersion = '0.1.4';
final Version semanticFlutterVersion = new Version.parse(flutterVersion);

// keep in-sync with SDK version in .travis.yml and Dockerfile
final String dartdocVersion = '0.16.0';
final Version semanticDartdocVersion = new Version.parse(dartdocVersion);

/// The version of our customization going into the output of the dartdoc static
/// HTML files.
final String customizationVersion = '0.0.1';
final Version semanticCustomizationVersion =
    new Version.parse(customizationVersion);

// Versions that control the dartdoc serving.
final _dartdocVersion = new Version.parse('0.16.0');
final _dartdocFlutter = new Version.parse('0.1.4');
final _dartdocCustomization = new Version.parse('0.0.1');

/// Whether the given [dartdoc], [flutter] and [customization] versions should
/// be displayed on the live site (or a coordinated upgrade is in progress).
bool shouldServeDartdoc(String dartdoc, String flutter, String customization) =>
    !isNewer(_dartdocVersion, new Version.parse(dartdoc)) &&
    !isNewer(_dartdocFlutter, new Version.parse(flutter)) &&
    !isNewer(_dartdocCustomization, new Version.parse(customization));
