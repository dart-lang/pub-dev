// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pana.version;

import 'package:pub_semver/pub_semver.dart';

import 'annotations.dart';

part 'version.g.dart';

@PackageVersion()
Version get panaPkgVersion => _$panaPkgVersionPubSemverVersion;
