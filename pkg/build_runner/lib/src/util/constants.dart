// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:io';

import 'package:crypto/crypto.dart';

/// Relative path to the asset graph from the root package dir.
final String assetGraphPath = '$cacheDir/$scriptHash/asset_graph.json';

/// Directories used for build tooling.
///
/// Reading from these directories may cause non-hermetic builds.
const toolDirs = const ['.dart_tool', 'build', 'packages', '.pub'];

/// The directory to which assets will be written when `writeToCache` is
/// enabled.
const generatedOutputDirectory = '.dart_tool/build/generated';

/// Relative path to the cache directory from the root package dir.
const String cacheDir = '.dart_tool/build';

final String scriptHash =
    md5.convert(Platform.script.path.codeUnits).toString();
