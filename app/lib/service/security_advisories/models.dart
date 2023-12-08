// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show json;

import 'package:_pub_shared/data/advisories_api.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../shared/datastore.dart' as db;

part 'models.g.dart';

/// [SecurityAdvisory] is used to store a security advisory.
///
///  * `id`, is a unique identifier for the advisory.
///  * `SecurityAdvisory` entities never have a parent (`_db.emptyKey`).
@db.Kind(name: 'SecurityAdvisory', idType: db.IdType.String)
class SecurityAdvisory extends db.Model<String> {
  String get name => id!;

  /// A list of IDs of the same vulnerability in other databases, including
  /// the main id.
  ///
  /// Whether an ID is a primary ID or an alias is not important. So long as there is
  /// a unique primary ID, and aliases do not conflict with other advisories.
  @db.StringListProperty()
  List<String> aliases = <String>[];

  /// The time this entry was published.
  /// If no date is provided, we use [modified].
  @db.DateTimeProperty(required: true)
  DateTime? published;

  /// The time this entry was last modified.
  @db.DateTimeProperty(required: true)
  DateTime? modified;

  /// The time this advisory was synced into datastore.
  @db.DateTimeProperty(required: true)
  DateTime? syncTime;

  /// A list of affected package names.
  @db.StringListProperty()
  List<String>? affectedPackages = <String>[];

  @OSVProperty(required: true)
  OSV? osv;
}

class OSVProperty extends db.Property {
  const OSVProperty({String? propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: false);

  @override
  Object? decodePrimitiveValue(db.ModelDB db, Object? value) {
    if (value == null) return null;
    return OSV.fromJson(json.decode(value as String) as Map<String, dynamic>);
  }

  @override
  Object? encodeValue(db.ModelDB db, Object? value,
      {bool forComparison = false}) {
    return json.encode(value);
  }

  @override
  bool validate(db.ModelDB db, Object? value) {
    return super.validate(db, value) && (value == null || value is OSV);
  }
}

/// The cacheable version of [SecurityAdvisory]
@JsonSerializable()
class SecurityAdvisoryData {
  final OSV advisory;

  /// The time this advisory was synced into datastore.
  final DateTime syncTime;

  SecurityAdvisoryData(this.advisory, this.syncTime);

  factory SecurityAdvisoryData.fromJson(Map<String, dynamic> json) =>
      _$SecurityAdvisoryDataFromJson(json);
  Map<String, dynamic> toJson() => _$SecurityAdvisoryDataToJson(this);

  factory SecurityAdvisoryData.fromModel(SecurityAdvisory advisory) =>
      SecurityAdvisoryData(advisory.osv!, advisory.syncTime!);
}
