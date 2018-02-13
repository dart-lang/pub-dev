// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';

import '../shared/analyzer_service.dart' show AnalysisStatus;

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
      switch (value) {
        case AnalysisStatus.aborted:
          return 'aborted';
        case AnalysisStatus.failure:
          return 'failure';
        case AnalysisStatus.success:
          return 'success';
        case AnalysisStatus.deprecated:
          return 'deprecated';
        case AnalysisStatus.outdated:
          return 'outdated';
        default:
          throw new Exception('Unable to encode AnalysisStatus: $value');
      }
    }
    return null;
  }

  @override
  Object decodePrimitiveValue(ModelDB db, Object value) {
    if (value == null) return null;
    if (value is String) {
      switch (value) {
        case 'aborted':
          return AnalysisStatus.aborted;
        case 'failure':
          return AnalysisStatus.failure;
        case 'success':
          return AnalysisStatus.success;
        case 'deprecated':
          return AnalysisStatus.deprecated;
        case 'outdated':
          return AnalysisStatus.outdated;
        default:
          throw new Exception('Unable to decode AnalysisStatus: $value');
      }
    }
    throw new Exception('Unknown analysis status: $value');
  }
}
