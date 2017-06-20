// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart';

/// These status codes mark the status of the analysis, not the result/report.
///
/// WARNING: Do not rename these enum values, since they are stored in the DB.
enum AnalysisStatus {
  /// Analysis was aborted without a report.
  /// Probably an issue with pana or an unhandled edge case.
  aborted,

  /// Analysis was completed but there are missing parts.
  /// One or more tools failed to produce the expected output.
  failure,

  /// Analysis was completed without issues.
  success,
}

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
      return value.toString().split('.').last;
    }
    return null;
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value is String) {
      return AnalysisStatus.values
          .firstWhere((as) => as.toString().endsWith('.$value'));
    }
    if (value == null) return null;
    throw new Exception('Unknown analysis status: $value');
  }
}
