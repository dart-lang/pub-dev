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
  required bool isDart3Ready,
  required LatestReleases? releases,
}) {
  return d.fragment([
    d.text('Published '),
    d.span(child: d.xAgoTimestamp(published)),
    d.text(' '),
    if (publisherId != null) ..._publisher(publisherId),
    if (isNullSafe && !isDart3Ready) nullSafeBadgeNode(),
    if (isDart3Ready) dart3ReadyNode,
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
          classes: ['-pub-publisher-shield'],
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
      ),
    ),
    if (releases.showPreview)
      ..._versionLink(
        package: package,
        version: releases.preview!.version,
        label: 'Preview',
        title: 'Preview is a stable version that depends on a prerelease SDK.',
      ),
    if (releases.showPrerelease)
      ..._versionLink(
        package: package,
        version: releases.prerelease!.version,
        label: 'Prerelease',
      ),
  ];
}

List<d.Node> _versionLink({
  required String package,
  required String version,
  required String label,
  String? title,
}) {
  return [
    d.text(' / '),
    d.span(
      attributes: title != null ? {'title': title} : null,
      children: [
        d.text('$label: '),
        d.a(href: urls.pkgPageUrl(package, version: version), text: version),
      ],
    ),
  ];
}
