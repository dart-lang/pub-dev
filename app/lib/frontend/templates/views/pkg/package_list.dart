// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/x_ago_format.dart';
import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:clock/clock.dart';

import '../../../../package/models.dart';
import '../../../../package/screenshots/backend.dart';
import '../../../../search/search_service.dart';
import '../../../../service/topics/models.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;

import '../../../static_files.dart' show staticUrls;
import '../../_consts.dart';
import '../../package_misc.dart';
import '../shared/images.dart';
import 'license.dart';
import 'screenshots.dart';
import 'title_content.dart';

/// Renders the listing page (list of packages).
d.Node listOfPackagesNode({
  required SearchForm? searchForm,
  required List<SdkLibraryHit> sdkLibraryHits,
  required List<PackageView> packageHits,
}) {
  return d.div(
    classes: ['packages'],
    children: [
      ...sdkLibraryHits.map(_sdkLibraryItem),
      ...packageHits.map((hit) => _packageItem(hit, searchForm: searchForm)),
      imageCarousel(),
    ],
  );
}

d.Node _sdkLibraryItem(SdkLibraryHit hit) {
  final sdkDict = getSdkDict(hit.sdk!);
  final metadataText = [
    if (hit.version != null) 'v ${hit.version}',
    sdkDict.libraryTypeLabel,
  ].join(' • ');

  return _item(
    url: hit.url!,
    name: hit.library!,
    newTimestamp: null,
    labeledScoresNode: null,
    description: hit.description ?? '',
    metadataNode: d.fragment([
      d.span(classes: ['packages-metadata-block'], text: metadataText),
      coreLibraryBadgeNode,
      nullSafeBadgeNode(),
    ]),
    tagsNode: null,
    replacedBy: null,
    apiPages: hit.apiPages
        ?.where((page) => page.url != null)
        .map((page) => _ApiPageUrl(
              page.url!,
              page.title ?? page.path ?? page.url!,
            ))
        .toList(),
  );
}

d.Node _packageItem(
  PackageView view, {
  required SearchForm? searchForm,
}) {
  final isFlutterFavorite = view.tags.contains(PackageTags.isFlutterFavorite);
  final isNullSafe = view.tags.contains(PackageVersionTags.isNullSafe);
  final isDart3Compatible =
      view.tags.contains(PackageVersionTags.isDart3Compatible);
  final isDart3Incompatible =
      view.tags.contains(PackageVersionTags.isDart3Incompatible);

  Iterable<d.Node> versionAndTimestamp(
    Release release, {
    bool isLatest = false,
  }) {
    return [
      d.a(
        href: urls.pkgPageUrl(
          view.name,
          version: isLatest ? null : release.version,
        ),
        text: release.version,
        title: 'Visit ${view.name} ${release.version} page',
      ),
      d.text(' ('),
      d.xAgoTimestamp(release.published),
      d.text(')'),
    ];
  }

  final licenseNode = packageListMetadataLicense(view.spdxIdentifiers);
  final releases = view.releases;
  final metadataNode = d.fragment([
    d.span(
      classes: ['packages-metadata-block'],
      children: [
        d.text('v '),
        ...versionAndTimestamp(releases.stable, isLatest: true),
        if (releases.showPreview) ...[
          d.text(' / '),
          ...versionAndTimestamp(releases.preview!),
        ],
        if (releases.showPrerelease) ...[
          d.text(' / '),
          ...versionAndTimestamp(releases.prerelease!),
        ],
      ],
    ),
    if (view.publisherId != null)
      d.span(classes: [
        'packages-metadata-block'
      ], children: [
        d.img(
          classes: ['package-vp-icon', 'filter-invert-on-dark'],
          image: verifiedPublisherIconImage(),
          title: 'Published by a pub.dev verified publisher',
        ),
        d.a(href: urls.publisherUrl(view.publisherId!), text: view.publisherId),
      ]),
    if (licenseNode != null)
      d.span(
        classes: ['packages-metadata-block'],
        child: licenseNode,
      ),
    if (isFlutterFavorite) flutterFavoriteBadgeNode,
    if (isNullSafe && !isDart3Compatible) nullSafeBadgeNode(),
    if (isDart3Compatible) dart3CompatibleNode,
    if (isDart3Incompatible) dart3IncompatibleNode,
  ]);

  final screenshots = view.screenshots;
  final bool hasScreenshots = screenshots != null && screenshots.isNotEmpty;
  String? thumbnailUrl;
  final screenshotUrls = <String>[];
  final screenshotDescriptions = <String>[];
  if (hasScreenshots) {
    thumbnailUrl = imageStorage.getImageUrl(
        view.name, releases.stable.version, screenshots.first.webp100Thumbnail);

    for (final screenshot in screenshots) {
      screenshotUrls.add(imageStorage.getImageUrl(
          view.name, releases.stable.version, screenshot.webpImage));
      screenshotDescriptions.add(screenshot.description);
    }
  }

  List<d.Node> _topicsNode(List<String>? topics) {
    if (topics == null || topics.isEmpty) return [];
    return topics.map(
      (topic) {
        final ct = canonicalTopics.asMap[topic];
        final description = ct?.description;
        return d.a(
          classes: ['topics-tag'],
          href: urls.searchUrl(q: 'topic:$topic'),
          text: '#$topic',
          title: description,
          rel: 'nofollow',
        );
      },
    ).toList();
  }

  return _item(
    thumbnailUrl: thumbnailUrl,
    screenshotUrls: screenshotUrls,
    screenshotDescriptions: screenshotDescriptions,
    url: urls.pkgPageUrl(view.name),
    name: view.name,
    newTimestamp: view.created,
    labeledScoresNode: labeledScoresNodeFromPackageView(view),
    description: view.ellipsizedDescription ?? '',
    metadataNode: metadataNode,
    copyIcon:
        copyIcon(package: view.name, version: view.releases.stable.version),
    tagsNode: tagsNodeFromPackageView(searchForm: searchForm, package: view),
    replacedBy: view.replacedBy,
    apiPages: view.apiPages
        ?.map((page) => _ApiPageUrl(
              page.url ??
                  urls.pkgDocUrl(
                    view.name,
                    isLatest: true,
                    relativePath: page.path,
                  ),
              page.title ?? page.path!,
            ))
        .toList(),
    topics: _topicsNode(view.topics),
  );
}

d.Node _item({
  String? thumbnailUrl,
  List<String>? screenshotUrls,
  List<String>? screenshotDescriptions,
  List<d.Node> topics = const [],
  required String url,
  required String name,
  required DateTime? newTimestamp,
  required d.Node? labeledScoresNode,
  required String description,
  required d.Node metadataNode,
  required d.Node? tagsNode,
  d.Node? copyIcon,
  required String? replacedBy,
  required List<_ApiPageUrl>? apiPages,
}) {
  final age =
      newTimestamp == null ? null : clock.now().difference(newTimestamp);
  return d.div(
    classes: ['packages-item'],
    children: [
      d.div(
        classes: ['packages-header'],
        children: [
          d.h3(classes: [
            'packages-title'
          ], children: [
            d.a(href: url, text: name),
            if (copyIcon != null) copyIcon,
          ]),
          if (age != null && age.inDays <= 30)
            d.div(
              classes: ['packages-recent'],
              children: [
                d.img(
                  classes: ['packages-recent-icon'],
                  image: d.Image(
                    src:
                        staticUrls.getAssetUrl('/static/img/schedule-icon.svg'),
                    alt: 'recently created package',
                    width: 10,
                    height: 10,
                  ),
                  title: 'recently created package',
                ),
                d.text(' Added '),
                d.b(text: formatXAgo(age)),
              ],
            ),
          if (labeledScoresNode != null) labeledScoresNode,
        ],
      ), // end of packages-header
      d.div(classes: [
        'packages-container'
      ], children: [
        d.div(
          classes: ['packages-body'],
          children: [
            d.div(
              classes: ['packages-description'],
              children: [
                d.span(text: description),
                ...topics,
              ],
            ),
            d.p(classes: ['packages-metadata'], child: metadataNode),
            if (tagsNode != null) d.div(child: tagsNode),
            if (apiPages != null && apiPages.isNotEmpty)
              d.div(classes: ['packages-api'], child: _apiPages(apiPages)),
          ],
        ),
        if (thumbnailUrl != null)
          d.div(classes: [
            'packages-screenshot-thumbnail'
          ], children: [
            screenshotThumbnailNode(
                thumbnailUrl: thumbnailUrl,
                screenshotUrls: screenshotUrls!,
                screenshotDescriptions: screenshotDescriptions!),
            collectionsIcon()
          ])
      ]),
    ],
  );
}

class _ApiPageUrl {
  final String href;
  final String label;

  _ApiPageUrl(this.href, this.label);
}

d.Node _apiPages(List<_ApiPageUrl> apiPages) {
  if (apiPages.length == 1) {
    return d.fragment([
      d.div(classes: ['packages-api-label'], text: 'API result:'),
      d.div(
        classes: ['packages-api-links'],
        child: d.a(
          href: apiPages.single.href,
          text: apiPages.single.label,
        ),
      ),
    ]);
  } else {
    return d.fragment([
      d.div(classes: ['packages-api-label'], text: 'API results:'),
      d.details(
        classes: ['packages-api-details', 'packages-api-links'],
        summary: [d.a(href: apiPages.first.href, text: apiPages.first.label)],
        children: apiPages.skip(1).map(
              (e) => d.div(
                classes: ['-rest'],
                child: d.a(href: e.href, text: e.label),
              ),
            ),
      ),
    ]);
  }
}
