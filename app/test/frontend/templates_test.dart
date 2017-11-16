// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';

import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:pub_dartlang_org/shared/platform.dart';
import 'package:pub_dartlang_org/shared/search_service.dart';
import 'package:pub_dartlang_org/frontend/models.dart';
import 'package:pub_dartlang_org/frontend/templates.dart';
import 'package:pub_dartlang_org/frontend/search_service.dart'
    show SearchResultPage;

import 'utils.dart';

const String goldenDir = 'test/frontend/golden';

void main() {
  group('templates', () {
    final templates = new TemplateService(templateDirectory: 'views');

    void expectGoldenFile(String content, String fileName,
        {bool isFragment: false}) {
      // Making sure it is valid HTML
      final htmlParser = new HtmlParser(content, strict: true);
      if (isFragment) {
        htmlParser.parseFragment();
      } else {
        htmlParser.parse();
      }
      final golden = new File('$goldenDir/$fileName').readAsStringSync();
      expect(content.split('\n'), golden.split('\n'));
    }

    test('index page', () {
      final String html = templates.renderIndexPage([
        testPackageVersion,
        flutterPackageVersion,
      ], [
        new AnalysisExtract(),
        new AnalysisExtract(platforms: ['flutter']),
      ]);
      expectGoldenFile(html, 'index_page.html');
    });

    test('index page v2', () {
      final popularHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new AnalysisExtract(platforms: ['web']),
        ),
      ]);
      final String html = templates.renderIndexPageV2(popularHtml, null);
      expectGoldenFile(html, 'v2/index_page.html');
    });

    test('landing page v2: flutter', () {
      final popularHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new AnalysisExtract(platforms: ['flutter']),
        ),
      ]);
      final String html =
          templates.renderIndexPageV2(popularHtml, KnownPlatforms.flutter);
      expectGoldenFile(html, 'v2/flutter_landing_page.html');
    });

    test('landing page v2: server', () {
      final popularHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new AnalysisExtract(platforms: ['server']),
        ),
      ]);
      final String html =
          templates.renderIndexPageV2(popularHtml, KnownPlatforms.server);
      expectGoldenFile(html, 'v2/server_landing_page.html');
    });

    test('landing page v2: web', () {
      final popularHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new AnalysisExtract(platforms: ['web']),
        ),
      ]);
      final String html =
          templates.renderIndexPageV2(popularHtml, KnownPlatforms.web);
      expectGoldenFile(html, 'v2/web_landing_page.html');
    });

    test('package show page', () {
      final String html = templates.renderPkgShowPage(
          testPackage,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1,
          null,
          new MockAnalysisView()
            ..licenses = [new LicenseFile('license.txt', 'BSD')]);
      expectGoldenFile(html, 'pkg_show_page.html');
    });

    test('package show page v2', () {
      final String html = templates.renderPkgShowPageV2(
          testPackage,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1,
          null,
          new MockAnalysisView()
            ..licenses = [new LicenseFile('LICENSE.txt', 'BSD')]);
      expectGoldenFile(html, 'v2/pkg_show_page.html');
    });

    test('package show page with flutter_plugin', () {
      final String html = templates.renderPkgShowPage(
          testPackage,
          [flutterPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          flutterPackageVersion,
          flutterPackageVersion,
          flutterPackageVersion,
          1,
          null,
          new MockAnalysisView()..platforms = ['flutter']);
      expectGoldenFile(html, 'pkg_show_page_flutter_plugin.html');
    });

    test('package show page with flutter_plugin v2', () {
      final String html = templates.renderPkgShowPageV2(
          testPackage,
          [flutterPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          flutterPackageVersion,
          flutterPackageVersion,
          flutterPackageVersion,
          1,
          new AnalysisExtract(
            health: 0.99,
            maintenance: 0.99,
            popularity: 0.3,
            platforms: ['flutter'],
          ),
          new MockAnalysisView()..platforms = ['flutter']);
      expectGoldenFile(html, 'v2/pkg_show_page_flutter_plugin.html');
    });

    test('no content for analysis tab', () async {
      // no content
      expect(templates.renderAnalysisTabV2(null), isNull);
    });

    test('analysis tab: http', () async {
      // stored analysis of http
      final String json =
          await new File('$goldenDir/v2/analysis_tab_http.json').readAsString();
      final String html = templates.renderAnalysisTabV2(
          new AnalysisView(new AnalysisData.fromJson(JSON.decode(json))));
      expectGoldenFile(html, 'v2/analysis_tab_http.html', isFragment: true);
    });

    test('mock analysis tab', () async {
      final String html = templates.renderAnalysisTabV2(new MockAnalysisView(
        analysisStatus: AnalysisStatus.failure,
        timestamp: new DateTime.utc(2017, 10, 26, 14, 03, 06),
        platforms: ['web'],
        health: 0.95,
        suggestions: [
          new Suggestion.error(
              'Fix `dartfmt`.', 'Running `dartfmt -n .` failed.'),
        ],
        directDependencies: [
          new PkgDependency(
            'http',
            'direct',
            'normal',
            new VersionConstraint.parse('^1.0.0'),
            new Version.parse('1.0.0'),
            new Version.parse('1.1.0'),
            null,
          ),
        ],
        transitiveDependencies: [
          new PkgDependency(
            'async',
            'transitive',
            'normal',
            new VersionConstraint.parse('>=0.3.0 <1.0.0'),
            new Version.parse('0.5.1'),
            new Version.parse('1.0.2'),
            null,
          ),
        ],
      ));
      expectGoldenFile(html, 'v2/analysis_tab_mock.html', isFragment: true);
    });

    test('package index page', () {
      final String html = templates.renderPkgIndexPage([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new AnalysisExtract(),
        ),
        new PackageView.fromModel(
          package: testPackage,
          version: flutterPackageVersion,
          analysis: new AnalysisExtract(platforms: ['flutter']),
        ),
      ], new PackageLinks.empty());
      expectGoldenFile(html, 'pkg_index_page.html');
    });

    test('package index page v2', () {
      final String html = templates.renderPkgIndexPageV2([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new AnalysisExtract(),
        ),
        new PackageView.fromModel(
          package: testPackage,
          version: flutterPackageVersion,
          analysis: new AnalysisExtract(platforms: ['flutter']),
        ),
      ], new PackageLinks.empty(), null);
      expectGoldenFile(html, 'v2/pkg_index_page.html');
    });

    test('package index page with search v2', () {
      final searchQuery =
          new SearchQuery.parse(text: 'foobar', order: SearchOrder.top);
      final String html = templates.renderPkgIndexPageV2(
        [
          new PackageView.fromModel(
            package: testPackage,
            version: testPackageVersion,
            analysis: new AnalysisExtract(),
          ),
          new PackageView.fromModel(
            package: testPackage,
            version: flutterPackageVersion,
            analysis: new AnalysisExtract(platforms: ['flutter']),
          ),
        ],
        new PackageLinks(0, 50, searchQuery: searchQuery),
        null,
        searchQuery: searchQuery,
        totalCount: 2,
      );
      expectGoldenFile(html, 'v2/search_page.html');
    });

    test('package versions page', () {
      final String html = templates.renderPkgVersionsPage(testPackage.name,
          [testPackageVersion], [Uri.parse('http://dart-example.com/')]);
      expectGoldenFile(html, 'pkg_versions_page.html');
    });

    test('flutter packages - index page #2', () {
      final String html = templates.renderPkgIndexPage(
        [
          new PackageView.fromModel(
            package: testPackage,
            version: flutterPackageVersion,
            analysis: new AnalysisExtract(platforms: ['flutter']),
          ),
        ],
        new PackageLinks(
            PackageLinks.resultsPerPage, PackageLinks.resultsPerPage + 1),
        title: 'Flutter Packages',
        faviconUrl: LogoUrls.flutterLogo32x32,
        descriptionHtml: flutterPackagesDescriptionHtml,
      );
      expectGoldenFile(html, 'flutter_packages_index_page2.html');
    });

    test('search page', () {
      final query = new SearchQuery.parse(text: 'foobar', offset: 0);
      final resultPage = new SearchResultPage(
        query,
        2,
        [
          new PackageView.fromModel(version: testPackageVersion),
          new PackageView.fromModel(
              version: flutterPackageVersion,
              analysis: new AnalysisExtract(platforms: ['flutter'])),
        ],
      );
      final String html =
          templates.renderSearchPage(resultPage, new SearchLinks(query, 2));
      expectGoldenFile(html, 'search_page.html');
    });

    test('authorized page', () {
      final String html = templates.renderAuthorizedPage();
      expectGoldenFile(html, 'authorized_page.html');
    });

    test('error page', () {
      final String html = templates.renderErrorPage(
          'error_status', 'error_message', 'error_traceback');
      expectGoldenFile(html, 'error_page.html');
    });

    test('pagination: single page', () {
      final String html = templates.renderPagination(new PackageLinks.empty());
      expectGoldenFile(html, 'pagination_single.html', isFragment: true);
    });

    test('pagination: in the middle', () {
      final String html = templates.renderPagination(new PackageLinks(90, 299));
      expectGoldenFile(html, 'pagination_middle.html', isFragment: true);
    });

    test('pagination: at first page', () {
      final String html = templates.renderPagination(new PackageLinks(0, 600));
      expectGoldenFile(html, 'pagination_first.html', isFragment: true);
    });

    test('pagination: at last page', () {
      final String html = templates.renderPagination(new PackageLinks(90, 91));
      expectGoldenFile(html, 'pagination_last.html', isFragment: true);
    });

    test('platform tabs: list', () {
      final String html = templates.renderPlatformTabs(platform: 'web');
      expectGoldenFile(html, 'v2/platform_tabs_list.html', isFragment: true);
    });

    test('platform tabs: search', () {
      final String html = templates.renderPlatformTabs(
          searchQuery: new SearchQuery.parse(
        text: 'foo',
        platform: 'server',
      ));
      expectGoldenFile(html, 'v2/platform_tabs_search.html', isFragment: true);
    });
  });

  group('PageLinks', () {
    test('empty', () {
      final links = new PackageLinks.empty();
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('one', () {
      final links = new PackageLinks(0, 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PackageLinks.RESULTS_PER_PAGE - 1', () {
      final links = new PackageLinks(0, PackageLinks.resultsPerPage - 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PackageLinks.RESULTS_PER_PAGE', () {
      final links = new PackageLinks(0, PackageLinks.resultsPerPage);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 1);
    });

    test('PackageLinks.RESULTS_PER_PAGE + 1', () {
      final links = new PackageLinks(0, PackageLinks.resultsPerPage + 1);
      expect(links.currentPage, 1);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    final int page2Offset = PackageLinks.resultsPerPage;

    test('page=2 + one item', () {
      final links = new PackageLinks(page2Offset, page2Offset + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PackageLinks.RESULTS_PER_PAGE - 1', () {
      final links = new PackageLinks(
          page2Offset, page2Offset + PackageLinks.resultsPerPage - 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PackageLinks.RESULTS_PER_PAGE', () {
      final links = new PackageLinks(
          page2Offset, page2Offset + PackageLinks.resultsPerPage);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 2);
    });

    test('page=2 + PackageLinks.RESULTS_PER_PAGE + 1', () {
      final links = new PackageLinks(
          page2Offset, page2Offset + PackageLinks.resultsPerPage + 1);
      expect(links.currentPage, 2);
      expect(links.leftmostPage, 1);
      expect(links.rightmostPage, 3);
    });

    test('deep in the middle', () {
      final links = new PackageLinks(200, 600);
      expect(links.currentPage, 21);
      expect(links.leftmostPage, 16);
      expect(links.rightmostPage, 26);
    });
  });

  group('URLs', () {
    test('SearchLinks defaults', () {
      final query = new SearchQuery.parse(text: 'web framework');
      final SearchLinks links = new SearchLinks(query, 100);
      expect(links.formatHref(1), '/search?q=web+framework&page=1');
      expect(links.formatHref(2), '/search?q=web+framework&page=2');
    });

    test('SearchLinks with type', () {
      final query =
          new SearchQuery.parse(text: 'web framework', platform: 'server');
      final SearchLinks links = new SearchLinks(query, 100);
      expect(links.formatHref(1),
          '/search?q=web+framework&platforms=server&page=1');
      expect(links.formatHref(2),
          '/search?q=web+framework&platforms=server&page=2');
    });
  });
}

class MockAnalysisView implements AnalysisView {
  @override
  bool hasAnalysisData = true;

  @override
  AnalysisStatus analysisStatus;

  @override
  List<PkgDependency> directDependencies;

  @override
  List<PkgDependency> transitiveDependencies;

  @override
  List<PkgDependency> devDependencies;

  @override
  double health;

  @override
  List<LicenseFile> licenses;

  @override
  DateTime timestamp;

  @override
  List<String> platforms;

  @override
  List<Suggestion> suggestions;

  @override
  double maintenanceScore;

  MockAnalysisView({
    this.analysisStatus,
    this.timestamp,
    this.platforms,
    this.directDependencies,
    this.transitiveDependencies,
    this.devDependencies,
    this.health,
    this.suggestions,
  });
}
