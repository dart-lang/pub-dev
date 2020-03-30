// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import '../request_context.dart';
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
      'package': {'name': data.package.name},
      'version_table_rows': stableVersionRows,
    }));
  }
  if (devVersionRows.isNotEmpty) {
    htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
      'id': 'dev',
      'kind': 'Dev',
      'package': {'name': data.package.name},
      'version_table_rows': devVersionRows,
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

  return renderLayoutPage(
    PageType.package,
    content,
    title: '${data.package.name} package - All Versions',
    canonicalUrl: urls.pkgPageUrl(data.package.name, includeHost: true),
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
    'icons': requestContext.isExperimental
        ? staticUrls.newVersionsTableIcons
        : staticUrls.versionsTableIcons,
  };
  return templateCache.renderTemplate('pkg/versions/version_row', versionData);
}

String _attr(String value) {
  if (value == null) return null;
  return htmlAttrEscape.convert(value);
}
