// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import '../static_files.dart';

import '_cache.dart';
import '_utils.dart';
import 'detail_page.dart';
import 'layout.dart';
import 'package.dart';

/// Renders the `views/pkg/versions/index` template.
String renderPkgVersionsPage(
  PackagePageData data,
  List<PackageVersion> versions,
  List<Uri> versionDownloadUrls,
) {
  assert(versions.length == versionDownloadUrls.length);

  final stableVersionRows = [];
  final prereleaseVersionRows = [];
  final latestPrereleaseVersion = versions.firstWhere(
    (v) => v.version == data.package.latestPrereleaseVersion,
    orElse: () => null,
  );
  for (int i = 0; i < versions.length; i++) {
    final PackageVersion version = versions[i];
    final String url = versionDownloadUrls[i].toString();
    final rowHtml = renderVersionTableRow(version, url);
    if (version.semanticVersion.isPreRelease) {
      prereleaseVersionRows.add(rowHtml);
    } else {
      stableVersionRows.add(rowHtml);
    }
  }

  final htmlBlocks = <String>[];
  if (stableVersionRows.isNotEmpty &&
      prereleaseVersionRows.isNotEmpty &&
      data.package.showPrereleaseVersion) {
    htmlBlocks.add(
        '<p>The latest prerelease was <a href="#prerelease">${latestPrereleaseVersion.version}</a> '
        'on ${latestPrereleaseVersion.shortCreated}.</p>');
  }
  if (stableVersionRows.isNotEmpty) {
    htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
      'id': 'stable',
      'kind': 'Stable',
      'package': {'name': data.package.name},
      'version_table_rows': stableVersionRows,
    }));
  }
  if (prereleaseVersionRows.isNotEmpty) {
    htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
      'id': 'prerelease',
      'kind': 'Prerelease',
      'package': {'name': data.package.name},
      'version_table_rows': prereleaseVersionRows,
    }));
  }

  final tabs = buildPackageTabs(
    packagePageData: data,
    versionsTab: Tab.withContent(
      id: 'versions',
      title: 'Versions',
      contentHtml: htmlBlocks.join(),
    ),
  );

  final content = renderDetailPage(
    headerHtml: renderPkgHeader(data),
    tabs: tabs,
    infoBoxLead: data.version.ellipsizedDescription,
    infoBoxHtml: renderPkgInfoBox(data),
    footerHtml: renderPackageSchemaOrgHtml(data),
  );

  final canonicalUrl = urls.pkgPageUrl(data.package.name,
      includeHost: true, pkgPageTab: urls.PkgPageTab.versions);
  return renderLayoutPage(
    PageType.package,
    content,
    title: '${data.package.name} package - All Versions',
    canonicalUrl: canonicalUrl,
    shareUrl: canonicalUrl,
    pageData: pkgPageData(data.package, data.version),
    noIndex: data.package.isDiscontinued,
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
