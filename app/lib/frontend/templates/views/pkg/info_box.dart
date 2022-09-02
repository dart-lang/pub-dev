// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pana/pana.dart';
import 'package:pub_dev/frontend/request_context.dart';
import 'package:pubspec_parse/pubspec_parse.dart' as pubspek;

import '../../../../package/models.dart';
import '../../../../package/overrides.dart' show redirectPackageUrls;
import '../../../../package/screenshots/backend.dart';
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
  final package = data.package!;
  final version = data.version!;
  d.Node? license;
  if (data.versionInfo?.hasLicense ?? false) {
    final licenses = data.scoreCard?.panaReport?.licenses ?? <License>[];
    if (licenses.isEmpty) {
      licenses.add(License(path: 'LICENSE', spdxIdentifier: 'unknown'));
    }
    license = _licenseNode(
      licenses: licenses,
      licenseUrl: urls.pkgLicenseUrl(
        data.package!.name!,
        version: data.isLatestStable ? null : data.version!.version,
      ),
    );
  }
  final dependencies = _dependencyListNode(version.pubspec?.dependencies);

  final screenshots = data.scoreCard?.panaReport?.screenshots;
  String? thumbnailUrl;
  final screenshotUrls = <String>[];
  if (screenshots != null && screenshots.isNotEmpty) {
    thumbnailUrl = imageStorage.getImageUrl(
        package.name!, version.version!, screenshots.first.pngThumbnail);
    for (ProcessedScreenshot s in screenshots) {
      screenshotUrls.add(imageStorage.getImageUrl(
          package.name!, version.version!, s.webpImage));
    }
  }
  return d.fragment([
    imageCarousel(),
    labeledScores,
    if (thumbnailUrl != null && requestContext.showScreenshots)
      d.div(
          classes: ['thumbnail-container'],
          child: screenshotThumbnailNode(thumbnailUrl, screenshotUrls)),
    if (package.replacedBy != null) _replacedBy(package.replacedBy!),
    _publisher(package.publisherId),
    _metadata(
      description: version.pubspec!.description,
      metaLinks: metaLinks,
    ),
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

d.Node _replacedBy(String replacedBy) {
  return _block(
    'Suggested replacement',
    d.a(
      href: urls.pkgPageUrl(replacedBy),
      title:
          'This package is discontinued, but author has suggested package:$replacedBy as a replacement',
      text: replacedBy,
    ),
  );
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
                classes: ['-pub-publisher-shield'],
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
}) {
  final paths = licenses.map((e) => e.path).toSet().toList();
  final labels = licenses.map((e) => e.spdxIdentifier).toSet().join(', ');
  return d.fragment([
    d.img(
      classes: ['inline-icon-img'],
      image: licenseIconImage(),
    ),
    d.text(labels),
    d.text(' ('),
    d.a(href: licenseUrl, text: paths.join(', ')),
    d.text(')'),
  ]);
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
