// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/package_api.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:pana/models.dart' show ApiDiffSummary;
import 'package:pub_dev/frontend/static_files.dart';
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
  Map<String, VersionChangelogAndDiff> versionDetails = const {},
  String? changelogPreambleHtml,
  List<String> availableDiffVersions = const [],
  String? fromVersion,
  String? toVersion,
  ApiDiffSummary? rangeApiDiff,
  urls.PkgPageTab activeTab = urls.PkgPageTab.versions,
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
  final diffableVersionSet = availableDiffVersions.toSet();
  for (int i = 0; i < versions.length; i++) {
    final version = versions[i];
    final pubspec = Pubspec.fromJson(version.pubspec);
    final versionStatus = taskStatus.versions[version.version];
    final rowNode = versionRowNode(
      pubspec.name,
      version,
      pubspec,
      versionStatus: versionStatus,
      details: versionDetails[version.version],
      hasApiSummary: diffableVersionSet.contains(version.version),
      compareOrder: i,
      activeFromVersion: fromVersion,
      activeToVersion: toVersion,
    );
    final semanticVersion = Version.parse(version.version);
    if (version.retracted != null && version.retracted!) {
      retractedVersionRows.add(rowNode);
    } else if (semanticVersion.isPreRelease) {
      prereleaseVersionRows.add(rowNode);
    } else if (pubspec.isPreviewForCurrentSdk(
      dartSdkVersion: dartSdkVersion,
      flutterSdkVersion: flutterSdkVersion,
    )) {
      previewVersionRows.add(rowNode);
    } else {
      stableVersionRows.add(rowNode);
    }
  }

  final versionsPlural = versions.length > 1 ? 'versions' : 'version';

  final blocks = <d.Node>[
    d.p(
      classes: ['pub-monochrome-icon-hoverable'],
      children: [
        d.text('${versions.length} $versionsPlural'),
        d.a(
          href: urls.pkgFeedUrl(data.package.name!),
          title: 'Versions feed',
          child: d.img(
            classes: [
              'pub-monochrome-icon',
              'filter-invert-on-dark',
              'versions-rss-image',
            ],
            image: d.Image(
              src: staticUrls.getAssetUrl(
                '/static/img/rss-feed-icon-4a4a4a.svg',
              ),
              alt: 'Versions feed',
              width: 15,
              height: 15,
            ),
          ),
        ),
      ],
    ),
  ];
  if (changelogPreambleHtml != null &&
      changelogPreambleHtml.trim().isNotEmpty) {
    blocks.add(
      d.div(
        classes: ['versions-changelog-preamble', 'markdown-body'],
        child: d.unsafeRawHtml(changelogPreambleHtml),
      ),
    );
  }
  if (availableDiffVersions.length >= 2) {
    final defaultTo = toVersion ?? availableDiffVersions.first;
    final defaultFrom =
        fromVersion ??
        availableDiffVersions.firstWhere(
          (v) => v != defaultTo,
          orElse: () => availableDiffVersions.last,
        );
    final actionUrl = activeTab == urls.PkgPageTab.changelog
        ? urls.pkgChangelogUrl(data.package.name!)
        : urls.pkgVersionsUrl(data.package.name!);
    blocks.add(
      d.div(
        id: 'range-diff',
        classes: [
          'version-range-diff-box',
          if (rangeApiDiff != null) '-has-result',
        ],
        attributes: {'data-action-url': actionUrl},
        children: [
          d.div(
            classes: ['version-range-diff-header'],
            children: [
              d.span(
                classes: ['version-range-diff-hint'],
                text: rangeApiDiff != null
                    ? 'Comparing public API: ${rangeApiDiff.previousVersion} → ${rangeApiDiff.currentVersion} (click ⇄ on any version to start a new comparison)'
                    : '⇄ Click ⇄ next to any two versions to diff their public APIs.',
              ),
              d.div(
                classes: ['version-range-diff-controls'],
                children: [
                  d.element(
                    'button',
                    classes: ['version-toggle-changelogs-btn'],
                    attributes: const {
                      'type': 'button',
                      'title': 'Show or hide inline changelog notes',
                    },
                    text: 'Hide changelogs',
                  ),
                  d.element(
                    'form',
                    classes: ['version-range-diff-form'],
                    attributes: {'method': 'get', 'action': actionUrl},
                    children: [
                      d.element(
                        'label',
                        classes: ['version-range-diff-field'],
                        children: [
                          d.text('From '),
                          d.element(
                            'select',
                            attributes: const {'name': 'from'},
                            children: [
                              for (final v in availableDiffVersions)
                                d.element(
                                  'option',
                                  attributes: {
                                    'value': v,
                                    if (v == defaultFrom)
                                      'selected': 'selected',
                                  },
                                  text: v,
                                ),
                            ],
                          ),
                        ],
                      ),
                      d.span(classes: ['version-range-diff-arrow'], text: '→'),
                      d.element(
                        'label',
                        classes: ['version-range-diff-field'],
                        children: [
                          d.text('To '),
                          d.element(
                            'select',
                            attributes: const {'name': 'to'},
                            children: [
                              for (final v in availableDiffVersions)
                                d.element(
                                  'option',
                                  attributes: {
                                    'value': v,
                                    if (v == defaultTo) 'selected': 'selected',
                                  },
                                  text: v,
                                ),
                            ],
                          ),
                        ],
                      ),
                      d.element(
                        'button',
                        classes: ['version-range-diff-submit'],
                        attributes: const {'type': 'submit'},
                        text: 'Compare',
                      ),
                      if (fromVersion != null && toVersion != null)
                        d.a(
                          classes: ['version-range-diff-swap'],
                          href: '$actionUrl?from=$toVersion&to=$fromVersion',
                          title: 'Swap base and target versions',
                          text: '⇄ Swap',
                        ),
                      if (fromVersion != null || toVersion != null)
                        d.a(
                          classes: ['version-range-diff-reset'],
                          href: actionUrl,
                          text: '✕ Clear',
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          if (rangeApiDiff != null)
            d.div(
              classes: ['version-range-diff-result'],
              child: renderApiDiffWidget(
                data.package.name!,
                rangeApiDiff,
                isOpen: true,
                customTitle:
                    'Cumulative API diff: '
                    '${rangeApiDiff.previousVersion} → ${rangeApiDiff.currentVersion}',
              ),
            ),
        ],
      ),
    );
  }
  if (stableVersionRows.isNotEmpty &&
      prereleaseVersionRows.isNotEmpty &&
      latestPrereleaseVersion != null) {
    blocks.add(
      d.p(
        children: [
          d.text('The latest prerelease was '),
          d.a(href: '#prerelease', text: latestPrereleaseVersion.version),
          d.text(' '),
          d.xAgoTimestamp(latestPrereleaseVersion.published!, datePrefix: 'on'),
          d.text('.'),
        ],
      ),
    );
  }
  if (previewVersionRows.isNotEmpty) {
    blocks.add(
      versionSectionNode(
        id: 'preview',
        label: 'Preview',
        packageName: data.package.name!,
        rows: previewVersionRows,
      ),
    );
  }
  if (stableVersionRows.isNotEmpty) {
    blocks.add(
      versionSectionNode(
        id: 'stable',
        label: 'Stable',
        packageName: data.package.name!,
        rows: stableVersionRows,
      ),
    );
  }
  if (prereleaseVersionRows.isNotEmpty) {
    blocks.add(
      versionSectionNode(
        id: 'prerelease',
        label: 'Prerelease',
        packageName: data.package.name!,
        rows: prereleaseVersionRows,
      ),
    );
  }
  if (retractedVersionRows.isNotEmpty) {
    blocks.add(
      versionSectionNode(
        id: 'retracted',
        label: 'Retracted',
        packageName: data.package.name!,
        rows: retractedVersionRows,
      ),
    );
  }

  final tabs = buildPackageTabs(
    data: data,
    tab: activeTab,
    content: Tab.withContent(
      id: activeTab == urls.PkgPageTab.changelog ? 'changelog' : 'versions',
      title: data.hasChangelog ? 'Versions / Changelog' : 'Versions',
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

  final canonicalUrl = urls.pkgPageUrl(
    data.package.name!,
    includeHost: true,
    pkgPageTab: urls.PkgPageTab.versions,
  );
  return renderLayoutPage(
    PageType.package,
    content,
    title: '${data.package.name} package - All Versions',
    canonicalUrl: canonicalUrl,
    pageData: pkgPageData(data.package, data.version),
    noIndex: data.package.isDiscontinued,
  );
}
