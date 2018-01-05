// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dartlang_org/analyzer/model_properties.dart';
import 'package:pub_dartlang_org/shared/analyzer_service.dart';

void main() {
  group('AnalysisStatus', () {
    test('serialization', () {
      final property = new AnalysisStatusProperty();
      for (var status in AnalysisStatus.values) {
        final serialized = property.encodeValue(null, status);
        expect(serialized, isNotNull);
        expect(serialized, isNotEmpty);
        final deserialized = property.decodePrimitiveValue(null, serialized);
        expect(deserialized, status);
      }
    });
  });
}
