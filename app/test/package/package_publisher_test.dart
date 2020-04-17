// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:gcloud/db.dart';
import 'package:test/test.dart';

import 'package:client_data/package_api.dart';
import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/shared/exceptions.dart';

import '../shared/handlers_test_utils.dart';
import '../shared/test_models.dart';
import '../shared/test_services.dart';

import 'backend_test_utils.dart';

void main() {
  group('Get publisher info', () {
    _testNoPackage((client) => client.getPackagePublisher('no_package'));

    testWithServices('traditional package, not authenticated user', () async {
      final client = createPubApiClient();
      final rs = await client.getPackagePublisher('hydrogen');
      expect(rs.toJson(), {'publisherId': null});
    });
  });

  group('Set publisher for a traditional package', () {
    _testNoPackage((client) => client.setPackagePublisher(
          'no_package',
          PackagePublisherInfo(publisherId: 'no-domain.net'),
        ));

    _testNoPublisher((client) => client.setPackagePublisher(
          hydrogen.package.name,
          PackagePublisherInfo(publisherId: 'no-domain.net'),
        ));

    _testPublisherAdminAuthIssues(
      exampleComPublisher.key,
      (client) => client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'example.com'),
      ),
    );

    testWithServices('User is not an uploader', () async {
      final p = await packageBackend.lookupPackage('hydrogen');
      p.uploaders = [joeUser.userId];
      await dbService.commit(inserts: [p]);

      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'example.com'),
      );
      await expectApiException(rs,
          status: 403, code: 'InsufficientPermissions');
    });

    testWithServices('successful', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'example.com'),
      );
      expect(_json(rs.toJson()), {'publisherId': 'example.com'});

      final p = await packageBackend.lookupPackage('hydrogen');
      expect(p.publisherId, 'example.com');
      expect(p.uploaders, []);

      final info = await client.getPackagePublisher('hydrogen');
      expect(_json(info.toJson()), _json(rs.toJson()));
    });
  });

  group('Upload with a publisher', () {
    testWithServices('not an admin', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      await client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'example.com'),
      );
      await dbService.commit(inserts: [
        publisherMember(hansUser.userId, 'non-admin'),
      ]);
      registerAuthenticatedUser(hansUser);
      final tarball = await packageArchiveBytes(
          pubspecContent: generatePubspecYaml('hydrogen', '3.0.0'));
      final rs = packageBackend.upload(Stream.fromIterable([tarball]));
      await expectLater(
          rs,
          throwsA(isA<AuthorizationException>()
              .having((a) => a.code, 'code', 'InsufficientPermissions')));
    });

    testWithServices('successful', () async {
      final client = createPubApiClient(authToken: hansUser.userId);
      await client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'example.com'),
      );
      registerAuthenticatedUser(hansUser);
      final tarball = await packageArchiveBytes(
          pubspecContent: generatePubspecYaml('hydrogen', '3.0.0'));
      final pv = await packageBackend.upload(Stream.fromIterable([tarball]));
      expect(pv.version.toString(), '3.0.0');
    });
  });

  group('Move between publishers', () {
    final otherComPublisher = publisher('other.com');
    Future<void> _setup({bool addHans = true}) async {
      final p = await packageBackend.lookupPackage(hydrogen.package.name);
      p.publisherId = otherComPublisher.publisherId;
      p.uploaders = [];
      final hansMember = publisherMember(hansUser.userId, 'admin',
          parentKey: otherComPublisher.key);
      final otherMember = publisherMember(testUserA.userId, 'admin',
          parentKey: otherComPublisher.key);
      await dbService.commit(inserts: [
        p,
        otherComPublisher,
        if (addHans) hansMember,
        otherMember,
      ]);
    }

    _testNoPackage((client) async {
      await _setup();
      return client.setPackagePublisher(
        'no_package',
        PackagePublisherInfo(publisherId: 'no-domain.net'),
      );
    });

    _testNoPublisher((client) async {
      await _setup();
      return client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'no-domain.net'),
      );
    });

    _testPublisherAdminAuthIssues(exampleComPublisher.key, (client) async {
      await _setup();
      return client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'example.com'),
      );
    });

    _testPublisherAdminAuthIssues(otherComPublisher.key, (client) async {
      await _setup(addHans: false);
      return client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'example.com'),
      );
    });

    testWithServices('successful', () async {
      await _setup();
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = await client.setPackagePublisher(
        hydrogen.package.name,
        PackagePublisherInfo(publisherId: 'example.com'),
      );
      expect(_json(rs.toJson()), {'publisherId': 'example.com'});

      final p = await packageBackend.lookupPackage('hydrogen');
      expect(p.publisherId, 'example.com');
      expect(p.uploaders, []);

      final info = await client.getPackagePublisher('hydrogen');
      expect(_json(info.toJson()), _json(rs.toJson()));
    });
  });

  group('Delete publisher', () {
    Future<void> _setupPackage() async {
      final p = await packageBackend.lookupPackage(hydrogen.package.name);
      p.publisherId = 'example.com';
      p.uploaders = [];
      await dbService.commit(inserts: [p]);
    }

    _testNoPackage((client) async {
      await _setupPackage();
      return client.removePackagePublisher('no_package');
    });

    _testPublisherAdminAuthIssues(exampleComPublisher.key, (client) async {
      await _setupPackage();
      return client.removePackagePublisher(hydrogen.package.name);
    });

    testWithServices('successful', () async {
      await _setupPackage();
      final client = createPubApiClient(authToken: hansUser.userId);
      final rs = client.removePackagePublisher(hydrogen.package.name);
      await expectApiException(rs, status: 501);
//  Code commented out while we decide if this feature is something we want to
//  support going forward.
//
//      final rs = await client.removePackagePublisher(hydrogen.package.name);
//      expect(_json(rs.toJson()), {'publisherId': null});
//
//      final p = await packageBackend.lookupPackage('hydrogen');
//      expect(p.publisherId, isNull);
//      expect(p.uploaders, [hansUser.userId]);
//
//      final info = await client.getPackagePublisher('hydrogen');
//      expect(_json(info.toJson()), _json(rs.toJson()));
    });
  });
}

dynamic _json(value) => json.decode(json.encode(value));

void _testPublisherAdminAuthIssues(
    Key publisherKey, Future<void> Function(PubApiClient client) fn) {
  testWithServices('No active user (${publisherKey.id})', () async {
    final client = createPubApiClient();
    final rs = fn(client);
    await expectApiException(rs,
        status: 401,
        code: 'MissingAuthentication',
        message: 'please add `authorization` header');
  });

  testWithServices(
      'Active user is not a member of publisher (${publisherKey.id})',
      () async {
    await dbService.commit(inserts: [
      publisherMember(joeUser.userId, 'admin', parentKey: publisherKey)
    ], deletes: [
      publisherKey.append(PublisherMember, id: hansUser.userId)
    ]);
    final client = createPubApiClient(authToken: hansUser.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });

  testWithServices(
      'Active user is not an admin of the publisher (${publisherKey.id})',
      () async {
    await dbService.commit(inserts: [
      publisherMember(hansUser.userId, 'non-admin', parentKey: publisherKey),
    ]);
    final client = createPubApiClient(authToken: hansUser.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });
}

void _testNoPackage(Future Function(PubApiClient client) fn) {
  testWithServices('No puackage with given name', () async {
    final client = createPubApiClient(authToken: hansUser.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 404, code: 'NotFound');
  });
}

void _testNoPublisher(Future Function(PubApiClient client) fn) {
  testWithServices('No publisher with given id', () async {
    final client = createPubApiClient(authToken: hansUser.userId);
    final rs = fn(client);
    await expectApiException(rs, status: 404, code: 'NotFound');
  });
}
