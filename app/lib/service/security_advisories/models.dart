// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/advisories_api.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../database/schema.dart';
import '../../shared/datastore.dart' as db;

part 'models.g.dart';

/// Legacy Datastore entity of the security advisory, now stored only in SQL.
///
/// TODO: Remove Datastore entity in a future release.
@db.Kind(name: 'SecurityAdvisory', idType: db.IdType.String)
class SecurityAdvisory extends db.ExpandoModel<String> {}

/// The cacheable version of [SecurityAdvisory]
@JsonSerializable()
class SecurityAdvisoryData {
  final OSV advisory;

  /// The time this advisory was synced.
  final DateTime syncTime;

  SecurityAdvisoryData(this.advisory, this.syncTime);

  factory SecurityAdvisoryData.fromJson(Map<String, dynamic> json) =>
      _$SecurityAdvisoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$SecurityAdvisoryDataToJson(this);

  factory SecurityAdvisoryData.fromRow(SecurityAdvisoryRow row) =>
      SecurityAdvisoryData(row.osv, row.syncedAt);
}

extension SecurityAdvisoryRowExt on SecurityAdvisoryRow {
  OSV get osv => OSV.fromJson((osvJson.value as Map).cast<String, dynamic>());

  /// The advisory id and its aliases.
  List<String> get aliases => [advisoryId, ...osv.aliases];

  /// The names of the affected `pub` packages.
  List<String> get affectedPackages => osv.affectedPubPackages;
}

extension OsvPubExt on OSV {
  /// The names of the affected `pub` packages.
  List<String> get affectedPubPackages => (affected ?? [])
      .where((a) => a.package.ecosystem.toLowerCase() == 'pub')
      .map((a) => a.package.name)
      .toList();
}
