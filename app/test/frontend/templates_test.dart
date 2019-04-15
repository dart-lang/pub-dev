// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';
import 'package:pana/pana.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:xml/xml.dart' as xml;

import 'package:pub_dartlang_org/analyzer/pana_runner.dart'
    show panaReportFromSummary;
import 'package:pub_dartlang_org/scorecard/models.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/platform.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/frontend/templates/admin.dart';
import 'package:pub_dartlang_org/frontend/templates/landing.dart';
import 'package:pub_dartlang_org/frontend/templates/layout.dart';
import 'package:pub_dartlang_org/frontend/templates/listing.dart';
import 'package:pub_dartlang_org/frontend/templates/misc.dart';
import 'package:pub_dartlang_org/frontend/templates/package.dart';
import 'package:pub_dartlang_org/frontend/templates/package_analysis.dart';
import 'package:pub_dartlang_org/frontend/templates/package_versions.dart';

import '../shared/html_validation.dart';
import '../shared/utils.dart';
import 'utils.dart';

const String goldenDir = 'test/frontend/golden';

final _regenerateGoldens = false;

void main() {
  group('templates', () {
    setUpAll(() {
      final cache = StaticFileCache();
      for (String path in hashedFiles) {
        final file = StaticFile('${staticUrls.staticPath}/$path', 'text/mock',
            [], DateTime.now(), 'mocked_hash_${path.hashCode.abs()}');
        cache.addFile(file);
      }
      registerStaticFileCache(cache);
    });

    void expectGoldenFile(String content, String fileName,
        {bool isFragment = false}) {
      // Making sure it is valid HTML
      final htmlParser = HtmlParser(content, strict: true);

      if (isFragment) {
        final root = htmlParser.parseFragment();
        validateHtml(root);
      } else {
        final root = htmlParser.parse();
        validateHtml(root);
      }

      // Pretty printing output using XML parser and formatter.
      final xmlDoc = xml
          .parse(isFragment ? '<fragment>' + content + '</fragment>' : content);
      final xmlContent = xmlDoc.toXmlString(pretty: true, indent: '  ') + '\n';

      if (_regenerateGoldens) {
        File('$goldenDir/$fileName').writeAsStringSync(xmlContent);
        fail('Set `_regenerateGoldens` to `false` to run tests.');
      }
      final golden = File('$goldenDir/$fileName').readAsStringSync();
      expect(xmlContent.split('\n'), golden.split('\n'));
    }

    scopedTest('index page', () {
      final popularHtml = renderMiniList([
        PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          scoreCard: ScoreCardData(
            platformTags: ['web'],
            reportTypes: ['pana'],
          ),
        ),
      ]);
      final String html = renderIndexPage(popularHtml, null);
      expectGoldenFile(html, 'index_page.html');
    });

    scopedTest('landing page flutter', () {
      final popularHtml = renderMiniList([
        PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          scoreCard: ScoreCardData(
            platformTags: ['flutter'],
            reportTypes: ['pana'],
          ),
        ),
      ]);
      final String html = renderIndexPage(popularHtml, KnownPlatforms.flutter);
      expectGoldenFile(html, 'flutter_landing_page.html');
    });

    scopedTest('landing page web', () {
      final popularHtml = renderMiniList([
        PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          scoreCard: ScoreCardData(
            platformTags: ['web'],
            reportTypes: ['pana'],
          ),
        ),
      ]);
      final String html = renderIndexPage(popularHtml, KnownPlatforms.web);
      expectGoldenFile(html, 'web_landing_page.html');
    });

    scopedTest('package show page', () {
      final String html = renderPkgShowPage(
          testPackage,
          testPackageUploaderEmails,
          false,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          devPackageVersion,
          1,
          AnalysisView(
            card: ScoreCardData(reportTypes: ['pana'], healthScore: 0.1),
            panaReport: PanaReport(
                timestamp: DateTime(2018, 02, 05),
                panaRuntimeInfo: _panaRuntimeInfo,
                reportStatus: ReportStatus.success,
                healthScore: null,
                maintenanceScore: null,
                platformTags: null,
                platformReason: null,
                pkgDependencies: [
                  PkgDependency(
                    package: 'quiver',
                    dependencyType: 'direct',
                    constraintType: 'normal',
                    constraint: VersionConstraint.parse('^1.0.0'),
                    resolved: Version.parse('1.0.0'),
                    available: null,
                    errors: null,
                  ),
                  PkgDependency(
                    package: 'http',
                    dependencyType: 'direct',
                    constraintType: 'normal',
                    constraint: VersionConstraint.parse('>=1.0.0 <1.2.0'),
                    resolved: Version.parse('1.2.0'),
                    available: Version.parse('1.3.0'),
                    errors: null,
                  )
                ],
                licenses: [LicenseFile('LICENSE.txt', 'BSD')],
                panaSuggestions: null,
                healthSuggestions: null,
                maintenanceSuggestions: null,
                flags: null),
            dartdocReport: null,
          ));

      expectGoldenFile(html, 'pkg_show_page.html');
    });

    scopedTest('package show page - with version', () {
      final String html = renderPkgShowPage(
          testPackage,
          testPackageUploaderEmails,
          true,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          devPackageVersion,
          1,
          AnalysisView(
            card: ScoreCardData(reportTypes: ['pana'], healthScore: 0.1),
            panaReport: PanaReport(
                timestamp: DateTime(2018, 02, 05),
                panaRuntimeInfo: _panaRuntimeInfo,
                reportStatus: ReportStatus.success,
                healthScore: null,
                maintenanceScore: null,
                platformTags: null,
                platformReason: null,
                pkgDependencies: [
                  PkgDependency(
                    package: 'quiver',
                    dependencyType: 'direct',
                    constraintType: 'normal',
                    constraint: VersionConstraint.parse('^1.0.0'),
                    resolved: Version.parse('1.0.0'),
                    available: null,
                    errors: null,
                  ),
                  PkgDependency(
                    package: 'http',
                    dependencyType: 'direct',
                    constraintType: 'normal',
                    constraint: VersionConstraint.parse('>=1.0.0 <1.2.0'),
                    resolved: Version.parse('1.2.0'),
                    available: Version.parse('1.3.0'),
                    errors: null,
                  )
                ],
                licenses: [LicenseFile('LICENSE.txt', 'BSD')],
                panaSuggestions: null,
                healthSuggestions: null,
                maintenanceSuggestions: null,
                flags: null),
            dartdocReport: null,
          ));
      expectGoldenFile(html, 'pkg_show_version_page.html');
    });

    scopedTest('package show page with flutter_plugin', () {
      final String html = renderPkgShowPage(
        testPackage,
        testPackageUploaderEmails,
        false,
        [flutterPackageVersion],
        [Uri.parse('http://dart-example.com/')],
        flutterPackageVersion,
        flutterPackageVersion,
        flutterPackageVersion,
        1,
        AnalysisView(
          card: ScoreCardData(
            healthScore: 0.99,
            maintenanceScore: 0.99,
            popularityScore: 0.3,
            platformTags: ['flutter'],
            flags: [PackageFlags.usesFlutter],
            reportTypes: ['pana'],
          ),
          panaReport: PanaReport(
              timestamp: DateTime(2018, 02, 05),
              panaRuntimeInfo: _panaRuntimeInfo,
              reportStatus: ReportStatus.success,
              healthScore: 0.99,
              maintenanceScore: 0.99,
              platformTags: ['flutter'],
              platformReason: null,
              pkgDependencies: null,
              licenses: null,
              panaSuggestions: null,
              healthSuggestions: null,
              maintenanceSuggestions: null,
              flags: null),
        ),
      );
      expectGoldenFile(html, 'pkg_show_page_flutter_plugin.html');
    });

    scopedTest('package show page with outdated version', () {
      final String html = renderPkgShowPage(
          testPackage,
          testPackageUploaderEmails,
          true /* isVersionPage */,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1,
          AnalysisView(
            card: ScoreCardData(
              flags: [PackageFlags.isObsolete],
              updated: DateTime(2018, 02, 05),
            ),
          ));

      expectGoldenFile(html, 'pkg_show_page_outdated.html');
    });

    scopedTest('package show page with discontinued version', () {
      final String html = renderPkgShowPage(
          discontinuedPackage,
          discontinuedPackageUploaderEmails,
          false,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1,
          AnalysisView(
            card: ScoreCardData(
              flags: [PackageFlags.isDiscontinued],
              updated: DateTime(2018, 02, 05),
            ),
          ));

      expectGoldenFile(html, 'pkg_show_page_discontinued.html');
    });

    scopedTest('package show page with legacy version', () {
      final summary = createPanaSummaryForLegacy(
          testPackageVersion.package, testPackageVersion.version);
      final String html = renderPkgShowPage(
          testPackage,
          testPackageUploaderEmails,
          true /* isVersionPage */,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1,
          AnalysisView(
            card: ScoreCardData(
              popularityScore: 0.5,
              flags: [PackageFlags.isLegacy],
            ),
            panaReport: panaReportFromSummary(summary),
          ));

      expectGoldenFile(html, 'pkg_show_page_legacy.html');
    });

    scopedTest('no content for analysis tab', () async {
      // no content
      expect(renderAnalysisTab('pkg_foo', null, null, null), isNull);
    });

    scopedTest('analysis tab: http', () async {
      // stored analysis of http
      final String content =
          await File('$goldenDir/analysis_tab_http.json').readAsString();
      final map = json.decode(content) as Map<String, dynamic>;
      final card =
          ScoreCardData.fromJson(map['scorecard'] as Map<String, dynamic>);
      final reports = map['reports'] as Map<String, dynamic>;
      final panaReport =
          PanaReport.fromJson(reports['pana'] as Map<String, dynamic>);
      final view = AnalysisView(card: card, panaReport: panaReport);
      final String html =
          renderAnalysisTab('http', '>=1.23.0-dev.0.0 <2.0.0', card, view);
      expectGoldenFile(html, 'analysis_tab_http.html', isFragment: true);
    });

    scopedTest('mock analysis tab', () async {
      final card = ScoreCardData(
        healthScore: 0.90234,
        maintenanceScore: 0.8932343,
        popularityScore: 0.2323232,
        platformTags: ['web'],
        reportTypes: ['pana'],
      );
      final analysisView = AnalysisView(
        card: card,
        panaReport: PanaReport(
            timestamp: DateTime.utc(2017, 10, 26, 14, 03, 06),
            panaRuntimeInfo: _panaRuntimeInfo,
            reportStatus: ReportStatus.failed,
            healthScore: card.healthScore,
            maintenanceScore: card.maintenanceScore,
            platformTags: card.platformTags,
            platformReason: 'All libraries agree.',
            pkgDependencies: [
              PkgDependency(
                package: 'http',
                dependencyType: 'direct',
                constraintType: 'normal',
                constraint: VersionConstraint.parse('^1.0.0'),
                resolved: Version.parse('1.0.0'),
                available: Version.parse('1.1.0'),
                errors: null,
              ),
              PkgDependency(
                package: 'async',
                dependencyType: 'transitive',
                constraintType: 'normal',
                constraint: VersionConstraint.parse('>=0.3.0 <1.0.0'),
                resolved: Version.parse('0.5.1'),
                available: Version.parse('1.0.2'),
                errors: null,
              ),
            ],
            licenses: null,
            panaSuggestions: null,
            healthSuggestions: [
              Suggestion.error(SuggestionCode.dartfmtAborted, 'Fix `dartfmt`.',
                  'Running `dartfmt -n .` failed.'),
            ],
            maintenanceSuggestions: null,
            flags: null),
      );
      final String html = renderAnalysisTab(
          'pkg_foo', '>=1.25.0-dev.9.0 <2.0.0', card, analysisView);
      expectGoldenFile(html, 'analysis_tab_mock.html', isFragment: true);
    });

    scopedTest('aborted analysis tab', () async {
      final String html = renderAnalysisTab(
          'pkg_foo',
          null,
          ScoreCardData(),
          AnalysisView(
            card: ScoreCardData(
              reportTypes: ['pana'],
            ),
            panaReport: PanaReport(
              timestamp: DateTime(2017, 12, 18, 14, 26, 00),
              panaRuntimeInfo: _panaRuntimeInfo,
              reportStatus: ReportStatus.aborted,
              healthScore: null,
              maintenanceScore: null,
              platformTags: null,
              platformReason: null,
              pkgDependencies: null,
              licenses: null,
              panaSuggestions: null,
              healthSuggestions: null,
              maintenanceSuggestions: null,
              flags: null,
            ),
          ));
      expectGoldenFile(html, 'analysis_tab_aborted.html', isFragment: true);
    });

    scopedTest('outdated analysis tab', () async {
      final String html = renderAnalysisTab(
          'pkg_foo',
          null,
          ScoreCardData(flags: [PackageFlags.isObsolete]),
          AnalysisView(
            card: ScoreCardData(
              flags: [PackageFlags.isObsolete],
              updated: DateTime(2017, 12, 18, 14, 26, 00),
            ),
          ));
      expectGoldenFile(html, 'analysis_tab_outdated.html', isFragment: true);
    });

    scopedTest('package index page', () {
      final String html = renderPkgIndexPage([
        PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          scoreCard: ScoreCardData(),
        ),
        PackageView.fromModel(
          package: testPackage,
          version: flutterPackageVersion,
          scoreCard: ScoreCardData(
            platformTags: ['flutter'],
            reportTypes: ['pana'],
          ),
        ),
      ], PageLinks.empty(), null);
      expectGoldenFile(html, 'pkg_index_page.html');
    });

    scopedTest('package index page with search', () {
      final searchQuery =
          SearchQuery.parse(query: 'foobar', order: SearchOrder.top);
      final String html = renderPkgIndexPage(
        [
          PackageView.fromModel(
            package: testPackage,
            version: testPackageVersion,
            scoreCard: ScoreCardData(),
            apiPages: [
              ApiPageRef(path: 'some/some-library.html'),
              ApiPageRef(title: 'Class X', path: 'some/x-class.html'),
            ],
          ),
          PackageView.fromModel(
            package: testPackage,
            version: flutterPackageVersion,
            scoreCard: ScoreCardData(
              platformTags: ['flutter'],
              reportTypes: ['pana'],
            ),
          ),
        ],
        PageLinks(0, 50, searchQuery: searchQuery),
        null,
        searchQuery: searchQuery,
        totalCount: 2,
      );
      expectGoldenFile(html, 'search_page.html');
    });

    scopedTest('search with supported qualifier', () {
      final searchQuery = SearchQuery.parse(query: 'email:user@domain.com');
      final String html = renderPkgIndexPage(
        [],
        PageLinks.empty(),
        null,
        searchQuery: searchQuery,
        totalCount: 0,
      );
      expectGoldenFile(html, 'search_supported_qualifier.html');
    });

    scopedTest('search with unsupported qualifier', () {
      final searchQuery = SearchQuery.parse(query: 'foo:bar');
      final String html = renderPkgIndexPage(
        [],
        PageLinks.empty(),
        null,
        searchQuery: searchQuery,
        totalCount: 0,
      );
      expectGoldenFile(html, 'search_unsupported_qualifier.html');
    });

    scopedTest('package versions page', () {
      final String html = renderPkgVersionsPage(
        'foobar',
        [
          testPackageVersion,
          devPackageVersion,
        ],
        [
          Uri.parse('https://pub.dartlang.org/mock-download-uri.tar.gz'),
          Uri.parse('https://pub.dartlang.org/mock-download-uri.tar.gz'),
        ],
      );
      expectGoldenFile(html, 'pkg_versions_page.html');
    });

    scopedTest('authorized page', () {
      final String html = renderAuthorizedPage();
      expectGoldenFile(html, 'authorized_page.html');
    });

    scopedTest('uploader approval page', () {
      final String html = renderUploaderApprovalPage(
          'pkg_foo',
          'admin@example.com',
          'uploader@example.com',
          'https://redirect.to.auth/url');
      expectGoldenFile(html, 'uploader_approval_page.html');
    });

    scopedTest('error page', () {
      final String html = renderErrorPage('error_title', 'error_message', [
        PackageView(
          name: 'popular_pkg',
          version: '1.0.2',
          ellipsizedDescription:
              'Some popular package that is shown on the error page.',
          platforms: KnownPlatforms.all,
          isAwaiting: false,
        ),
      ]);
      expectGoldenFile(html, 'error_page.html');
    });

    scopedTest('pagination: single page', () {
      final String html = renderPagination(PageLinks.empty());
      expectGoldenFile(html, 'pagination_single.html', isFragment: true);
    });

    scopedTest('pagination: in the middle', () {
      final String html = renderPagination(PageLinks(90, 299));
      expectGoldenFile(html, 'pagination_middle.html', isFragment: true);
    });

    scopedTest('pagination: at first page', () {
      final String html = renderPagination(PageLinks(0, 600));
      expectGoldenFile(html, 'pagination_first.html', isFragment: true);
    });

    scopedTest('pagination: at last page', () {
      final String html = renderPagination(PageLinks(90, 91));
      expectGoldenFile(html, 'pagination_last.html', isFragment: true);
    });

    scopedTest('platform tabs: list', () {
      final String html = renderPlatformTabs(platform: 'web');
      expectGoldenFile(html, 'platform_tabs_list.html', isFragment: true);
    });

    scopedTest('platform tabs: search', () {
      final String html = renderPlatformTabs(
          searchQuery: SearchQuery.parse(
        query: 'foo',
        platform: 'web',
      ));
      expectGoldenFile(html, 'platform_tabs_search.html', isFragment: true);
    });
  });

  group('PageLinks', () {
    scopedTest('empty', () {
      final links = PageLinks.empty();
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    scopedTest('one', () {
      final links = PageLinks(0, 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    scopedTest('PageLinks.RESULTS_PER_PAGE - 1', () {
      final links = PageLinks(0, resultsPerPage - 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    scopedTest('PageLinks.RESULTS_PER_PAGE', () {
      final links = PageLinks(0, resultsPerPage);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    scopedTest('PageLinks.RESULTS_PER_PAGE + 1', () {
      final links = PageLinks(0, resultsPerPage + 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    final int page2Offset = resultsPerPage;

    scopedTest('page=2 + one item', () {
      final links = PageLinks(page2Offset, page2Offset + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    scopedTest('page=2 + PageLinks.RESULTS_PER_PAGE - 1', () {
      final links = PageLinks(page2Offset, page2Offset + resultsPerPage - 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    scopedTest('page=2 + PageLinks.RESULTS_PER_PAGE', () {
      final links = PageLinks(page2Offset, page2Offset + resultsPerPage);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    scopedTest('page=2 + PageLinks.RESULTS_PER_PAGE + 1', () {
      final links = PageLinks(page2Offset, page2Offset + resultsPerPage + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 3);
    });

    scopedTest('deep in the middle', () {
      final links = PageLinks(200, 600);
      expect(links.currentPage, 21);
      expect(links.leftmostPage, 16);
      expect(links.rightmostPage, 26);
    });
  });

  group('URLs', () {
    scopedTest('PageLinks defaults', () {
      final query = SearchQuery.parse(query: 'web framework');
      final PageLinks links = PageLinks(0, 100, searchQuery: query);
      expect(links.formatHref(1), '/packages?q=web+framework&page=1');
      expect(links.formatHref(2), '/packages?q=web+framework&page=2');
    });

    scopedTest('PageLinks with platform', () {
      final query =
          SearchQuery.parse(query: 'some framework', platform: 'flutter');
      final PageLinks links = PageLinks(0, 100, searchQuery: query);
      expect(links.formatHref(1), '/flutter/packages?q=some+framework&page=1');
      expect(links.formatHref(2), '/flutter/packages?q=some+framework&page=2');
    });
  });
}

final _panaRuntimeInfo = PanaRuntimeInfo(
  panaVersion: '0.6.2',
  flutterVersions: {'frameworkVersion': '0.0.18'},
  sdkVersion: '2.0.0-dev.7.0',
);
