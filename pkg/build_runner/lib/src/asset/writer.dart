import 'dart:async';

import 'package:build/build.dart';

typedef void OnDelete(AssetId id);

abstract class RunnerAssetWriter implements AssetWriter {
  Future delete(AssetId id);
}
