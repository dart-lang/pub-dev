// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:html/parser.dart';
import 'package:pub_dartlang_org/shared/analyzer_client.dart';
import 'package:test/test.dart';

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
        new MockAnalysisView(),
        new MockAnalysisView(platforms: ['flutter']),
      ]);
      expectGoldenFile(html, 'index_page.html');
    });

    test('index page v2', () {
      final popularHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new MockAnalysisView(platforms: ['web']),
        ),
      ]);
      final updatedHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: flutterPackageVersion,
          analysis: new MockAnalysisView(platforms: ['flutter']),
        ),
      ]);
      final newestHtml = templates.renderMiniList([
        new PackageView.fromModel(
          package: testPackage,
          version: flutterPackageVersion,
          analysis: new MockAnalysisView(platforms: ['flutter', 'server']),
        ),
      ]);
      final String html =
          templates.renderIndexPageV2(popularHtml, updatedHtml, newestHtml);
      expectGoldenFile(html, 'v2/index_page.html');
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
          new MockAnalysisView()..licenseText = 'BSD');
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
          new MockAnalysisView()..licenseText = 'BSD');
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
          new MockAnalysisView()..platforms = ['flutter']);
      expectGoldenFile(html, 'v2/pkg_show_page_flutter_plugin.html');
    });

    test('package analysis tab v2', () async {
      // no content
      expect(templates.renderAnalysisTabV2(null), isNull);

      // stored analysis of http
      final String json =
          await new File('$goldenDir/v2/analysis_tab_http.json').readAsString();
      final String html = templates.renderAnalysisTabV2(
          new AnalysisView(new AnalysisData.fromJson(JSON.decode(json))));
      expectGoldenFile(html, 'v2/analysis_tab_http.html', isFragment: true);
    });

    test('package index page', () {
      final String html = templates.renderPkgIndexPage([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new MockAnalysisView(),
        ),
        new PackageView.fromModel(
          package: testPackage,
          version: flutterPackageVersion,
          analysis: new MockAnalysisView(platforms: ['flutter']),
        ),
      ], new PackageLinks.empty());
      expectGoldenFile(html, 'pkg_index_page.html');
    });

    test('package index page v2', () {
      final String html = templates.renderPkgIndexPageV2([
        new PackageView.fromModel(
          package: testPackage,
          version: testPackageVersion,
          analysis: new MockAnalysisView(),
        ),
        new PackageView.fromModel(
          package: testPackage,
          version: flutterPackageVersion,
          analysis: new MockAnalysisView(platforms: ['flutter']),
        ),
      ], new PackageLinks.empty(), null);
      expectGoldenFile(html, 'v2/pkg_index_page.html');
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
            analysis: new MockAnalysisView(platforms: ['flutter']),
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
      final query = new SearchQuery('foobar', offset: 0);
      final resultPage = new SearchResultPage(
        query,
        2,
        [
          new PackageView.fromModel(version: testPackageVersion),
          new PackageView.fromModel(
              version: flutterPackageVersion,
              analysis: new MockAnalysisView(platforms: ['flutter'])),
        ],
      );
      final String html =
          templates.renderSearchPage(resultPage, new SearchLinks(query, 2));
      expectGoldenFile(html, 'search_page.html');
    });

    test('search page v2', () {
      final query = new SearchQuery('foobar', offset: 0);
      final resultPage = new SearchResultPage(
        query,
        2,
        [
          new PackageView.fromModel(version: testPackageVersion),
          new PackageView.fromModel(
              version: flutterPackageVersion,
              analysis: new MockAnalysisView(platforms: ['flutter'])),
        ],
      );
      final String html =
          templates.renderSearchPageV2(resultPage, new SearchLinks(query, 2));
      expectGoldenFile(html, 'v2/search_page.html');
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
      final query = new SearchQuery('web framework');
      final SearchLinks links = new SearchLinks(query, 100);
      expect(links.formatHref(1), '/search?q=web+framework&page=1');
      expect(links.formatHref(2), '/search?q=web+framework&page=2');
    });

    test('SearchLinks with type', () {
      final query = new SearchQuery('web framework',
          platformPredicate: new PlatformPredicate(required: ['server']));
      final SearchLinks links = new SearchLinks(query, 100);
      expect(links.formatHref(1),
          '/search?q=web+framework&platforms=server&page=1');
      expect(links.formatHref(2),
          '/search?q=web+framework&platforms=server&page=2');
    });
  });
}

class MockAnalysisView implements AnalysisView {
  List<String> transitiveDependencies;

  @override
  bool hasAnalysisData = true;

  @override
  AnalysisStatus analysisStatus;

  @override
  List<String> getTransitiveDependencies() => transitiveDependencies;

  @override
  double health;

  @override
  String licenseText;

  @override
  DateTime timestamp;

  @override
  List<String> platforms;

  MockAnalysisView({
    this.platforms,
    this.transitiveDependencies: const [],
  });
}
