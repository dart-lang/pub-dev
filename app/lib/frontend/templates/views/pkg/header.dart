// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../package/models.dart';
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../package_misc.dart';
import '../shared/images.dart';

d.Node packageHeaderNode({
  required String packageName,
  required String? publisherId,
  required DateTime published,
  required bool isNullSafe,
  required bool isDart3Compatible,
  required bool isDart3Incompatible,
  required LatestReleases? releases,
}) {
  return d.fragment([
    d.text('Published '),
    d.span(child: d.xAgoTimestamp(published)),
    d.text(' '),
    if (publisherId != null) ..._publisher(publisherId),
    if (isNullSafe && !isDart3Compatible) nullSafeBadgeNode(),
    if (isDart3Compatible) dart3CompatibleNode,
    if (isDart3Incompatible) dart3IncompatibleNode,
    if (releases != null) ..._releases(packageName, releases),
  ]);
}

Iterable<d.Node> _publisher(String publisherId) {
  return [
    d.text('• '),
    d.a(
      classes: ['-pub-publisher'],
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
  ];
}

List<d.Node> _releases(String package, LatestReleases releases) {
  return [
    d.text('• Latest: '),
    d.span(
      child: d.a(
        href: urls.pkgPageUrl(package),
        text: releases.stable.version,
        title: 'View the latest version of $package',
      ),
    ),
    if (releases.showPreview)
      ..._versionLink(
        package: package,
        version: releases.preview!.version,
        label: 'Preview',
        spanTitle:
            'Preview is a stable version that depends on a prerelease SDK.',
        linkTitle: 'Visit $package ${releases.preview!.version} page',
      ),
    if (releases.showPrerelease)
      ..._versionLink(
        package: package,
        version: releases.prerelease!.version,
        label: 'Prerelease',
        linkTitle: 'Visit $package ${releases.prerelease!.version} page',
      ),
  ];
}

List<d.Node> _versionLink({
  required String package,
  required String version,
  required String label,
  String? spanTitle,
  required String linkTitle,
}) {
  return [
    d.text(' / '),
    d.span(
      attributes: spanTitle != null ? {'title': spanTitle} : null,
      children: [
        d.text('$label: '),
        d.a(
          href: urls.pkgPageUrl(package, version: version),
          text: version,
          title: linkTitle,
        ),
      ],
    ),
  ];
}
