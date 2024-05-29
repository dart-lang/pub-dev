// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/package_api.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:pub_semver/pub_semver.dart';

import '../../package/model_properties.dart';
import '../../package/models.dart';
import '../../shared/urls.dart' as urls;
import '../../task/models.dart';
import '../dom/dom.dart' as d;

import 'detail_page.dart';
import 'layout.dart';
import 'package.dart';
import 'views/pkg/versions/index.dart';
import 'views/pkg/versions/version_row.dart';

/// Renders the `views/pkg/versions/index` template.
String renderPkgVersionsPage(
  PackagePageData data,
  List<VersionInfo> versions, {
  required Version dartSdkVersion,
  required Version flutterSdkVersion,
  required PackageStateInfo taskStatus,
}) {
  final previewVersionRows = <d.Node>[];
  final stableVersionRows = <d.Node>[];
  final prereleaseVersionRows = <d.Node>[];
  final retractedVersionRows = <d.Node>[];
  final latestPrereleaseVersion = data.latestReleases.showPrerelease
      ? versions.firstWhereOrNull(
          (v) => v.version == data.latestReleases.prerelease!.version,
        )
      : null;
  for (int i = 0; i < versions.length; i++) {
    final version = versions[i];
    final pubspec = Pubspec.fromJson(version.pubspec);
    final versionStatus = taskStatus.versions[version.version];
    final rowNode = versionRowNode(
      pubspec.name,
      version,
      pubspec,
      versionStatus: versionStatus,
    );
    final semanticVersion = Version.parse(version.version);
    if (version.retracted != null && version.retracted!) {
      retractedVersionRows.add(rowNode);
    } else if (semanticVersion.isPreRelease) {
      prereleaseVersionRows.add(rowNode);
    } else if (pubspec.isPreviewForCurrentSdk(
        dartSdkVersion: dartSdkVersion, flutterSdkVersion: flutterSdkVersion)) {
      previewVersionRows.add(rowNode);
    } else {
      stableVersionRows.add(rowNode);
    }
  }

  final blocks = <d.Node>[];
  if (stableVersionRows.isNotEmpty &&
      prereleaseVersionRows.isNotEmpty &&
      data.latestReleases.showPrerelease) {
    blocks.add(d.p(
      children: [
        d.text('The latest prerelease was '),
        d.a(href: '#prerelease', text: latestPrereleaseVersion!.version),
        d.text(' '),
        d.xAgoTimestamp(latestPrereleaseVersion.published!, datePrefix: 'on'),
        d.text('.'),
      ],
    ));
  }
  if (previewVersionRows.isNotEmpty) {
    blocks.add(versionSectionNode(
      id: 'preview',
      label: 'Preview',
      packageName: data.package.name!,
      rows: previewVersionRows,
    ));
  }
  if (stableVersionRows.isNotEmpty) {
    blocks.add(versionSectionNode(
      id: 'stable',
      label: 'Stable',
      packageName: data.package.name!,
      rows: stableVersionRows,
    ));
  }
  if (prereleaseVersionRows.isNotEmpty) {
    blocks.add(versionSectionNode(
      id: 'prerelease',
      label: 'Prerelease',
      packageName: data.package.name!,
      rows: prereleaseVersionRows,
    ));
  }
  if (retractedVersionRows.isNotEmpty) {
    blocks.add(versionSectionNode(
      id: 'retracted',
      label: 'Retracted',
      packageName: data.package.name!,
      rows: retractedVersionRows,
    ));
  }

  final tabs = buildPackageTabs(
    data: data,
    versionsTab: Tab.withContent(
      id: 'versions',
      title: 'Versions',
      contentNode: d.fragment(blocks),
    ),
  );

  final content = renderDetailPage(
    headerNode: renderPkgHeader(data),
    tabs: tabs,
    infoBoxLead: data.version.ellipsizedDescription,
    infoBoxNode: renderPkgInfoBox(data),
    footerNode: renderPackageSchemaOrgHtml(data),
  );

  final canonicalUrl = urls.pkgPageUrl(data.package.name!,
      includeHost: true, pkgPageTab: urls.PkgPageTab.versions);
  return renderLayoutPage(
    PageType.package,
    content,
    title: '${data.package.name} package - All Versions',
    canonicalUrl: canonicalUrl,
    pageData: pkgPageData(data.package, data.version),
    noIndex: data.package.isDiscontinued,
  );
}
