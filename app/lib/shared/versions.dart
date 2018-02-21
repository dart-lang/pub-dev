// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_semver/pub_semver.dart';

// keep in-sync with app/pubspec.yaml
final String panaVersion = '0.10.2';
final Version semanticPanaVersion = new Version.parse(panaVersion);

// keep in-sync with app/script/setup-flutter.sh
final String flutterVersion = '0.0.22';
final Version semanticFlutterVersion = new Version.parse(flutterVersion);

// keep in-sync with SDK version in .travis.yml and Dockerfile
final String dartdocVersion = '0.16.0';
final Version semanticDartdocVersion = new Version.parse(dartdocVersion);

/// The version of our customization going into the output of the dartdoc static
/// HTML files.
final String customizationVersion = '0.0.1';
final Version semanticCustomizationVersion =
    new Version.parse(customizationVersion);
