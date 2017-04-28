// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

import 'package:pub_dartlang_org/templates.dart';

import 'utils.dart';

void main() {
  group('templates', () {
    final templates = new TemplateService(templateDirectory: 'views');

    void expectGoldenFile(String content, String fileName) {
      final golden = new File('test/golden/$fileName').readAsStringSync();
      expect(content.split('\n'), golden.split('\n'));
    }

    test('index page', () {
      final String html = templates.renderIndexPage([testPackageVersion]);
      expectGoldenFile(html, 'index_page.html');
    });

    test('package show page', () {
      final String html = templates.renderPkgShowPage(
          testPackage,
          [testPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          testPackageVersion,
          testPackageVersion,
          testPackageVersion,
          1);
      expectGoldenFile(html, 'pkg_show_page.html');
    });

    test('package show page with flutter_plugin', () {
      final String html = templates.renderPkgShowPage(
          testPackage,
          [flutterPackageVersion],
          [Uri.parse('http://dart-example.com/')],
          flutterPackageVersion,
          flutterPackageVersion,
          flutterPackageVersion,
          1);
      expectGoldenFile(html, 'pkg_show_page_flutter_plugin.html');
    });

    test('package index page', () {
      final String html = templates.renderPkgIndexPage(
          [testPackage], [testPackageVersion], new PackageLinks.empty());
      expectGoldenFile(html, 'pkg_index_page.html');
    });

    test('package versions page', () {
      final String html = templates.renderPkgVersionsPage(testPackage.name,
          [testPackageVersion], [Uri.parse('http://dart-example.com/')]);
      expectGoldenFile(html, 'pkg_versions_page.html');
    });

    test('search page', () {
      final String html = templates.renderSearchPage(
          'foobar',
          [testPackageVersion],
          [testPackageVersion],
          new SearchLinks('foobar', 0, 1));
      expectGoldenFile(html, 'search_page.html');
    });

    test('sitemap page', () {
      final String html = templates.renderSitemapPage();
      expectGoldenFile(html, 'sitemap_page.html');
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
  });
}
