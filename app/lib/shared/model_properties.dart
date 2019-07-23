// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';

/// Similar to [ListProperty] but one which is fully compatible with python's
/// 'db' implementation.
class CompatibleListProperty<T> extends Property {
  final PrimitiveProperty subProperty;

  const CompatibleListProperty(this.subProperty,
      {String propertyName, bool indexed = true})
      : super(propertyName: propertyName, required: true, indexed: indexed);

  @override
  bool validate(ModelDB db, Object value) {
    if (!super.validate(db, value) || value is! List) return false;

    for (var entry in value) {
      if (!subProperty.validate(db, entry)) return false;
    }
    return true;
  }

  @override
  Object encodeValue(ModelDB db, Object value, {bool forComparison = false}) {
    if (forComparison) {
      return subProperty.encodeValue(db, value, forComparison: true);
    }

    // NOTE: As opposed to [ListProperty] we will encode
    //    - `null` as `[]`  (as opposed to `null`)
    //    - `[]` as `[]`  (as opposed to `null`)
    //    - `[a]` as `[a]` (as opposed to `a`)
    if (value == null) return [];
    final list = value as List;
    if (list.isEmpty) return [];
    if (list.length == 1) return [subProperty.encodeValue(db, list[0])];
    return list.map((value) => subProperty.encodeValue(db, value)).toList();
  }

  @override
  List<T> decodePrimitiveValue(ModelDB db, Object value) {
    if (value == null) return <T>[];
    if (value is! List) {
      return [subProperty.decodePrimitiveValue(db, value)].cast<T>();
    }
    return (value as List)
        .map((entry) => subProperty.decodePrimitiveValue(db, entry))
        .cast<T>()
        .toList();
  }
}

/// Similar to [StringListProperty] but one which is fully compatible with
/// python's 'db' implementation.
class CompatibleStringListProperty extends CompatibleListProperty<String> {
  const CompatibleStringListProperty({String propertyName, bool indexed = true})
      : super(const StringProperty(required: true),
            propertyName: propertyName, indexed: indexed);
}
