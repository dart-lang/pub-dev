// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart' as db;

import 'package:pub_dev/package/models.dart' show Package, PackageVersion;
import '../shared/versions.dart' as versions;

import 'models.dart';

db.Key scoreCardKey(
  String packageName,
  String packageVersion, {
  String runtimeVersion,
}) {
  runtimeVersion ??= versions.runtimeVersion;
  return db.dbService.emptyKey
      .append(Package, id: packageName)
      .append(PackageVersion, id: packageVersion)
      .append(ScoreCard, id: runtimeVersion);
}
