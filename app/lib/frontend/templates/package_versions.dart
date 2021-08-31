// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart' show IterableExtension;
import 'package:pub_semver/pub_semver.dart';

import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import 'detail_page.dart';
import 'layout.dart';
import 'package.dart';
import 'views/pkg/versions/version_row.dart';

/// Renders the `views/pkg/versions/index` template.
String renderPkgVersionsPage(
  PackagePageData data,
  List<PackageVersion> versions,
  List<Uri> versionDownloadUrls, {
  required Version dartSdkVersion,
}) {
  assert(versions.length == versionDownloadUrls.length);

  final previewVersionRows = <String>[];
  final stableVersionRows = <String>[];
  final prereleaseVersionRows = <String>[];
  final latestPrereleaseVersion = data.latestReleases!.showPrerelease
      ? versions.firstWhereOrNull(
          (v) => v.version == data.latestReleases!.prerelease!.version,
        )
      : null;
  for (int i = 0; i < versions.length; i++) {
    final version = versions[i];
    final url = versionDownloadUrls[i].toString();
    final rowHtml = renderVersionTableRow(version, url);
    if (version.semanticVersion.isPreRelease) {
      prereleaseVersionRows.add(rowHtml);
    } else if (version.pubspec!.isPreviewForCurrentSdk(dartSdkVersion)) {
      previewVersionRows.add(rowHtml);
    } else {
      stableVersionRows.add(rowHtml);
    }
  }

  final htmlBlocks = <String>[];
  if (stableVersionRows.isNotEmpty &&
      prereleaseVersionRows.isNotEmpty &&
      data.latestReleases!.showPrerelease) {
    htmlBlocks.add(
        '<p>The latest prerelease was <a href="#prerelease">${latestPrereleaseVersion!.version}</a> '
        'on ${latestPrereleaseVersion.shortCreated}.</p>');
  }
  if (previewVersionRows.isNotEmpty) {
    htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
      'id': 'preview',
      'kind': 'Preview',
      'package': {'name': data.package!.name},
      'version_table_rows': previewVersionRows,
    }));
  }
  if (stableVersionRows.isNotEmpty) {
    htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
      'id': 'stable',
      'kind': 'Stable',
      'package': {'name': data.package!.name},
      'version_table_rows': stableVersionRows,
    }));
  }
  if (prereleaseVersionRows.isNotEmpty) {
    htmlBlocks.add(templateCache.renderTemplate('pkg/versions/index', {
      'id': 'prerelease',
      'kind': 'Prerelease',
      'package': {'name': data.package!.name},
      'version_table_rows': prereleaseVersionRows,
    }));
  }

  final tabs = buildPackageTabs(
    data: data,
    versionsTab: Tab.withContent(
      id: 'versions',
      title: 'Versions',
      contentHtml: htmlBlocks.join(),
    ),
  );

  final content = renderDetailPage(
    headerHtml: renderPkgHeader(data),
    tabs: tabs,
    infoBoxLead: data.version!.ellipsizedDescription,
    infoBoxHtml: renderPkgInfoBox(data),
    footerHtml: renderPackageSchemaOrgHtml(data),
  );

  final canonicalUrl = urls.pkgPageUrl(data.package!.name!,
      includeHost: true, pkgPageTab: urls.PkgPageTab.versions);
  return renderLayoutPage(
    PageType.package,
    content,
    title: '${data.package!.name} package - All Versions',
    canonicalUrl: canonicalUrl,
    pageData: pkgPageData(data.package!, data.version!),
    noIndex: data.package!.isDiscontinued,
  );
}

String renderVersionTableRow(PackageVersion version, String downloadUrl) {
  return versionRowNode(
    version: version,
    downloadUrl: downloadUrl,
  ).toString();
}
