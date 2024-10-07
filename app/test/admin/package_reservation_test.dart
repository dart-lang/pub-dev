// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/admin_api.dart';
import 'package:clock/clock.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:test/test.dart';

import '../package/backend_test_utils.dart';
import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

void main() {
  group('Reserve package', () {
    Future<void> _reserve(
      String package, {
      List<String>? emails,
    }) async {
      final api = createPubApiClient(authToken: siteAdminToken);
      await api.adminInvokeAction(
        'package-reservation-create',
        AdminInvokeActionArguments(arguments: {
          'package': package,
          if (emails != null) 'emails': emails.join(','),
        }),
      );
    }

    testWithProfile('cannot reserve existing package', fn: () async {
      await expectApiException(
        _reserve('oxygen'),
        code: 'InvalidInput',
        status: 400,
        message: 'Package `oxygen` exists.',
      );
    });

    testWithProfile('cannot reserve ModeratedPackage', fn: () async {
      await dbService.commit(inserts: [
        ModeratedPackage()
          ..id = 'pkg'
          ..name = 'pkg'
          ..moderated = clock.now()
          ..uploaders = <String>[]
          ..versions = <String>['1.0.0']
      ]);
      await expectApiException(
        _reserve('pkg'),
        code: 'InvalidInput',
        status: 400,
        message: 'ModeratedPackage `pkg` exists.',
      );
    });

    testWithProfile('prevents non-whitelisted publishing', fn: () async {
      await _reserve('pkg');

      final pubspecContent = generatePubspecYaml('pkg', '1.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      await expectApiException(
        createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(bytes),
        code: 'PackageRejected',
        status: 400,
        message: 'Package name pkg is reserved.',
      );
    });

    testWithProfile('allows whitelisted publishing', fn: () async {
      await _reserve('pkg');
      // update email addresses in a second request
      await _reserve('pkg', emails: ['admin@pub.dev']);

      final pubspecContent = generatePubspecYaml('pkg', '1.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      await createPubApiClient(authToken: adminClientToken)
          .uploadPackageBytes(bytes);

      final rp = await packageBackend.lookupReservedPackage('pkg');
      expect(rp, isNull);
    });

    testWithProfile('no longer allows Dart-team exemption', fn: () async {
      await _reserve('pkg');

      final pubspecContent = generatePubspecYaml('pkg', '1.0.0');
      final bytes = await packageArchiveBytes(pubspecContent: pubspecContent);
      await expectApiException(
        createPubApiClient(authToken: adminClientToken)
            .uploadPackageBytes(bytes),
        code: 'PackageRejected',
        status: 400,
        message: 'Package name pkg is reserved.',
      );
    });
  });
}
