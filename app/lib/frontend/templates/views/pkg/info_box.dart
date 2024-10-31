// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/format/encoding.dart';
import 'package:pana/pana.dart';
import 'package:pub_dev/service/download_counts/download_counts.dart';
import 'package:pubspec_parse/pubspec_parse.dart' as pubspek;

import '../../../../package/models.dart';
import '../../../../package/overrides.dart' show redirectPackageUrls;
import '../../../../package/screenshots/backend.dart';
import '../../../../service/topics/models.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../shared/images.dart';
import 'screenshots.dart';

/// Links inside the package info box.
class InfoBoxLink {
  final String href;
  final String label;
  final String? rel;

  /// One of [UrlProblemCodes].
  final String? problemCode;

  InfoBoxLink(this.href, this.label, {this.rel, this.problemCode});
}

/// Renders the package info box.
d.Node packageInfoBoxNode({
  required PackagePageData data,
  required List<InfoBoxLink> metaLinks,
  required List<InfoBoxLink> docLinks,
  required List<InfoBoxLink> fundingLinks,
  required d.Node labeledScores,
}) {
  final package = data.package;
  final version = data.version;
  d.Node? license;
  if (data.versionInfo.hasLicense) {
    final licenses = data.scoreCard.panaReport?.licenses ?? <License>[];
    if (licenses.isEmpty) {
      licenses.add(License(path: 'LICENSE', spdxIdentifier: 'unknown'));
    }
    license = _licenseNode(
      licenses: licenses,
      licenseUrl: urls.pkgLicenseUrl(
        data.package.name!,
        version: data.isLatestStable ? null : data.version.version,
      ),
      isPending: data.toPackageView().isPending,
    );
  }
  final dependencies = _dependencyListNode(version.pubspec?.dependencies);
  final topics = _topicstNode(version.pubspec?.canonicalizedTopics);

  final screenshots = data.scoreCard.panaReport?.screenshots;
  String? thumbnailUrl;
  final screenshotUrls = <String>[];
  final screenshotDescriptions = <String>[];
  if (screenshots != null && screenshots.isNotEmpty) {
    thumbnailUrl = imageStorage.getImageUrl(
        package.name!, version.version!, screenshots.first.webp190Thumbnail);
    for (final screenshot in screenshots) {
      screenshotUrls.add(imageStorage.getImageUrl(
          package.name!, version.version!, screenshot.webpImage));
      screenshotDescriptions.add(screenshot.description);
    }
  }
  return d.fragment([
    labeledScores,
    if (data.weeklyDownloadCounts != null)
      _downloadsChart(data.weeklyDownloadCounts!),
    if (thumbnailUrl != null)
      d.div(classes: [
        'detail-screenshot-thumbnail'
      ], children: [
        screenshotThumbnailNode(
            thumbnailUrl: thumbnailUrl,
            screenshotUrls: screenshotUrls,
            screenshotDescriptions: screenshotDescriptions),
        collectionsIcon(),
      ]),
    _publisher(package.publisherId),
    _metadata(
      description: version.pubspec!.description,
      metaLinks: metaLinks,
    ),
    if (topics != null) _block('Topics', topics),
    if (docLinks.isNotEmpty)
      _block('Documentation', d.fragment(docLinks.map(_linkAndBr))),
    if (fundingLinks.isNotEmpty)
      _block(
        'Funding',
        d.fragment(
          [
            d.text('Consider supporting this project:'),
            d.br(),
            d.br(),
            ...fundingLinks.map(_linkAndBr),
          ],
        ),
      ),
    if (license != null) _block('License', license),
    if (dependencies != null) _block('Dependencies', dependencies),
    _more(package.name!),
  ]);
}

d.Node _downloadsChart(WeeklyDownloadCounts wdc) {
  final container = d.div(
      classes: ['weekly-downloads-sparkline'],
      id: '-weekly-downloads-sparkline',
      attributes: {
        'data-widget': 'weekly-sparkline',
        'data-weekly-sparkline-points':
            _encodeForWeeklySparkline(wdc.weeklyDownloads, wdc.newestDate),
      });
  return container;
}

String _encodeForWeeklySparkline(List<int> downloads, DateTime newestDate) {
  final date = newestDate.toUtc().millisecondsSinceEpoch ~/ 1000;
  return encodeIntsAsLittleEndianBase64String([date, ...downloads]);
}

d.Node _publisher(String? publisherId) {
  return _block(
    'Publisher',
    publisherId == null
        ? d.span(text: 'unverified uploader')
        : d.a(
            href: urls.publisherUrl(publisherId),
            children: [
              d.img(
                classes: ['-pub-publisher-shield', 'filter-invert-on-dark'],
                title: 'Published by a pub.dev verified publisher',
                image: verifiedPublisherIconImage(),
              ),
              d.text(publisherId),
            ],
          ),
  );
}

d.Node _metadata({
  required String? description,
  required List<InfoBoxLink> metaLinks,
}) {
  return d.fragment([
    d.h3(classes: ['title', 'pkg-infobox-metadata'], text: 'Metadata'),
    if (description != null) d.p(text: description),
    d.p(children: metaLinks.map(_linkAndBr)),
  ]);
}

d.Node _more(String packageName) {
  return _block(
    'More',
    d.a(
      href: urls.searchUrl(q: 'dependency:$packageName'),
      rel: 'nofollow',
      text: 'Packages that depend on $packageName',
    ),
  );
}

d.Node _block(String title, d.Node? content) {
  return d.fragment([
    d.h3(classes: ['title'], text: title),
    d.p(child: content),
  ]);
}

d.Node _linkAndBr(InfoBoxLink link) {
  return d.fragment([
    d.a(classes: ['link'], href: link.href, text: link.label, rel: link.rel),
    if (link.problemCode != null) d.text(' (${link.problemCode})'),
    d.br(),
  ]);
}

d.Node? _licenseNode({
  required List<License> licenses,
  required String licenseUrl,
  required bool isPending,
}) {
  final labels = isPending
      ? '(pending)'
      : licenses.map((e) => e.spdxIdentifier).toSet().join(', ');
  return d.fragment([
    d.img(
      classes: ['inline-icon-img', 'filter-invert-on-dark'],
      image: licenseIconImage(),
    ),
    d.text(labels),
    d.text(' ('),
    d.a(href: licenseUrl, text: 'license'),
    d.text(')'),
  ]);
}

d.Node? _topicstNode(List<String>? topics) {
  if (topics == null || topics.isEmpty) return null;

  final nodes = <d.Node>[];
  for (final topic in topics) {
    if (nodes.isNotEmpty) {
      nodes.add(d.text(' '));
    }
    final ct = canonicalTopics.asMap[topic];
    final description = ct?.description;
    final node = d.a(
      href: urls.searchUrl(q: 'topic:$topic'),
      text: '#$topic',
      title: description,
      rel: 'nofollow',
    );
    nodes.add(node);
  }
  return d.fragment(nodes);
}

d.Node? _dependencyListNode(Map<String, pubspek.Dependency>? dependencies) {
  if (dependencies == null) return null;
  final packages = dependencies.keys.toList()..sort();
  if (packages.isEmpty) return null;
  final nodes = <d.Node>[];
  for (final p in packages) {
    if (nodes.isNotEmpty) {
      nodes.add(d.text(', '));
    }
    final dep = dependencies[p];
    var href = redirectPackageUrls[p];
    String? constraint;
    if (href == null && dep is pubspek.HostedDependency) {
      href = urls.pkgPageUrl(p);
      constraint = dep.version.toString();
    }
    final node =
        href == null ? d.text(p) : d.a(href: href, title: constraint, text: p);
    nodes.add(node);
  }
  return d.fragment(nodes);
}
