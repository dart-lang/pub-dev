// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:html/parser.dart';
import 'package:pana/pana.dart' hide ReportStatus;
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart' as xml;

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/analyzer/analyzer_client.dart';
import 'package:pub_dev/audit/backend.dart';
import 'package:pub_dev/audit/models.dart';
import 'package:pub_dev/frontend/handlers/package.dart'
    show loadPackagePageData;
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/frontend/templates/admin.dart';
import 'package:pub_dev/frontend/templates/landing.dart';
import 'package:pub_dev/frontend/templates/layout.dart';
import 'package:pub_dev/frontend/templates/listing.dart';
import 'package:pub_dev/frontend/templates/misc.dart';
import 'package:pub_dev/frontend/templates/package.dart';
import 'package:pub_dev/frontend/templates/package_admin.dart';
import 'package:pub_dev/frontend/templates/package_analysis.dart';
import 'package:pub_dev/frontend/templates/package_versions.dart';
import 'package:pub_dev/frontend/templates/publisher.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/package/search_adapter.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/publisher/models.dart';
import 'package:pub_dev/scorecard/backend.dart';
import 'package:pub_dev/scorecard/models.dart';
import 'package:pub_dev/search/search_form.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/service/youtube/backend.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/shared/utils.dart' show shortDateFormat;
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_validations/html/html_validation.dart';

import '../shared/test_models.dart';
import '../shared/test_services.dart';
import '../shared/utils.dart';

const String goldenDir = 'test/frontend/golden';

final _regenerateGoldens = false;

void main() {
  setUpAll(() => updateLocalBuiltFilesIfNeeded());

  group('templates', () {
    late StaticFileCache oldCache;

    setUpAll(() {
      final properCache = StaticFileCache.withDefaults();
      final cache = StaticFileCache();
      for (String path in properCache.keys) {
        final file = StaticFile(path, 'text/mock', [], DateTime.now(),
            'mocked_hash_${path.hashCode.abs()}');
        cache.addFile(file);
      }
      oldCache = staticFileCache;
      registerStaticFileCacheForTest(cache);
    });

    tearDownAll(() {
      registerStaticFileCacheForTest(oldCache);
    });

    void expectGoldenFile(
      String content,
      String fileName, {
      bool isFragment = false,
      Map<String, DateTime?>? timestamps,
    }) {
      // Making sure it is valid HTML
      final htmlParser = HtmlParser(content, strict: true);

      if (isFragment) {
        final root = htmlParser.parseFragment();
        validateHtml(root);
      } else {
        final root = htmlParser.parse();
        validateHtml(root);
      }

      var replacedContent = content;
      timestamps?.forEach((key, value) {
        if (value != null) {
          replacedContent = replacedContent
              .replaceAll(shortDateFormat.format(value), '%%$key-date%%')
              .replaceAll(value.toIso8601String(), '%%$key-timestamp%%');
        }
      });

      // Pretty printing output using XML parser and formatter.
      final xmlDoc = xml.XmlDocument.parse(
        isFragment
            ? '<fragment>' + replacedContent + '</fragment>'
            : replacedContent,
        entityMapping: xml.XmlDefaultEntityMapping.html5(),
      );
      final xmlContent = xmlDoc.toXmlString(
            pretty: true,
            indent: '  ',
            entityMapping: xml.XmlDefaultEntityMapping.html5(),
          ) +
          '\n';

      if (_regenerateGoldens) {
        File('$goldenDir/$fileName').writeAsStringSync(xmlContent);
        fail('Set `_regenerateGoldens` to `false` to run tests.');
      }
      final golden = File('$goldenDir/$fileName').readAsStringSync();
      expect(xmlContent.split('\n'), golden.split('\n'));
    }

    testWithProfile(
      'landing page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final html = renderLandingPage(ffPackages: [
          (await scoreCardBackend.getPackageView('flutter_titanium'))!,
        ], mostPopularPackages: [
          (await scoreCardBackend.getPackageView('neon'))!,
          (await scoreCardBackend.getPackageView('oxygen'))!,
        ], topPoWVideos: [
          PkgOfWeekVideo(
              videoId: 'video-id',
              title: 'POW Title',
              description: 'POW description',
              thumbnailUrl: 'http://youtube.com/image/thumbnail?i=123&s=4'),
        ]);
        expectGoldenFile(html, 'landing_page.html');
      },
    );

    testWithProfile(
      'package show page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await accountBackend.withBearerToken(
          adminAtPubDevAuthToken,
          () => loadPackagePageData('oxygen', '1.2.0', AssetKind.readme),
        );
        final html = renderPkgShowPage(data);
        expectGoldenFile(html, 'pkg_show_page.html', timestamps: {
          'published': data.package!.created,
          'updated': data.version!.created,
        });
      },
    );

    testWithProfile(
      'package changelog page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data =
            await loadPackagePageData('oxygen', '1.2.0', AssetKind.changelog);
        final html = renderPkgChangelogPage(data);
        expectGoldenFile(html, 'pkg_changelog_page.html', timestamps: {
          'published': data.package!.created,
          'updated': data.version!.created,
        });
      },
    );

    testWithProfile(
      'package example page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data =
            await loadPackagePageData('oxygen', '1.2.0', AssetKind.example);
        final html = renderPkgExamplePage(data);
        expectGoldenFile(html, 'pkg_example_page.html', timestamps: {
          'published': data.package!.created,
          'updated': data.version!.created,
        });
      },
    );

    testWithProfile(
      'package install page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await loadPackagePageData('oxygen', '1.2.0', null);
        final html = renderPkgInstallPage(data);
        expectGoldenFile(html, 'pkg_install_page.html', timestamps: {
          'published': data.package!.created,
          'updated': data.version!.created,
        });
      },
    );

    testWithProfile('package score page', processJobsWithFakeRunners: true,
        fn: () async {
      final data = await loadPackagePageData('oxygen', '1.2.0', null);
      final html = renderPkgScorePage(data);
      expectGoldenFile(html, 'pkg_score_page.html', timestamps: {
        'published': data.package!.created,
        'updated': data.version!.created,
      });
    });

    testWithProfile(
      'package show page - with version',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data =
            await loadPackagePageData('oxygen', '1.2.0', AssetKind.readme);
        final html = renderPkgShowPage(data);
        expectGoldenFile(html, 'pkg_show_version_page.html', timestamps: {
          'published': data.package!.created,
          'updated': data.version!.created,
        });
      },
    );

    testWithProfile(
      'package show page with flutter_plugin',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await accountBackend.withBearerToken(
          adminAtPubDevAuthToken,
          () => loadPackagePageData(
              'flutter_titanium', '1.10.0', AssetKind.readme),
        );
        final html = renderPkgShowPage(data);
        expectGoldenFile(html, 'pkg_show_page_flutter_plugin.html',
            timestamps: {
              'published': data.package!.created,
              'updated': data.version!.created,
            });
      },
    );

    testWithProfile('package show page with discontinued version',
        testProfile: TestProfile(
          packages: [
            TestPackage(
              name: 'pkg',
              versions: ['1.0.0'],
              isDiscontinued: true,
            ),
          ],
          defaultUser: 'admin@pub.dev',
        ),
        processJobsWithFakeRunners: true, fn: () async {
      final data = await loadPackagePageData('pkg', '1.0.0', AssetKind.readme);
      final html = renderPkgShowPage(data);
      expectGoldenFile(html, 'pkg_show_page_discontinued.html', timestamps: {
        'published': data.package!.created,
        'updated': data.version!.created,
      });
    });

    testWithProfile(
      'package show page with legacy version',
      testProfile: TestProfile(
        packages: [
          TestPackage(name: 'pkg', versions: ['1.0.0-legacy']),
        ],
        defaultUser: 'admin@pub.dev',
      ),
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await loadPackagePageData('pkg', '1.0.0-legacy', null);
        final html = renderPkgScorePage(data);
        expectGoldenFile(html, 'pkg_show_page_legacy.html', timestamps: {
          'published': data.package!.created,
          'updated': data.version!.created,
        });
      },
    );

    // package analysis was intentionally left out for this template
    testWithProfile('package show page with publisher', fn: () async {
      final data = await loadPackagePageData('neon', '1.0.0', AssetKind.readme);
      final html = renderPkgShowPage(data);
      expectGoldenFile(html, 'pkg_show_page_publisher.html', timestamps: {
        'published': data.package!.created,
        'updated': data.package!.lastVersionPublished,
      });
    });

    scopedTest('no content for analysis tab', () async {
      // no content
      expect(renderAnalysisTab('pkg_foo', null, null, null, likeCount: 4),
          '<i>Awaiting analysis to complete.</i>');
    });

    scopedTest('aborted analysis tab', () async {
      final card = ScoreCardData(
        reportTypes: ['pana'],
        panaReport: PanaReport(
          timestamp: DateTime(2017, 12, 18, 14, 26, 00),
          panaRuntimeInfo: _panaRuntimeInfo,
          reportStatus: ReportStatus.aborted,
          derivedTags: null,
          allDependencies: null,
          licenseFile: null,
          report: Report(sections: <ReportSection>[]),
          flags: null,
        ),
      );
      final html = renderAnalysisTab(
        'pkg_foo',
        null,
        card,
        AnalysisView(card),
        likeCount: 1000000,
      );

      expectGoldenFile(html, 'analysis_tab_aborted.html', isFragment: true);
    });

    scopedTest('outdated analysis tab', () async {
      final card = ScoreCardData(
        flags: [PackageFlags.isObsolete],
        updated: DateTime(2017, 12, 18, 14, 26, 00),
      );
      final String html = renderAnalysisTab(
        'pkg_foo',
        null,
        card,
        AnalysisView(card),
        likeCount: 1111,
      );
      expectGoldenFile(html, 'analysis_tab_outdated.html', isFragment: true);
    });

    testWithProfile(
      'package admin page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await accountBackend.withBearerToken(
          adminAtPubDevAuthToken,
          () => loadPackagePageData('oxygen', '1.2.0', AssetKind.readme),
        );
        final html = renderPkgAdminPage(
          data,
          ['example.com'],
          ['admin@pub.dev'],
        );
        expectGoldenFile(html, 'pkg_admin_page.html', timestamps: {
          'published': data.package!.created,
          'updated': data.version!.created,
        });
      },
    );

    testWithProfile(
      'package activity log page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await accountBackend.withBearerToken(
          adminAtPubDevAuthToken,
          () => loadPackagePageData('oxygen', '1.2.0', null),
        );
        final activities = await auditBackend.listRecordsForPackage('oxygen');
        expect(activities.records, isNotEmpty);
        final html = renderPkgActivityLogPage(data, activities);
        expectGoldenFile(html, 'pkg_activity_log_page.html', timestamps: {
          'published': data.package!.created,
          'updated': data.version!.created,
          ..._activityLogTimestamps(activities),
        });
      },
    );

    testWithProfile(
      'package index page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final searchForm = SearchForm.parse();
        final oxygen = (await scoreCardBackend.getPackageView('oxygen'))!;
        final titanium =
            (await scoreCardBackend.getPackageView('flutter_titanium'))!;
        final String html = renderPkgIndexPage(
          SearchResultPage(
            searchForm,
            2,
            packageHits: [oxygen, titanium],
          ),
          PageLinks.empty(),
          searchForm: searchForm,
        );
        expectGoldenFile(html, 'pkg_index_page.html', timestamps: {
          'oxygen-created': oxygen.created,
          'oxygen-updated': oxygen.updated,
          'titanium-created': titanium.created,
          'titanium-updated': titanium.updated,
        });
      },
    );

    testWithProfile(
      'package index page with search',
      processJobsWithFakeRunners: true,
      fn: () async {
        final searchForm =
            SearchForm.parse(query: 'foobar', order: SearchOrder.top);
        final oxygen = (await scoreCardBackend.getPackageView('oxygen'))!;
        final titanium =
            (await scoreCardBackend.getPackageView('flutter_titanium'))!;
        final String html = renderPkgIndexPage(
          SearchResultPage(
            searchForm,
            2,
            packageHits: [
              oxygen.change(
                apiPages: [
                  ApiPageRef(path: 'some/some-library.html'),
                  ApiPageRef(title: 'Class X', path: 'some/x-class.html'),
                ],
              ),
              titanium,
            ],
          ),
          PageLinks(searchForm, 50),
          searchForm: searchForm,
        );
        expectGoldenFile(html, 'search_page.html', timestamps: {
          'oxygen-created': oxygen.created,
          'oxygen-updated': oxygen.updated,
          'titanium-created': titanium.created,
          'titanium-updated': titanium.updated,
        });
      },
    );

    testWithProfile(
      'package versions page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final data = await loadPackagePageData('oxygen', '1.2.0', null);
        final versions = await packageBackend.versionsOfPackage('oxygen');
        final html = renderPkgVersionsPage(
          data,
          versions,
          versions
              .map((v) => Uri.parse(
                  'https://pub.dev/download-url/${v.package}/${v.version}'))
              .toList(),
          dartSdkVersion: Version.parse(runtimeSdkVersion),
        );
        expectGoldenFile(html, 'pkg_versions_page.html', timestamps: {
          'version-created': data.version!.created,
          'package-created': data.package!.created,
        });
      },
    );

    scopedTest('publisher list page', () {
      final html = renderPublisherListPage(
        [
          PublisherSummary(
            publisherId: 'example.com',
            created: DateTime(2019, 09, 13),
          ),
          PublisherSummary(
            publisherId: 'other-domain.com',
            created: DateTime(2019, 09, 19),
          ),
        ],
      );
      expectGoldenFile(html, 'publisher_list_page.html');
    });

    testWithProfile(
      'publisher packages page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final searchForm = SearchForm.parse(publisherId: 'example.com');
        final publisher = (await publisherBackend.getPublisher('example.com'))!;
        final neon = (await scoreCardBackend.getPackageView('neon'))!;
        final titanium =
            (await scoreCardBackend.getPackageView('flutter_titanium'))!;
        final html = renderPublisherPackagesPage(
          publisher: publisher,
          searchResultPage: SearchResultPage(
            searchForm,
            2,
            packageHits: [neon, titanium],
          ),
          totalCount: 2,
          searchForm: searchForm,
          pageLinks: PageLinks(searchForm, 10),
          isAdmin: true,
          messageFromBackend: null,
        );
        expectGoldenFile(html, 'publisher_packages_page.html', timestamps: {
          'neon-created': neon.created,
          'neon-updated': neon.updated,
          'titanium-created': titanium.created,
          'titanium-updated': titanium.updated,
          'publisher-created': publisher.created,
          'publisher-updated': publisher.updated,
        });
      },
    );

    testWithProfile(
      'publisher activity log page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final publisher = (await publisherBackend.getPublisher('example.com'))!;
        final activities =
            await auditBackend.listRecordsForPublisher('example.com');
        expect(activities.records, isNotEmpty);
        final html = renderPublisherActivityLogPage(
          publisher: publisher,
          activities: activities,
        );
        expectGoldenFile(html, 'publisher_activity_log_page.html', timestamps: {
          'publisher-created': publisher.created,
          'publisher-updated': publisher.updated,
          ..._activityLogTimestamps(activities),
        });
      },
    );

    testWithProfile(
      '/my-packages page',
      processJobsWithFakeRunners: true,
      fn: () async {
        final oxygen = await scoreCardBackend.getPackageView('oxygen');
        final neon = await scoreCardBackend.getPackageView('neon');
        await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
          final user = await requireAuthenticatedUser();
          final session = await accountBackend.createNewSession(
            name: 'Pub User',
            imageUrl: 'pub.dev/user-img-url.png',
          );
          final searchForm =
              SearchForm.parse(uploaderOrPublishers: [user.email!]);
          final String html = renderAccountPackagesPage(
            user: user,
            userSessionData: session,
            searchResultPage: SearchResultPage(
              searchForm,
              2,
              packageHits: [oxygen!, neon!],
            ),
            pageLinks: PageLinks(searchForm, 10),
            searchForm: searchForm,
            totalCount: 2,
            messageFromBackend: null,
          );
          expectGoldenFile(html, 'my_packages.html', timestamps: {
            'oxygen-created': oxygen.created,
            'oxygen-updated': oxygen.updated,
            'neon-created': neon.created,
            'neon-updated': neon.updated,
          });
        });
      },
    );

    testWithProfile('/my-liked-packages page', fn: () async {
      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final user = await requireAuthenticatedUser();
        final session = await accountBackend.createNewSession(
          name: 'Pub User',
          imageUrl: 'pub.dev/user-img-url.png',
        );
        final html = renderMyLikedPackagesPage(
          user: user,
          userSessionData: session,
          likes: [
            LikeData(
                package: 'super_package',
                created: DateTime.fromMillisecondsSinceEpoch(1574423824000)),
            LikeData(
                package: 'another_package',
                created: DateTime.fromMillisecondsSinceEpoch(1574423824000))
          ],
        );
        expectGoldenFile(html, 'my_liked_packages.html', timestamps: {
          'user-created': user.created,
        });
      });
    });

    testWithProfile('/my-publishers page', fn: () async {
      await accountBackend.withBearerToken(userAtPubDevAuthToken, () async {
        final user = await requireAuthenticatedUser();
        final session = await accountBackend.createNewSession(
          name: 'Pub User',
          imageUrl: 'pub.dev/user-img-url.png',
        );
        final html = renderAccountPublishersPage(
          user: user,
          userSessionData: session,
          publishers: [
            PublisherSummary(
              publisherId: 'example.com',
              created: DateTime(2021, 07, 01, 16, 05),
            ),
          ],
        );
        expectGoldenFile(html, 'my_publishers.html', timestamps: {
          'user-created': user.created,
        });
      });
    });

    testWithProfile('/my-activity-log page', fn: () async {
      await accountBackend.withBearerToken(adminAtPubDevAuthToken, () async {
        final user = await requireAuthenticatedUser();
        final session = await accountBackend.createNewSession(
          name: 'Pub User',
          imageUrl: 'pub.dev/user-img-url.png',
        );
        final activities =
            await auditBackend.listRecordsForUserId(user.userId!);
        expect(activities.records, isNotEmpty);
        final html = renderAccountMyActivityPage(
          user: user,
          userSessionData: session,
          activities: activities,
        );
        expectGoldenFile(html, 'my_activity_log_page.html', timestamps: {
          'user-created': user.created,
          ..._activityLogTimestamps(activities),
        });
      });
    });

    scopedTest('authorized page', () {
      final String html = renderAuthorizedPage();
      expectGoldenFile(html, 'authorized_page.html');
    });

    scopedTest('error page', () {
      final String html = renderErrorPage('error_title', 'error_message');
      expectGoldenFile(html, 'error_page.html');
    });

    test('pagination: single page', () {
      final html = renderPagination(PageLinks.empty()).toString();
      expectGoldenFile(html, 'pagination_single.html', isFragment: true);
    });

    test('pagination: in the middle', () {
      final html =
          renderPagination(PageLinks(SearchForm.parse(currentPage: 10), 299))
              .toString();
      expectGoldenFile(html, 'pagination_middle.html', isFragment: true);
    });

    test('pagination: at first page', () {
      final html =
          renderPagination(PageLinks(SearchForm.parse(), 600)).toString();
      expectGoldenFile(html, 'pagination_first.html', isFragment: true);
    });

    test('pagination: at last page', () {
      final html =
          renderPagination(PageLinks(SearchForm.parse(currentPage: 10), 91))
              .toString();
      expectGoldenFile(html, 'pagination_last.html', isFragment: true);
    });

    scopedTest('platform tabs: list', () {
      final String html = renderSdkTabs();
      expectGoldenFile(html, 'platform_tabs_list.html', isFragment: true);
    });

    scopedTest('platform tabs: search', () {
      final String html = renderSdkTabs(
          searchForm: SearchForm.parse(
        query: 'foo',
        sdk: 'flutter',
      ));
      expectGoldenFile(html, 'platform_tabs_search.html', isFragment: true);
    });
  });

  group('PageLinks', () {
    test('empty', () {
      final links = PageLinks.empty();
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('one', () {
      final links = PageLinks(SearchForm.parse(), 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE - 1', () {
      final links = PageLinks(SearchForm.parse(), resultsPerPage - 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE', () {
      final links = PageLinks(SearchForm.parse(), resultsPerPage);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE + 1', () {
      final links = PageLinks(SearchForm.parse(), resultsPerPage + 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    final int page2Offset = resultsPerPage;

    test('page=2 + one item', () {
      final links =
          PageLinks(SearchForm.parse(currentPage: 2), page2Offset + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE - 1', () {
      final links = PageLinks(
          SearchForm.parse(currentPage: 2), page2Offset + resultsPerPage - 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE', () {
      final links = PageLinks(
          SearchForm.parse(currentPage: 2), page2Offset + resultsPerPage);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE + 1', () {
      final links = PageLinks(
          SearchForm.parse(currentPage: 2), page2Offset + resultsPerPage + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 3);
    });

    test('deep in the middle', () {
      final links = PageLinks(SearchForm.parse(currentPage: 21), 600);
      expect(links.currentPage, 21);
      expect(links.leftmostPage, 16);
      expect(links.rightmostPage, 26);
    });
  });
}

final _panaRuntimeInfo = PanaRuntimeInfo(
  panaVersion: '0.6.2',
  flutterVersions: {'frameworkVersion': '0.0.18'},
  sdkVersion: '2.0.0-dev.7.0',
);

Map<String, DateTime> _activityLogTimestamps(AuditLogRecordPage page) {
  final map = <String, DateTime>{};
  for (final record in page.records) {
    final index = map.length;
    map['activity-$index'] = record.created!;
  }
  return map;
}
