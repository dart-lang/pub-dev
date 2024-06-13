// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert' show json;

import '../../shared/datastore.dart' as db;
import 'download_counts.dart';

@db.Kind(name: 'DownloadCounts', idType: db.IdType.String)
class DownloadCounts extends db.ExpandoModel<String> {
  String get package => id!;

  @CountDataProperty(required: true)
  CountData countData = CountData.empty();
}

class CountDataProperty extends db.Property {
  const CountDataProperty({String? propertyName, bool required = false})
      : super(propertyName: propertyName, required: required, indexed: false);

  @override
  Object? decodePrimitiveValue(db.ModelDB db, Object? value) {
    if (value == null) return null;
    return CountData.fromJson(
        json.decode(value as String) as Map<String, dynamic>);
  }

  @override
  Object? encodeValue(db.ModelDB db, Object? value,
      {bool forComparison = false}) {
    return json.encode(value);
  }

  @override
  bool validate(db.ModelDB db, Object? value) {
    return super.validate(db, value) && (value == null || value is CountData);
  }
}
