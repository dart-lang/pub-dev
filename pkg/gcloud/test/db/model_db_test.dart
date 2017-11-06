// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.db_impl_test;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:unittest/unittest.dart';

import 'model_dbs/duplicate_fieldname.dart' as test4;
import 'model_dbs/duplicate_kind.dart' as test1;
import 'model_dbs/duplicate_property.dart' as test2;
import 'model_dbs/multiple_annotations.dart' as test3;
import 'model_dbs/no_default_constructor.dart' as test5;

main() {
  // These unused imports make sure that [ModelDBImpl.fromLibrary()] will find
  // all the Model/ModelDescription classes.
  assert([test1.A, test2.A, test3.A, test4.A, test5.A] != null);

  newModelDB(Symbol symbol) => new ModelDBImpl.fromLibrary(symbol);

  group('model_db', () {
    group('from_library', () {
      test('duplicate_kind', () {
        expect(new Future.sync(() {
          newModelDB(#gcloud.db.model_test.duplicate_kind);
        }), throwsA(isStateError));
      });
      test('duplicate_property', () {
        expect(new Future.sync(() {
          newModelDB(#gcloud.db.model_test.duplicate_property);
        }), throwsA(isStateError));
      });
      test('multiple_annotations', () {
        expect(new Future.sync(() {
          newModelDB(#gcloud.db.model_test.multiple_annotations);
        }), throwsA(isStateError));
      });
      test('duplicate_fieldname', () {
        expect(new Future.sync(() {
          newModelDB(#gcloud.db.model_test.duplicate_fieldname);
        }), throwsA(isStateError));
      });
      test('no_default_constructor', () {
        expect(new Future.sync(() {
          newModelDB(#gcloud.db.model_test.no_default_constructor);
        }), throwsA(isStateError));
      });
    });
  });
}
