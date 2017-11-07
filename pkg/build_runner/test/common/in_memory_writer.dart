// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.
import 'dart:async';

import 'package:build/build.dart';
import 'package:build_runner/build_runner.dart';
import 'package:build_test/build_test.dart';

typedef void OnDelete(AssetId id);

class InMemoryRunnerAssetWriter extends InMemoryAssetWriter
    implements RunnerAssetWriter {
  OnDelete onDelete;

  @override
  Future delete(AssetId id) async {
    if (onDelete != null) onDelete(id);
    assets.remove(id);
  }
}
