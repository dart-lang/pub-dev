// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/shared/urls.dart' as urls;
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:test/test.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('editor api', () {
    testWithProfile('/api/packages', fn: () async {
      await expectJsonResponse(
        await issueGet('/api/packages', host: urls.legacyHost),
        body: {
          'next_url': null,
          'packages': [
            {
              'name': 'oxygen',
              'latest': {
                'version': '1.2.0',
                'pubspec': {
                  'name': 'oxygen',
                  'version': '1.2.0',
                  'description': 'oxygen is awesome',
                  'homepage': 'https://oxygen.example.dev/',
                  'repository': 'https://github.com/example/oxygen',
                  'environment': {'sdk': isNotEmpty},
                  'dependencies': {},
                  'screenshots': [
                    {
                      'path': 'static.webp',
                      'description': 'This is an awesome screenshot'
                    }
                  ],
                  'funding': isNotEmpty,
                  'topics': ['chemical-element'],
                },
                'archive_url':
                    '${activeConfiguration.primaryApiUri}/packages/oxygen/versions/1.2.0.tar.gz',
                'package_url':
                    '${activeConfiguration.primaryApiUri}/api/packages/oxygen',
                'url':
                    '${activeConfiguration.primaryApiUri}/api/packages/oxygen/versions/1.2.0'
              }
            },
            {
              'name': 'flutter_titanium',
              'latest': {
                'version': '1.10.0',
                'pubspec': {
                  'name': 'flutter_titanium',
                  'version': '1.10.0',
                  'description': 'flutter_titanium is awesome',
                  'homepage': 'https://flutter_titanium.example.dev/',
                  'repository': 'https://github.com/example/flutter_titanium',
                  'environment': {'sdk': isNotEmpty},
                  'dependencies': {
                    'flutter': {'sdk': 'flutter'}
                  },
                  'screenshots': [
                    {
                      'path': 'static.webp',
                      'description': 'This is an awesome screenshot'
                    }
                  ],
                  'funding': isNotEmpty,
                  'topics': ['chemical-element'],
                },
                'archive_url':
                    '${activeConfiguration.primaryApiUri}/packages/flutter_titanium/versions/1.10.0.tar.gz',
                'package_url':
                    '${activeConfiguration.primaryApiUri}/api/packages/flutter_titanium',
                'url':
                    '${activeConfiguration.primaryApiUri}/api/packages/flutter_titanium/versions/1.10.0'
              }
            },
            {
              'name': 'neon',
              'latest': {
                'version': '1.0.0',
                'pubspec': {
                  'name': 'neon',
                  'version': '1.0.0',
                  'description': 'neon is awesome',
                  'homepage': 'https://neon.example.dev/',
                  'repository': 'https://github.com/example/neon',
                  'environment': {'sdk': isNotEmpty},
                  'dependencies': {},
                  'screenshots': [
                    {
                      'path': 'static.webp',
                      'description': 'This is an awesome screenshot'
                    }
                  ],
                  'funding': isNotEmpty,
                  'topics': ['chemical-element'],
                },
                'archive_url':
                    '${activeConfiguration.primaryApiUri}/packages/neon/versions/1.0.0.tar.gz',
                'package_url':
                    '${activeConfiguration.primaryApiUri}/api/packages/neon',
                'url':
                    '${activeConfiguration.primaryApiUri}/api/packages/neon/versions/1.0.0'
              }
            }
          ]
        },
      );
    });

    testWithProfile('/api/package-names', fn: () async {
      final rs = await http.get(activeConfiguration.primaryApiUri!
          .replace(path: '/api/package-names'));
      await expectJsonResponse(
        shelf.Response(rs.statusCode, body: rs.body, headers: rs.headers),
        body: {
          'packages': containsAll([
            'neon',
            'oxygen',
          ]),
          'nextUrl': null,
        },
      );
    });

    testWithProfile('/api/package-names - only valid packages', fn: () async {
      final rs1 = await http.get(activeConfiguration.primaryApiUri!
          .replace(path: '/api/package-names'));
      await expectJsonResponse(
        shelf.Response(rs1.statusCode, body: rs1.body, headers: rs1.headers),
        body: {
          'packages': contains('neon'),
          'nextUrl': null,
        },
      );
      final p = await packageBackend.lookupPackage('neon');
      p!.updateIsBlocked(isBlocked: true, reason: 'spam');
      expect(p.isVisible, isFalse);
      await dbService.commit(inserts: [p]);
      await nameTracker.reloadFromDatastore();
      await cache.packageNamesDataJsonGz().purge();
      final rs2 = await http.get(activeConfiguration.primaryApiUri!
          .replace(path: '/api/package-names'));
      await expectJsonResponse(
        shelf.Response(rs2.statusCode, body: rs2.body, headers: rs2.headers),
        body: {
          'packages': isNot(contains('neon')),
          'nextUrl': null,
        },
      );
    });
  });

  group('score API', () {
    testWithProfile(
      '/api/packages/<package>/score endpoint',
      processJobsWithFakeRunners: true,
      fn: () async {
        final rs = await issueGet('/api/packages/oxygen/score');
        final map = json.decode(await rs.readAsString());
        expect(map, {
          'grantedPoints': greaterThan(10),
          'maxPoints': greaterThan(50),
          'likeCount': 0,
          'popularityScore': greaterThan(0),
          'tags': contains('sdk:dart'),
          'lastUpdated': isNotEmpty,
        });
      },
    );
  });

  group('documentation', () {
    testWithProfile(
      'many versions',
      testProfile: TestProfile(
        packages: [
          TestPackage(
            name: 'pkg',
            versions: List.generate(
              99,
              (index) => TestVersion(version: '1.$index.0'),
            ),
          ),
        ],
        defaultUser: 'user@pub.dev',
      ),
      fn: () async {
        await taskBackend.backfillTrackingState();
        final rs = await issueGet('/api/documentation/pkg');
        expect(rs.statusCode, 200);
        final body = await rs.readAsString();
        expect(body, contains('1.98.0'));
      },
      timeout: Timeout(Duration(minutes: 2)),
      skip: true, // Until we have figure out how to make fake task analysis
    );
  });
}
