// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';
import 'package:pana/pana.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/scorecard/models.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/platform.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/static_files.dart';
import 'package:pub_dartlang_org/frontend/templates.dart';

import '../shared/html_validation.dart';
import 'utils.dart';

const String goldenDir = 'test/frontend/golden';

final _regenerateGoldens = false;

void main() {
  group('templates', () {
    setUpAll(() {
      final cache = new StaticFileCache();
      for (String path in mockStaticFiles) {
        final file = new StaticFile(
            '${staticUrls.staticPath}/$path',
            'text/mock',
            [],
            new DateTime.now(),
            'mocked_hash_${path.hashCode.abs()}');
        cache.addFile(file);
      }
      registerStaticFileCache(cache);
    });

    final templates = new TemplateService(templateDirectory: 'views');

    void expectGoldenFile(String content, String fileName,
        {bool isFragment = false}) {
      // Making sure it is valid HTML
      final htmlParser = new HtmlParser(content, strict: true);

      if (isFragment) {
        final root = htmlParser.parseFragment();
        validateHtml(root);
      } else {
        final root = htmlParser.parse();
        validateHtml(root);
      }

      if (_regenerateGoldens) {
        new File('$goldenDir/$fileName').writeAsStringSync(content);
        fail('Set `_regenerateGoldens` to `false` to run tests.');
      }
      final golden = new File('$goldenDir/$fileName').readAsStringSync();
      expect(content.split('\n'), golden.split('\n'));
    }

    test('index page', () {
      final popularHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          scoreCard: new ScoreCardData(
            platformTags: ['web'],
            reportTypes: ['pana'],
          ),
        ),
      ]);
      final String html = templates.renderIndexPage(popularHtml, null);
      expectGoldenFile(html, 'index_page.html');
    });

    test('landing page flutter', () {
      final popularHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          scoreCard: new ScoreCardData(
            platformTags: ['flutter'],
            reportTypes: ['pana'],
          ),
        ),
      ]);
      final String html =
          templates.renderIndexPage(popularHtml, KnownPlatforms.flutter);
      expectGoldenFile(html, 'flutter_landing_page.html');
    });

    test('landing page web', () {
      final popularHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          scoreCard: new ScoreCardData(
            platformTags: ['web'],
            reportTypes: ['pana'],
          ),
        ),
      ]);
      final String html =
          templates.renderIndexPage(popularHtml, KnownPlatforms.web);
      expectGoldenFile(html, 'web_landing_page.html');
    });

    test('package show page', () {
      final String html = templates.renderPkgShowPage(
          testPackage,
          false,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          devPackageVersion,
          1,
          new ScoreCardData(reportTypes: ['pana']),
          new MockAnalysisView()
            ..panaReportStatus = ReportStatus.success
            ..timestamp = new DateTime(2018, 02, 05)
            ..directDependencies = [
              new PkgDependency(
                package: 'quiver',
                dependencyType: 'direct',
                constraintType: 'normal',
                constraint: new VersionConstraint.parse('^1.0.0'),
                resolved: new Version.parse('1.0.0'),
                available: null,
                errors: null,
              ),
              new PkgDependency(
                package: 'http',
                dependencyType: 'direct',
                constraintType: 'normal',
                constraint: new VersionConstraint.parse('>=1.0.0 <1.2.0'),
                resolved: new Version.parse('1.2.0'),
                available: new Version.parse('1.3.0'),
                errors: null,
              )
            ]
            ..licenses = [new LicenseFile('LICENSE.txt', 'BSD')]);
      expectGoldenFile(html, 'pkg_show_page.html');
    });

    test('package show page - with version', () {
      final String html = templates.renderPkgShowPage(
          testPackage,
          true,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          devPackageVersion,
          1,
          new ScoreCardData(reportTypes: ['pana']),
          new MockAnalysisView()
            ..panaReportStatus = ReportStatus.success
            ..timestamp = new DateTime(2018, 02, 05)
            ..directDependencies = [
              new PkgDependency(
                package: 'quiver',
                dependencyType: 'direct',
                constraintType: 'normal',
                constraint: new VersionConstraint.parse('^1.0.0'),
                resolved: new Version.parse('1.0.0'),
                available: null,
                errors: null,
              ),
              new PkgDependency(
                package: 'http',
                dependencyType: 'direct',
                constraintType: 'normal',
                constraint: new VersionConstraint.parse('>=1.0.0 <1.2.0'),
                resolved: new Version.parse('1.2.0'),
                available: new Version.parse('1.3.0'),
                errors: null,
              )
            ]
            ..licenses = [new LicenseFile('LICENSE.txt', 'BSD')]);
      expectGoldenFile(html, 'pkg_show_version_page.html');
    });

    test('package show page with flutter_plugin', () {
      final String html = templates.renderPkgShowPage(
          testPackage,
          false,
          [flutterPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          flutterPackageVersion,
          flutterPackageVersion,
          flutterPackageVersion,
          1,
          new ScoreCardData(
            healthScore: 0.99,
            maintenanceScore: 0.99,
            popularityScore: 0.3,
            platformTags: ['flutter'],
          ),
          new MockAnalysisView()
            ..panaReportStatus = ReportStatus.success
            ..timestamp = new DateTime(2018, 02, 05)
            ..platforms = ['flutter']);
      expectGoldenFile(html, 'pkg_show_page_flutter_plugin.html');
    });

    test('package show page with outdated version', () {
      final String html = templates.renderPkgShowPage(
          testPackage,
          true /* isVersionPage */,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1,
          new ScoreCardData(flags: [PackageFlags.isObsolete]),
          new MockAnalysisView(
            timestamp: new DateTime(2018, 02, 05),
          ));

      expectGoldenFile(html, 'pkg_show_page_outdated.html');
    });

    test('package show page with discontinued version', () {
      final String html = templates.renderPkgShowPage(
          discontinuedPackage,
          false,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1,
          new ScoreCardData(flags: [PackageFlags.isDiscontinued]),
          new MockAnalysisView(
            timestamp: new DateTime(2018, 02, 05),
          ));

      expectGoldenFile(html, 'pkg_show_page_discontinued.html');
    });

    test('package show page with legacy version', () {
      final summary = createPanaSummaryForLegacy(
          testPackageVersion.package, testPackageVersion.version);
      final analysisView = new MockAnalysisView()
        ..timestamp = new DateTime(2018, 08, 09)
        ..panaVersion = '0.10.9'
        ..panaSuggestions = summary?.suggestions
        ..maintenanceSuggestions = summary.maintenance?.suggestions;
      final String html = templates.renderPkgShowPage(
          testPackage,
          true /* isVersionPage */,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1,
          new ScoreCardData(
            popularityScore: 0.5,
            flags: [PackageFlags.isLegacy],
          ),
          analysisView);

      expectGoldenFile(html, 'pkg_show_page_legacy.html');
    });

    test('no content for analysis tab', () async {
      // no content
      expect(templates.renderAnalysisTab('pkg_foo', null, null, null), isNull);
    });

    test('analysis tab: http', () async {
      // stored analysis of http
      final String content =
          await new File('$goldenDir/analysis_tab_http.json').readAsString();
      final map = json.decode(content) as Map<String, dynamic>;
      final card =
          new ScoreCardData.fromJson(map['scorecard'] as Map<String, dynamic>);
      final reports = map['reports'] as Map<String, dynamic>;
      final panaReport =
          new PanaReport.fromJson(reports['pana'] as Map<String, dynamic>);
      final view = new AnalysisView(card: card, panaReport: panaReport);
      final String html = templates.renderAnalysisTab(
          'http', '>=1.23.0-dev.0.0 <2.0.0', card, view);
      expectGoldenFile(html, 'analysis_tab_http.html', isFragment: true);
    });

    test('mock analysis tab', () async {
      final String html = templates.renderAnalysisTab(
          'pkg_foo',
          '>=1.25.0-dev.9.0 <2.0.0',
          new ScoreCardData(
            healthScore: 0.90234,
            maintenanceScore: 0.8932343,
            popularityScore: 0.2323232,
          ),
          new MockAnalysisView(
            panaReportStatus: ReportStatus.failed,
            timestamp: new DateTime.utc(2017, 10, 26, 14, 03, 06),
            platforms: ['web'],
            platformsReason: 'All libraries agree.',
            health: 0.95,
            healthSuggestions: [
              new Suggestion.error(SuggestionCode.dartfmtAborted,
                  'Fix `dartfmt`.', 'Running `dartfmt -n .` failed.'),
            ],
            directDependencies: [
              new PkgDependency(
                package: 'http',
                dependencyType: 'direct',
                constraintType: 'normal',
                constraint: new VersionConstraint.parse('^1.0.0'),
                resolved: new Version.parse('1.0.0'),
                available: new Version.parse('1.1.0'),
                errors: null,
              ),
            ],
            transitiveDependencies: [
              new PkgDependency(
                package: 'async',
                dependencyType: 'transitive',
                constraintType: 'normal',
                constraint: new VersionConstraint.parse('>=0.3.0 <1.0.0'),
                resolved: new Version.parse('0.5.1'),
                available: new Version.parse('1.0.2'),
                errors: null,
              ),
            ],
          ));
      expectGoldenFile(html, 'analysis_tab_mock.html', isFragment: true);
    });

    test('aborted analysis tab', () async {
      final String html = templates.renderAnalysisTab(
          'pkg_foo',
          null,
          new ScoreCardData(),
          new MockAnalysisView()
            ..panaVersion = '0.8.0'
            ..flutterVersion = '0.0.20'
            ..panaReportStatus = ReportStatus.aborted
            ..timestamp = new DateTime(2017, 12, 18, 14, 26, 00));
      expectGoldenFile(html, 'analysis_tab_aborted.html', isFragment: true);
    });

    test('outdated analysis tab', () async {
      final String html = templates.renderAnalysisTab(
          'pkg_foo',
          null,
          new ScoreCardData(flags: [PackageFlags.isObsolete]),
          new MockAnalysisView()
            ..panaVersion = '0.8.0'
            ..flutterVersion = '0.0.20'
            ..timestamp = new DateTime(2017, 12, 18, 14, 26, 00));
      expectGoldenFile(html, 'analysis_tab_outdated.html', isFragment: true);
    });

    test('package index page', () {
      final String html = templates.renderPkgIndexPage([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          scoreCard: new ScoreCardData(),
        ),
        new PackageView.fromModel(
          package: testPackage,
          version: flutterPackageVersion,
          scoreCard: new ScoreCardData(
            platformTags: ['flutter'],
            reportTypes: ['pana'],
          ),
        ),
      ], new PageLinks.empty(), null);
      expectGoldenFile(html, 'pkg_index_page.html');
    });

    test('package index page with search', () {
      final searchQuery =
          new SearchQuery.parse(query: 'foobar', order: SearchOrder.top);
      final String html = templates.renderPkgIndexPage(
        [
          new PackageView.fromModel(
            package: testPackage,
            version: testPackageVersion,
            scoreCard: new ScoreCardData(),
            apiPages: [
              new ApiPageRef(path: 'some/some-library.html'),
              new ApiPageRef(title: 'Class X', path: 'some/x-class.html'),
            ],
          ),
          new PackageView.fromModel(
            package: testPackage,
            version: flutterPackageVersion,
            scoreCard: new ScoreCardData(
              platformTags: ['flutter'],
              reportTypes: ['pana'],
            ),
          ),
        ],
        new PageLinks(0, 50, searchQuery: searchQuery),
        null,
        searchQuery: searchQuery,
        totalCount: 2,
      );
      expectGoldenFile(html, 'search_page.html');
    });

    test('search with supported qualifier', () {
      final searchQuery = new SearchQuery.parse(query: 'email:user@domain.com');
      final String html = templates.renderPkgIndexPage(
        [],
        new PageLinks.empty(),
        null,
        searchQuery: searchQuery,
        totalCount: 0,
      );
      expectGoldenFile(html, 'search_supported_qualifier.html');
    });

    test('search with unsupported qualifier', () {
      final searchQuery = new SearchQuery.parse(query: 'foo:bar');
      final String html = templates.renderPkgIndexPage(
        [],
        new PageLinks.empty(),
        null,
        searchQuery: searchQuery,
        totalCount: 0,
      );
      expectGoldenFile(html, 'search_unsupported_qualifier.html');
    });

    test('package versions page', () {
      final String html = templates.renderPkgVersionsPage(
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

    test('authorized page', () {
      final String html = templates.renderAuthorizedPage();
      expectGoldenFile(html, 'authorized_page.html');
    });

    test('error page', () {
      final String html =
          templates.renderErrorPage('error_title', 'error_message', [
        new PackageView(
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

    test('pagination: single page', () {
      final String html = templates.renderPagination(new PageLinks.empty());
      expectGoldenFile(html, 'pagination_single.html', isFragment: true);
    });

    test('pagination: in the middle', () {
      final String html = templates.renderPagination(new PageLinks(90, 299));
      expectGoldenFile(html, 'pagination_middle.html', isFragment: true);
    });

    test('pagination: at first page', () {
      final String html = templates.renderPagination(new PageLinks(0, 600));
      expectGoldenFile(html, 'pagination_first.html', isFragment: true);
    });

    test('pagination: at last page', () {
      final String html = templates.renderPagination(new PageLinks(90, 91));
      expectGoldenFile(html, 'pagination_last.html', isFragment: true);
    });

    test('platform tabs: list', () {
      final String html = templates.renderPlatformTabs(platform: 'web');
      expectGoldenFile(html, 'platform_tabs_list.html', isFragment: true);
    });

    test('platform tabs: search', () {
      final String html = templates.renderPlatformTabs(
          searchQuery: new SearchQuery.parse(
        query: 'foo',
        platform: 'web',
      ));
      expectGoldenFile(html, 'platform_tabs_search.html', isFragment: true);
    });
  });

  group('PageLinks', () {
    test('empty', () {
      final links = new PageLinks.empty();
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('one', () {
      final links = new PageLinks(0, 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE - 1', () {
      final links = new PageLinks(0, resultsPerPage - 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE', () {
      final links = new PageLinks(0, resultsPerPage);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PageLinks.RESULTS_PER_PAGE + 1', () {
      final links = new PageLinks(0, resultsPerPage + 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    final int page2Offset = resultsPerPage;

    test('page=2 + one item', () {
      final links = new PageLinks(page2Offset, page2Offset + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE - 1', () {
      final links =
          new PageLinks(page2Offset, page2Offset + resultsPerPage - 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE', () {
      final links = new PageLinks(page2Offset, page2Offset + resultsPerPage);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PageLinks.RESULTS_PER_PAGE + 1', () {
      final links =
          new PageLinks(page2Offset, page2Offset + resultsPerPage + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 3);
    });

    test('deep in the middle', () {
      final links = new PageLinks(200, 600);
      expect(links.currentPage, 21);
      expect(links.leftmostPage, 16);
      expect(links.rightmostPage, 26);
    });
  });

  group('URLs', () {
    test('PageLinks defaults', () {
      final query = new SearchQuery.parse(query: 'web framework');
      final PageLinks links = new PageLinks(0, 100, searchQuery: query);
      expect(links.formatHref(1), '/packages?q=web+framework&page=1');
      expect(links.formatHref(2), '/packages?q=web+framework&page=2');
    });

    test('PageLinks with platform', () {
      final query =
          new SearchQuery.parse(query: 'some framework', platform: 'flutter');
      final PageLinks links = new PageLinks(0, 100, searchQuery: query);
      expect(links.formatHref(1), '/flutter/packages?q=some+framework&page=1');
      expect(links.formatHref(2), '/flutter/packages?q=some+framework&page=2');
    });
  });
}

class MockAnalysisView implements AnalysisView {
  @override
  bool hasAnalysisData = true;

  @override
  bool hasPanaSummary = true;

  @override
  String panaReportStatus;

  @override
  String dartSdkVersion = '2.0.0-dev.7.0';

  @override
  String panaVersion = '0.6.2';

  @override
  String flutterVersion = '0.0.18';

  @override
  List<PkgDependency> directDependencies;

  @override
  List<PkgDependency> transitiveDependencies;

  @override
  List<PkgDependency> devDependencies;

  @override
  List<PkgDependency> allDependencies;

  @override
  double health;

  @override
  List<LicenseFile> licenses;

  @override
  DateTime timestamp;

  @override
  List<String> platforms;

  @override
  String platformsReason;

  @override
  List<Suggestion> panaSuggestions;

  @override
  List<Suggestion> healthSuggestions;

  @override
  List<Suggestion> maintenanceSuggestions;

  @override
  double maintenanceScore;

  MockAnalysisView({
    this.panaReportStatus,
    this.timestamp,
    this.platforms,
    this.platformsReason,
    this.directDependencies,
    this.transitiveDependencies,
    this.devDependencies,
    this.health,
    this.panaSuggestions,
    this.healthSuggestions,
    this.maintenanceSuggestions,
  });
}
