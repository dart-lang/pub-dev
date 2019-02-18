// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' as convert;

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';

import '../shared/redis_cache.dart';

import 'models.dart';

final Logger _logger = new Logger('pub.scorecard_memcache');

/// Sets the ScoreCard memcache.
void registerScoreCardMemcache(ScoreCardMemcache value) =>
    ss.register(#_scoreCardMemcache, value);

/// The active ScoreCard memcache.
ScoreCardMemcache get scoreCardMemcache =>
    ss.lookup(#_scoreCardMemcache) as ScoreCardMemcache;

class ScoreCardMemcache {
  final SimpleMemcache _data;

  ScoreCardMemcache()
      : _data = new SimpleMemcache(
          'ScoreCardMemcache/',
          _logger,
          Duration(minutes: 60),
        );

  Future<ScoreCardData> getScoreCardData(
      String packageName, String packageVersion) async {
    final content = await _data.getText(_dataKey(packageName, packageVersion));
    if (content == null) {
      return null;
    }
    return new ScoreCardData.fromJson(
        convert.json.decode(content) as Map<String, dynamic>);
  }

  Future setScoreCardData(ScoreCardData data) async {
    if (!data.isCurrent) {
      return;
    }
    await _data.setText(_dataKey(data.packageName, data.packageVersion),
        convert.json.encode(data.toJson()));
  }

  Future invalidate(String package, String version) async {
    await _data.invalidate(_dataKey(package, version));
  }

  String _dataKey(String package, String version) => '/$package/$version';
}
