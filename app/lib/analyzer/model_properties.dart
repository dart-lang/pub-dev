// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';

import '../shared/analyzer_service.dart'
    show AnalysisStatus, analysisStatusCodec;

class AnalysisStatusProperty extends StringProperty {
  const AnalysisStatusProperty({String propertyName, bool required: false})
      : super(propertyName: propertyName, required: required, indexed: true);

  @override
  bool validate(ModelDB db, Object value) =>
      (!required || value != null) &&
      (value == null || value is AnalysisStatus);

  @override
  String encodeValue(ModelDB db, Object value, {bool forComparison: false}) {
    if (value is AnalysisStatus) {
      return analysisStatusCodec.encode(value);
    }
    return null;
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value is String) {
      return analysisStatusCodec.decode(value);
    }
    if (value == null) return null;
    throw new Exception('Unknown analysis status: $value');
  }
}
