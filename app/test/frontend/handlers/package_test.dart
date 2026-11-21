// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/data/package_api.dart' show VersionInfo;
import 'package:api_summary/model.dart'
    show
        ApiClass,
        ApiExecutable,
        ApiExecutableKind,
        ApiLibrary,
        ApiSummary,
        ApiVoidType;
import 'package:pana/pana.dart' show ApiChange, ApiDiffSummary;
import 'package:pub_dev/frontend/templates/views/pkg/versions/version_row.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/shared/datastore.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:test/test.dart';

import '../../shared/handlers_test_utils.dart';
import '../../shared/test_services.dart';
import '_utils.dart';

void main() {
  group('ui', () {
    testWithProfile(
      '/packages/oxygen - found',
      fn: () async {
        await expectHtmlResponse(
          await issueGet('/packages/oxygen'),
          present: [
            'oxygen 1.2.0',
            RegExp(r'<a href="/packages/oxygen" title=".*">1.2.0</a>'),
            RegExp(
              r'<a href="/packages/oxygen/versions/2.0.0-dev" title=".*">2.0.0-dev</a>',
            ),
          ],
          absent: ['data-name="-admin-tab-"'],
        );
      },
    );

    testWithProfile(
      'package name and version redirects',
      fn: () async {
        await expectRedirectResponse(
          await issueGet('/packages/oxYgen'),
          '/packages/oxygen',
        );
        await expectRedirectResponse(
          await issueGet('/packages/oxYgen/changelog'),
          '/packages/oxygen/changelog',
        );
        await expectRedirectResponse(
          await issueGet('/packages/oxYgen/versions'),
          '/packages/oxygen/versions',
        );
        await expectRedirectResponse(
          await issueGet('/packages/oxYgen/versions/1.2.0/changelog'),
          '/packages/oxygen/versions/1.2.0/changelog',
        );
        await expectRedirectResponse(
          await issueGet('/packages/oxygen/versions/1.2.00/changelog'),
          '/packages/oxygen/versions/1.2.0/changelog',
        );
      },
    );

    testWithProfile(
      '/packages/foobar_not_found - not found',
      fn: () async {
        await expectNotFoundResponse(
          await issueGet('/packages/foobar_not_found'),
        );
      },
    );

    testWithProfile(
      '/packages/oxygen/versions - found',
      fn: () async {
        await expectHtmlResponse(
          await issueGet('/packages/oxygen/versions'),
          present: [
            'oxygen 1.2.0',
            RegExp(r'<a href="/packages/oxygen" title=".*">1.2.0</a>'),
            RegExp(
              r'<a href="/packages/oxygen/versions/2.0.0-dev" title=".*">2.0.0-dev</a>',
            ),
          ],
        );
      },
    );

    testWithProfile(
      '/packages/foobar_not_found/versions - not found',
      fn: () async {
        await expectNotFoundResponse(
          await issueGet('/packages/foobar_not_found/versions'),
        );
      },
    );

    testWithProfile(
      '/packages/oxygen/versions/1.0.0 - found',
      fn: () async {
        await expectHtmlResponse(
          await issueGet('/packages/oxygen/versions/1.0.0'),
          present: [
            'oxygen 1.0.0',
            RegExp(r'<a href="/packages/oxygen" title=".*">1.2.0</a>'),
            RegExp(
              r'<a href="/packages/oxygen/versions/2.0.0-dev" title=".*">2.0.0-dev</a>',
            ),
          ],
        );
      },
    );

    testWithProfile(
      '/packages/oxygen/versions/2.0.0%2Ddev - found',
      fn: () async {
        await expectHtmlResponse(
          await issueGet('/packages/oxygen/versions/2.0.0%2Ddev'),
          present: [
            'oxygen 2.0.0-dev',
            RegExp(r'<a href="/packages/oxygen" title=".*">1.2.0</a>'),
            RegExp(
              r'<a href="/packages/oxygen/versions/2.0.0-dev" title=".*">2.0.0-dev</a>',
            ),
          ],
        );
      },
    );

    testWithProfile(
      '/packages/oxygen/versions/0.1.2 - not found',
      fn: () async {
        await expectNotFoundResponse(
          await issueGet('/packages/oxygen/versions/0.1.2'),
        );
        expect(
          await cache.packageVersionAssetKinds('oxygen', '0.1.2').get(),
          isNull,
        );
      },
    );

    testWithProfile(
      '/packages/oxygen/versions/xyz - bad version',
      fn: () async {
        final rs = await issueGet('/packages/oxygen/versions/xyz');
        expect(rs.statusCode, 400);
      },
    );

    testWithProfile(
      '/packages/oxygen/admin - without session',
      fn: () async {
        await expectHtmlResponse(
          await issueGet('/packages/oxygen/admin'),
          status: 401,
          present: [],
          absent: [
            '<li class="tab-button -active" data-name="-admin-tab-" role="button">',
          ],
        );
      },
    );

    testWithProfile(
      'package pages without homepage',
      testProfile: TestProfile(
        generatedPackages: [
          GeneratedTestPackage(
            name: 'pkg',
            versions: [
              GeneratedTestVersion(
                version: '1.0.0',
                template: TestArchiveTemplate(homepage: ''),
              ),
            ],
          ),
        ],
        defaultUser: 'admin@pub.dev',
      ),
      processJobsWithFakeRunners: true,
      fn: () async {
        final urls = [
          '/packages/pkg',
          '/packages/pkg/changelog',
          '/packages/pkg/example',
          '/packages/pkg/versions',
          '/packages/pkg/pubspec',
          '/packages/pkg/license',
          '/packages/pkg/score',
        ];
        for (final url in urls) {
          await expectHtmlResponse(
            await issueGet(url),
            present: [],
            absent: ['Homepage'],
          );
        }
      },
    );

    testWithProfile(
      'publisher redirect',
      fn: () async {
        await expectRedirectResponse(
          await issueGet('/packages/neon/publisher'),
          '/publishers/example.com',
        );
      },
    );

    testWithProfile(
      'publisher redirect - no publisher',
      fn: () async {
        await expectRedirectResponse(
          await issueGet('/packages/oxygen/publisher'),
          '/packages/oxygen',
        );
      },
    );

    testWithProfile(
      'merged versions and changelog tab with fallback and expandable API diff',
      fn: () async {
        final now = DateTime.now().toUtc().add(const Duration(days: 1));
        await dbService.commit(
          inserts: [
            // Latest version (1.2.0) documents 1.2.0, but omits 1.0.0.
            PackageVersionAsset.init(
              package: 'oxygen',
              version: '1.2.0',
              kind: AssetKind.changelog,
              versionCreated: now,
              updated: now,
              path: 'CHANGELOG.md',
              textContent:
                  '## 1.2.0\n\n- Added turbo mode in latest changelog.\n',
            ),
            // 1.0.0 has its own CHANGELOG.md entry.
            PackageVersionAsset.init(
              package: 'oxygen',
              version: '1.0.0',
              kind: AssetKind.changelog,
              versionCreated: now,
              updated: now,
              path: 'CHANGELOG.md',
              textContent:
                  '## 1.0.0\n\n- Initial release from 1.0.0 archive.\n',
            ),
          ],
        );
        // Also store per-version ApiSummary JSON (api.json) for 1.0.0, 1.2.0,
        // and 2.0.0-dev to test on-the-fly predecessor diffs, arbitrary range
        // diffs (?from=1.0.0&to=2.0.0-dev), and toolVersion staleness tracking.
        String buildOxygenApiJson(List<String> methodNames) => json.encode(
          ApiSummary(
            name: 'oxygen',
            libraries: [
              ApiLibrary(
                uri: 'package:oxygen/oxygen.dart',
                isPublicEntryPoint: true,
                classes: [
                  ApiClass(
                    name: 'Oxygen',
                    typeParameters: const {},
                    interfaces: const [],
                    mixins: const [],
                    modifiers: const [],
                    immediateSubtypes: const [],
                    constructors: const [],
                    methods: [
                      for (final m in methodNames)
                        ApiExecutable(
                          name: m,
                          kind: ApiExecutableKind.method,
                          typeParameters: const {},
                          returnType: const ApiVoidType(),
                          parameters: const [],
                          isStatic: false,
                        ),
                    ],
                  ),
                ],
                enums: const [],
                mixins: const [],
                extensions: const [],
                extensionTypes: const [],
                functions: const [],
                typeAliases: const [],
              ),
            ],
          ).toJson(),
        );

        await packageBackend.storePackageVersionApiSummary(
          'oxygen',
          '1.0.0',
          buildOxygenApiJson(['breathe']),
        );
        await packageBackend.storePackageVersionApiSummary(
          'oxygen',
          '1.2.0',
          buildOxygenApiJson(['breathe', 'compress']),
        );
        await packageBackend.storePackageVersionApiSummary(
          'oxygen',
          '2.0.0-dev',
          buildOxygenApiJson(['breathe', 'compress', 'enableTurbo']),
        );

        await cache.uiPackageVersions('oxygen').purge();
        await cache.uiPackageChangelog('oxygen', null).purge();

        for (final path in [
          '/packages/oxygen/versions',
          '/packages/oxygen/changelog',
        ]) {
          await expectHtmlResponse(
            await issueGet(path),
            present: [
              'Versions &#47; Changelog',
              'Added turbo mode in latest changelog.',
              'Initial release from 1.0.0 archive.',
              'From 1.0.0 CHANGELOG.md',
              'data-compare-version="1.2.0"',
              'API diff vs 1.0.0',
              'API diff vs 1.2.0',
            ],
          );
        }

        // Verify arbitrary range diff (?from=1.0.0&to=2.0.0-dev) across multiple versions.
        await expectHtmlResponse(
          await issueGet('/packages/oxygen/versions?from=1.0.0&to=2.0.0-dev'),
          present: [
            'Cumulative API diff: 1.0.0 → 2.0.0-dev',
            '-compare-from',
            '-compare-to',
            '2 additions',
            'compress',
            'enableTurbo',
          ],
        );

        // Verify staleness tracking when api_summary is updated to a new version.
        final upToDate = await packageBackend
            .listVersionsNeedingApiSummaryUpdate('oxygen');
        expect(upToDate, isEmpty);
        final staleOnNewTool = await packageBackend
            .listVersionsNeedingApiSummaryUpdate(
              'oxygen',
              targetToolVersion: 'api_summary:1.2.0',
            );
        expect(
          staleOnNewTool.map((e) => e.version),
          containsAll(['1.0.0', '1.2.0', '2.0.0-dev']),
        );

        // Verify expandable API diff widget rendering on version row.
        final pv = (await packageBackend.lookupPackageVersion(
          'oxygen',
          '1.2.0',
        ))!;
        final rowHtml = versionRowNode(
          'oxygen',
          VersionInfo(
            version: '1.2.0',
            retracted: false,
            pubspec: pv.pubspec!.asJson,
            archiveUrl: 'https://pub.dev/archive.tar.gz',
            archiveSha256: '00',
            published: pv.created!,
          ),
          pv.pubspec!,
          details: VersionChangelogAndDiff(
            changelogHtml: '<p>Added turbo mode.</p>',
            apiDiff: ApiDiffSummary(
              previousVersion: '1.1.0',
              currentVersion: '1.2.0',
              requiredVersionBump: 'minor',
              minimumExpectedVersion: '1.2.0',
              isVersionIncrementSufficient: true,
              toolVersion: 'api_summary',
              breakingChanges: const [],
              nonBreakingChanges: [
                ApiChange(
                  scope: const [
                    'Library package:oxygen/oxygen.dart',
                    'Class Oxygen',
                  ],
                  description: 'Executable "enableTurbo" added.',
                  changeCode: 'MEMBER_ADDED',
                  isBreaking: false,
                  type: 'minor',
                ),
              ],
              textDiff:
                  'package:oxygen/oxygen.dart:\n'
                  '  Oxygen (class extends Object):\n'
                  '+    enableTurbo (method: void Function())',
            ),
          ),
        ).toString();
        expect(rowHtml, contains('<details class="version-api-diff">'));
        expect(rowHtml, contains('API diff vs 1.1.0'));
        expect(rowHtml, contains('1 addition'));
        expect(rowHtml, contains('Additions &amp; minor changes (1)'));
        expect(rowHtml, contains('Executable &quot;enableTurbo&quot; added.'));
        expect(rowHtml, contains('+    enableTurbo (method: void Function())'));
      },
    );
  });
}
