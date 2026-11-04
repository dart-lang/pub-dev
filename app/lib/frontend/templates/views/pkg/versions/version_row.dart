// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/package_api.dart';
import 'package:pana/models.dart' show ApiChange, ApiDiffSummary;
import 'package:pub_dev/task/models.dart';

import '../../../../../package/model_properties.dart';
import '../../../../../shared/urls.dart' as urls;
import '../../../../dom/dom.dart' as d;
import '../../../../static_files.dart';

/// Per-version changelog and public API diff details shown in the merged
/// Versions & Changelog tab.
final class VersionChangelogAndDiff {
  /// Sanitized HTML content of the changelog entry for this version, if found.
  final String? changelogHtml;

  /// Optional release label/note from the changelog heading (e.g. date or tag).
  final String? changelogLabel;

  /// The package version whose `CHANGELOG.md` provided [changelogHtml], when
  /// resolved via fallback from the version's own archive rather than latest.
  final String? fallbackSourceVersion;

  /// Public API diff against the previous version, if computed by `pana`.
  final ApiDiffSummary? apiDiff;

  const VersionChangelogAndDiff({
    this.changelogHtml,
    this.changelogLabel,
    this.fallbackSourceVersion,
    this.apiDiff,
  });

  bool get hasChangelog =>
      changelogHtml != null && changelogHtml!.trim().isNotEmpty;

  bool get hasContent => hasChangelog || apiDiff != null;
}

d.Node versionRowNode(
  String package,
  VersionInfo version,
  Pubspec pubspec, {
  PackageVersionStateInfo? versionStatus,
  VersionChangelogAndDiff? details,
  bool hasApiSummary = false,
  int compareOrder = 0,
  String? activeFromVersion,
  String? activeToVersion,
}) {
  final sdk = pubspec.minSdkVersion;
  final hasDetails = details != null && details.hasContent;
  final isCompareFrom = version.version == activeFromVersion;
  final isCompareTo = version.version == activeToVersion;
  final String compareButtonLabel;
  if (isCompareFrom && isCompareTo) {
    compareButtonLabel = 'Comparing';
  } else if (isCompareFrom) {
    compareButtonLabel = 'Base';
  } else if (isCompareTo) {
    compareButtonLabel = 'Target';
  } else {
    compareButtonLabel = '⇄';
  }
  final hasChangelog = details != null && details.hasChangelog;
  final changelogHtml = details?.changelogHtml;
  final isLongChangelog =
      changelogHtml != null &&
      ('<li'.allMatches(changelogHtml).length > 3 ||
          changelogHtml.replaceAll(RegExp(r'<[^>]+>'), '').trim().length > 260);

  return d.tr(
    id: 'v-${version.version}',
    classes: [
      'version-row',
      if (hasDetails) 'has-details',
      if (isCompareFrom || isCompareTo) '-compare-endpoint',
      if (isCompareFrom) '-compare-from',
      if (isCompareTo) '-compare-to',
    ],
    attributes: {'data-version': version.version},
    children: [
      d.td(
        classes: ['version'],
        child: d.div(
          classes: ['version-cell-inner'],
          children: [
            d.a(
              href: urls.pkgPageUrl(package, version: version.version),
              text: version.version,
              title: 'Visit $package ${version.version} page',
            ),
            if (hasApiSummary)
              d.element(
                'button',
                classes: [
                  'version-compare-btn',
                  if (isCompareFrom || isCompareTo) '-is-endpoint',
                ],
                attributes: {
                  'type': 'button',
                  'data-compare-version': version.version,
                  'data-compare-order': '$compareOrder',
                  'title':
                      'Click to select ${version.version}, then click another '
                      'version to compare public APIs',
                },
                text: compareButtonLabel,
              ),
          ],
        ),
      ),
      d.td(
        classes: ['badge', 'version-changes-cell'],
        child: hasDetails
            ? d.div(
                classes: ['version-changes-wrap'],
                children: [
                  if (details.apiDiff != null)
                    renderApiDiffWidget(package, details.apiDiff!),
                  if (hasChangelog)
                    d.div(
                      classes: [
                        'version-changelog-entry',
                        if (isLongChangelog) ...[
                          '-is-collapsible',
                          '-is-collapsed',
                        ],
                      ],
                      children: [
                        if (details.fallbackSourceVersion != null)
                          d.span(
                            classes: ['version-changelog-fallback-note'],
                            text:
                                'From ${details.fallbackSourceVersion} CHANGELOG.md',
                          ),
                        d.div(
                          classes: ['changelog-content', 'markdown-body'],
                          child: d.unsafeRawHtml(changelogHtml!),
                        ),
                        if (isLongChangelog)
                          d.element(
                            'button',
                            classes: ['changelog-expand-btn'],
                            attributes: const {'type': 'button'},
                            text: 'Show more ▾',
                          ),
                      ],
                    ),
                ],
              )
            : d.span(
                classes: ['version-no-changelog'],
                text: 'No changelog entry',
              ),
      ),
      d.td(
        classes: ['sdk'],
        child: sdk != null
            ? d.text(
                '${sdk.major}.${sdk.minor}${sdk.channel != null ? ' (${sdk.channel})' : ''}',
              )
            : null,
      ),
      d.td(classes: ['uploaded'], child: d.xAgoTimestamp(version.published!)),
      d.td(
        classes: ['documentation'],
        child: _documentationCell(package, version, versionStatus),
      ),
      d.td(
        classes: ['archive'],
        child: d.a(
          href: urls.pkgArchiveDownloadUrl(package, version.version),
          rel: 'nofollow',
          title: 'Download $package ${version.version} archive',
          child: d.img(
            classes: ['pub-monochrome-icon', 'filter-invert-on-dark'],
            image: d.Image(
              src: staticUrls.downloadIcon,
              alt: 'Download $package ${version.version} archive',
              width: 20,
              height: 20,
            ),
          ),
        ),
      ),
    ],
  );
}

d.Node renderApiDiffWidget(
  String package,
  ApiDiffSummary diff, {
  bool isOpen = false,
  String? customTitle,
}) {
  final breakingCount = diff.breakingChanges.length;
  final minorChanges = diff.nonBreakingChanges
      .where((c) => c.type == 'minor')
      .toList();
  final patchChanges = diff.nonBreakingChanges
      .where((c) => c.type != 'minor')
      .toList();
  final minorCount = minorChanges.length;
  final patchCount = patchChanges.length;
  final isEmpty = breakingCount == 0 && minorCount == 0 && patchCount == 0;

  final badges = <d.Node>[];
  if (isEmpty) {
    badges.add(
      d.span(
        classes: ['api-diff-badge', 'api-diff-badge-none'],
        text: 'No public API changes',
      ),
    );
  } else {
    if (breakingCount > 0) {
      badges.add(
        d.span(
          classes: ['api-diff-badge', 'api-diff-badge-breaking'],
          text: '$breakingCount breaking',
        ),
      );
    }
    if (minorCount > 0) {
      badges.add(
        d.span(
          classes: ['api-diff-badge', 'api-diff-badge-minor'],
          text: '$minorCount ${minorCount == 1 ? 'addition' : 'additions'}',
        ),
      );
    }
    if (patchCount > 0) {
      badges.add(
        d.span(
          classes: ['api-diff-badge', 'api-diff-badge-patch'],
          text: '$patchCount patch',
        ),
      );
    }
    if (!diff.isVersionIncrementSufficient) {
      badges.add(
        d.span(
          classes: ['api-diff-badge', 'api-diff-badge-warning'],
          text: 'expected >=${diff.minimumExpectedVersion}',
        ),
      );
    }
  }

  final bodyNodes = <d.Node>[];
  if (isEmpty) {
    bodyNodes.add(
      d.p(
        classes: ['api-diff-empty'],
        text:
            'No public API changes detected between '
            '${diff.previousVersion} and ${diff.currentVersion}.',
      ),
    );
  } else {
    if (diff.breakingChanges.isNotEmpty) {
      bodyNodes.add(
        _renderChangeGroup(
          'Potentially breaking changes (${diff.breakingChanges.length})',
          diff.breakingChanges,
          isBreaking: true,
        ),
      );
    }
    if (minorChanges.isNotEmpty) {
      bodyNodes.add(
        _renderChangeGroup(
          'Additions & minor changes (${minorChanges.length})',
          minorChanges,
          isBreaking: false,
        ),
      );
    }
    if (patchChanges.isNotEmpty) {
      bodyNodes.add(
        _renderChangeGroup(
          'Patch-level changes (${patchChanges.length})',
          patchChanges,
          isBreaking: false,
        ),
      );
    }
    if (diff.textDiff != null && diff.textDiff!.trim().isNotEmpty) {
      bodyNodes.add(
        d.div(
          classes: ['api-diff-signature-block'],
          children: [
            d.div(
              classes: ['api-diff-group-title'],
              text: 'Public API signature diff (api.txt)',
            ),
            d.codeSnippet(language: 'diff', text: diff.textDiff!.trimRight()),
          ],
        ),
      );
    }
  }

  return d.details(
    classes: [
      'version-api-diff',
      if (isOpen) 'version-api-diff-range',
      if (isEmpty && !isOpen) '-is-unchanged',
    ],
    attributes: {if (isOpen) 'open': 'open'},
    summary: [
      d.span(
        classes: ['version-api-diff-title'],
        text: customTitle ?? 'API diff vs ${diff.previousVersion}',
      ),
      d.span(classes: ['version-api-diff-badges'], children: badges),
    ],
    children: [
      d.div(classes: ['version-api-diff-body'], children: bodyNodes),
    ],
  );
}

d.Node _renderChangeGroup(
  String title,
  List<ApiChange> changes, {
  required bool isBreaking,
}) {
  final grouped = <String, List<ApiChange>>{};
  for (final change in changes) {
    final key = change.scope.isEmpty ? 'Package' : change.scope.join(' › ');
    (grouped[key] ??= []).add(change);
  }

  return d.div(
    classes: [
      'api-diff-group',
      isBreaking ? 'api-diff-group-breaking' : 'api-diff-group-nonbreaking',
    ],
    children: [
      d.div(classes: ['api-diff-group-title'], text: title),
      d.ul(
        classes: ['api-diff-scope-list'],
        children: [
          for (final entry in grouped.entries)
            d.li(
              children: [
                d.strong(text: entry.key),
                d.ul(
                  children: [
                    for (final c in entry.value)
                      d.li(
                        children: [
                          d.text('${c.description} '),
                          d.code(text: c.changeCode),
                        ],
                      ),
                  ],
                ),
              ],
            ),
        ],
      ),
    ],
  );
}

d.Node _documentationCell(
  String package,
  VersionInfo version,
  PackageVersionStateInfo? status,
) {
  if (status == null) {
    return d.text('');
  }
  final taskStatus = status.status;
  if (taskStatus == PackageVersionStatus.pending) {
    return d.text('pending');
  } else if (status.docs) {
    return d.a(
      href: urls.pkgDocUrl(package, version: version.version),
      rel: 'nofollow',
      title: 'Go to the documentation of $package ${version.version}',
      child: d.img(
        classes: ['pub-monochrome-icon', 'filter-invert-on-dark'],
        image: d.Image(
          src: staticUrls.documentationIcon,
          alt: 'Go to the documentation of $package ${version.version}',
          width: 24,
          height: 24,
        ),
      ),
    );
  } else {
    return d.a(
      href: urls.pkgScoreLogTxtUrl(package, version: version.version),
      rel: 'nofollow',
      title: 'Check the analysis logs for $package ${version.version}',
      child: d.img(
        classes: ['pub-monochrome-icon', 'filter-invert-on-dark'],
        image: d.Image(
          src: staticUrls.documentationFailedIcon,
          alt: 'Check the analysis logs for $package ${version.version}',
          width: 24,
          height: 24,
        ),
      ),
    );
  }
}
