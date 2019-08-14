// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../analyzer/analyzer_client.dart';
import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import '../static_files.dart';

import '_cache.dart';
import '_utils.dart';
import 'layout.dart';
import 'misc.dart';
import 'package.dart';

/// Renders the `views/pkg/versions/index` template.
String renderPkgVersionsPage(
  Package package,
  List<String> uploaderEmails,
  PackageVersion latestVersion,
  List<PackageVersion> versions,
  List<Uri> versionDownloadUrls,
  AnalysisView latestAnalysis,
) {
  assert(versions.length == versionDownloadUrls.length);
  final card = latestAnalysis?.card;

  final stableVersionRows = [];
  final devVersionRows = [];
  PackageVersion latestDevVersion;
  for (int i = 0; i < versions.length; i++) {
    final PackageVersion version = versions[i];
    final String url = versionDownloadUrls[i].toString();
    final rowHtml = renderVersionTableRow(version, url);
    if (version.semanticVersion.isPreRelease) {
      latestDevVersion ??= version;
      devVersionRows.add(rowHtml);
    } else {
      stableVersionRows.add(rowHtml);
    }
  }

  final htmlBlocks = <String>[];
  if (stableVersionRows.isNotEmpty && devVersionRows.isNotEmpty) {
    htmlBlocks.add(
        '<p>The latest dev release was <a href="#dev">${latestDevVersion.version}</a> '
        'on ${latestDevVersion.shortCreated}.</p>');
  }
  if (stableVersionRows.isNotEmpty) {
    htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
      'id': 'stable',
      'kind': 'Stable',
      'package': {'name': package.name},
      'version_table_rows': stableVersionRows,
    }));
  }
  if (devVersionRows.isNotEmpty) {
    htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
      'id': 'dev',
      'kind': 'Dev',
      'package': {'name': package.name},
      'version_table_rows': devVersionRows,
    }));
  }

  final tabs = <Tab>[];
  if (latestVersion.readme != null) {
    tabs.add(Tab.withLink(
        id: 'readme',
        title: 'Readme',
        href: urls.pkgPageUrl(package.name, fragment: '-readme-tab-')));
  }
  if (latestVersion.changelog != null) {
    tabs.add(Tab.withLink(
        id: 'changelog',
        title: 'Changelog',
        href: urls.pkgPageUrl(package.name, fragment: '-changelog-tab-')));
  }
  if (latestVersion.example != null) {
    tabs.add(Tab.withLink(
        id: 'example',
        title: 'Example',
        href: urls.pkgPageUrl(package.name, fragment: '-example-tab-')));
  }
  tabs.add(Tab.withLink(
      id: 'installing',
      title: 'Installing',
      href: urls.pkgPageUrl(package.name, fragment: '-installing-tab-')));
  tabs.add(Tab.withContent(
    id: 'versions',
    title: 'Versions',
    contentHtml: htmlBlocks.join(),
  ));
  tabs.add(Tab.withLink(
      id: 'analysis',
      titleHtml: renderScoreBox(card?.overallScore,
          isSkipped: card?.isSkipped ?? false,
          isNewPackage: package.isNewPackage()),
      href: urls.pkgPageUrl(package.name, fragment: '-analysis-tab-')));
  tabs.add(Tab.withLink(
    id: 'admin',
    title: 'Admin',
    href: urls.pkgAdminUrl(package.name),
    isHidden: true,
  ));

  final values = {
    'header_html': renderPkgHeader(package, latestVersion, latestAnalysis),
    'tabs_html': renderPkgTabs(tabs),
    'icons': staticUrls.versionsTableIcons,
    'sidebar_html': renderPkgSidebar(
        package, latestVersion, uploaderEmails, latestAnalysis),
    // TODO: render schema_org_pkgmeta_json
  };
  final content = templateCache.renderTemplate('pkg/show', values);

  return renderLayoutPage(
    PageType.package,
    content,
    title: '${package.name} package - All Versions',
    canonicalUrl: urls.pkgPageUrl(package.name, includeHost: true),
    pageData: pkgPageData(package, latestVersion),
  );
}

String renderVersionTableRow(PackageVersion version, String downloadUrl) {
  final versionData = {
    'package': version.package,
    'version': version.version,
    'version_url': urls.pkgPageUrl(version.package, version: version.version),
    'short_created': version.shortCreated,
    'dartdocs_url':
        _attr(urls.pkgDocUrl(version.package, version: version.version)),
    'download_url': _attr(downloadUrl),
    'icons': staticUrls.versionsTableIcons,
  };
  return templateCache.renderTemplate('pkg/versions/version_row', versionData);
}

String _attr(String value) {
  if (value == null) return null;
  return htmlAttrEscape.convert(value);
}
