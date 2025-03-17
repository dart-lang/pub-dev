// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/utils/sdk_version_cache.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  final futureSdkVersion = Version.parse('3.99.0');
  group('SDK version changing', () {
    late Version currentSdkVersion;

    setUpAll(() async {
      final current = await getCachedDartSdkVersion(
          lastKnownStable: toolStableDartSdkVersion);
      currentSdkVersion = current.semanticVersion;
    });

    test('verify versions', () async {
      expect(currentSdkVersion.major, greaterThan(0));
      expect(futureSdkVersion.major, currentSdkVersion.major);
    });

    testWithProfile(
      'preview becomes stable',
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(name: 'pkg', versions: [
            GeneratedTestVersion(version: '1.0.0'),
            GeneratedTestVersion(
              version: '1.2.0',
              template: TestArchiveTemplate(
                sdkConstraint: futureSdkVersion.toString(),
              ),
            ),
          ]),
        ],
      ),
      fn: () async {
        final pv1 =
            (await packageBackend.lookupPackageVersion('pkg', '1.0.0'))!;
        expect(
            pv1.pubspec!.isPreviewForCurrentSdk(
              dartSdkVersion: currentSdkVersion,
              flutterSdkVersion: Version(3, 20, 0),
            ),
            isFalse);
        expect(
            pv1.pubspec!.isPreviewForCurrentSdk(
              dartSdkVersion: futureSdkVersion,
              flutterSdkVersion: Version(3, 20, 0),
            ),
            isFalse);

        final pv2 =
            (await packageBackend.lookupPackageVersion('pkg', '1.2.0'))!;
        expect(
            pv2.pubspec!.isPreviewForCurrentSdk(
              dartSdkVersion: currentSdkVersion,
              flutterSdkVersion: Version(3, 20, 0),
            ),
            isTrue);
        expect(
            pv2.pubspec!.isPreviewForCurrentSdk(
              dartSdkVersion: futureSdkVersion,
              flutterSdkVersion: Version(3, 20, 0),
            ),
            isFalse);

        final p0 = (await packageBackend.lookupPackage('pkg'))!;
        expect(p0.latestVersion, '1.0.0');
        expect(p0.latestPrereleaseVersion, '1.2.0');
        expect(p0.latestPreviewVersion, '1.2.0');
        expect(p0.showPrereleaseVersion, isFalse);
        expect(p0.showPreviewVersion, isTrue);

        final u1 = await packageBackend.updateAllPackageVersions(
            dartSdkVersion: currentSdkVersion);
        expect(u1, 0);

        // check that nothing did change
        final p1 = (await packageBackend.lookupPackage('pkg'))!;
        expect(p1.latestVersion, '1.0.0');
        expect(p1.latestPrereleaseVersion, '1.2.0');
        expect(p1.latestPreviewVersion, '1.2.0');
        expect(p1.showPrereleaseVersion, isFalse);
        expect(p1.showPreviewVersion, isTrue);

        final u2 = await packageBackend.updateAllPackageVersions(
            dartSdkVersion: futureSdkVersion);
        expect(u2, 1);

        // check changes
        final p2 = (await packageBackend.lookupPackage('pkg'))!;
        expect(p2.latestVersion, '1.2.0');
        expect(p2.latestPrereleaseVersion, '1.2.0');
        expect(p2.latestPreviewVersion, '1.2.0');
        expect(p2.showPrereleaseVersion, isFalse);
        expect(p2.showPreviewVersion, isFalse);
      },
    );

    testWithProfile(
      'backfill preview version',
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(name: 'pkg', versions: [
            GeneratedTestVersion(version: '1.0.0'),
            GeneratedTestVersion(
              version: '1.2.0',
              template: TestArchiveTemplate(
                sdkConstraint: futureSdkVersion.toString(),
              ),
            ),
          ]),
        ],
      ),
      fn: () async {
        final pkg = await dbService.lookupValue<Package>(
            dbService.emptyKey.append(Package, id: 'pkg'));
        pkg.latestPreviewVersionKey = null;
        pkg.latestPreviewPublished = null;
        pkg.lastVersionPublished = pkg.created;
        await dbService.commit(inserts: [pkg]);

        final u1 = await packageBackend.updateAllPackageVersions(
            dartSdkVersion: currentSdkVersion);
        expect(u1, 1);

        // check that fields were updated
        final p1 = (await packageBackend.lookupPackage('pkg'))!;
        expect(p1.latestVersion, '1.0.0');
        expect(p1.latestPrereleaseVersion, '1.2.0');
        expect(p1.latestPreviewVersion, '1.2.0');
        expect(p1.showPrereleaseVersion, isFalse);
        expect(p1.showPreviewVersion, isTrue);
        expect(p1.latestPreviewPublished, isNotNull);
        expect(p1.lastVersionPublished, isNot(pkg.created));
      },
    );

    testWithProfile(
      'only future prerelease versions',
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(name: 'pkg', versions: [
            GeneratedTestVersion(version: '0.1.0-nullsafety.0'),
            GeneratedTestVersion(version: '0.1.0-nullsafety.1'),
            GeneratedTestVersion(version: '0.2.0-nullsafety.0'),
            GeneratedTestVersion(version: '0.2.1-nullsafety.0'),
          ]),
        ],
      ),
      fn: () async {
        final pkg = await dbService.lookupValue<Package>(
            dbService.emptyKey.append(Package, id: 'pkg'));
        expect(pkg.latestVersion, '0.2.1-nullsafety.0');
        pkg.latestPreviewVersionKey = null;
        pkg.latestPreviewPublished = null;
        await dbService.commit(inserts: [pkg]);

        final u1 = await packageBackend.updateAllPackageVersions(
            dartSdkVersion: currentSdkVersion);
        expect(u1, 1);

        // check that fields were updated
        final p1 = await packageBackend.lookupPackage('pkg');
        expect(p1!.latestVersion, '0.2.1-nullsafety.0');
        expect(p1.latestPrereleaseVersion, '0.2.1-nullsafety.0');
        expect(p1.latestPreviewVersion, '0.2.1-nullsafety.0');
        expect(p1.showPrereleaseVersion, isFalse);
        expect(p1.showPreviewVersion, isFalse);
      },
    );

    testWithProfile(
      'allow latest stable to go back',
      testProfile: TestProfile(
        defaultUser: 'admin@pub.dev',
        generatedPackages: [
          GeneratedTestPackage(name: 'pkg', versions: [
            GeneratedTestVersion(version: '1.0.0'),
            GeneratedTestVersion(
              version: '1.2.0',
              template: TestArchiveTemplate(
                sdkConstraint: futureSdkVersion.toString(),
              ),
            ),
          ]),
        ],
      ),
      fn: () async {
        final pkg = await dbService.lookupValue<Package>(
            dbService.emptyKey.append(Package, id: 'pkg'));

        // force-update latest stable to match preview
        expect(pkg.latestVersion, '1.0.0');
        pkg.latestVersionKey = pkg.latestPreviewVersionKey;
        expect(pkg.latestVersion, '1.2.0');
        await dbService.commit(inserts: [pkg]);

        // trigger update
        final u1 = await packageBackend.updateAllPackageVersions(
            dartSdkVersion: currentSdkVersion);
        expect(u1, 1);

        // check that fields were updated
        final p1 = await packageBackend.lookupPackage('pkg');
        expect(p1!.latestVersion, '1.0.0');
        expect(p1.latestPrereleaseVersion, '1.2.0');
        expect(p1.latestPreviewVersion, '1.2.0');
        expect(p1.showPrereleaseVersion, isFalse);
        expect(p1.showPreviewVersion, isTrue);
        expect(p1.latestPreviewPublished, isNotNull);
        expect(p1.lastVersionPublished, isNotNull);
      },
    );
  });
}
