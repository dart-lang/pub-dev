// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import 'package:pub_dev/package/backend.dart';

import '../shared/test_services.dart';

void main() {
  group('Retractions', () {
    testWithProfile('lists', fn: () async {
      final r1 = await packageBackend.listRetractableVersions('oxygen');
      expect(r1.map((pv) => pv.version), ['1.0.0', '1.2.0', '2.0.0-dev']);
      final u1 = await packageBackend.listRecentlyRetractedVersions('oxygen');
      expect(u1, isEmpty);

      // wait too long for retractions'
      final pv1 = await packageBackend.lookupPackageVersion('oxygen', '1.0.0');
      pv1!.created = pv1.created!.subtract(Duration(days: 7));
      await dbService.commit(inserts: [pv1]);

      final r2 = await packageBackend.listRetractableVersions('oxygen');
      expect(r2.map((pv) => pv.version), ['1.2.0', '2.0.0-dev']);
      final u2 = await packageBackend.listRecentlyRetractedVersions('oxygen');
      expect(u2, isEmpty);

      // retracted
      final pv2 = await packageBackend.lookupPackageVersion('oxygen', '1.2.0');
      pv2!.isRetracted = true;
      pv2.retracted = pv2.created!.subtract(Duration(days: 6));
      await dbService.commit(inserts: [pv2]);

      final r3 = await packageBackend.listRetractableVersions('oxygen');
      expect(r3.map((pv) => pv.version), ['2.0.0-dev']);
      final u3 = await packageBackend.listRecentlyRetractedVersions('oxygen');
      expect(u3.map((pv) => pv.version), ['1.2.0']);

      // wait too long after retraction
      pv2.retracted = pv2.created!.subtract(Duration(days: 8));
      await dbService.commit(inserts: [pv2]);

      final r4 = await packageBackend.listRetractableVersions('oxygen');
      expect(r4.map((pv) => pv.version), ['2.0.0-dev']);
      final u4 = await packageBackend.listRecentlyRetractedVersions('oxygen');
      expect(u4, isEmpty);
    });

    // TODO: test API calls
  });
}
