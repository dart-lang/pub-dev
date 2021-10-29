// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../../../publisher/models.dart' show Publisher;
import '../../../../shared/urls.dart' as urls;
import '../../../dom/dom.dart' as d;
import '../../../static_files.dart' show staticUrls;

/// Creates the content that goes into the publisher page's detail header.
d.Node publisherHeaderMetadataNode(Publisher publisher) {
  final websiteUri = urls.parseValidUrl(publisher.websiteUrl);
  final websiteRel = (websiteUri?.shouldIndicateUgc ?? false) ? 'ugc' : null;
  final websiteDisplayable = urls.displayableUrl(publisher.websiteUrl);

  return d.fragment([
    if (publisher.hasDescription)
      d.p(child: d.markdown(publisher.shortDescription)),
    d.p(children: [
      if (websiteUri != null)
        _ref(
          href: websiteUri.toString(),
          rel: websiteRel,
          label: websiteDisplayable!,
        ),
      if (publisher.hasContactEmail)
        _ref(
          href: 'mailto:${publisher.contactEmail}',
          label: publisher.contactEmail!,
          iconPath: '/static/img/email-icon.svg',
        ),
    ]),
    d.p(
      children: [
        d.text('Publisher registered on '),
        d.shortTimestamp(publisher.created!),
      ],
    ),
  ]);
}

d.Node _ref({
  required String href,
  String? rel,
  required String label,
  String? iconPath,
}) {
  return d.span(classes: [
    'detail-header-metadata-ref'
  ], children: [
    d.img(
      classes: ['detail-header-metadata-ref-icon'],
      src: staticUrls.getAssetUrl(iconPath ?? '/static/img/link-icon.svg'),
    ),
    d.a(
      classes: ['detail-header-metadata-ref-label'],
      href: href,
      rel: rel,
      text: label,
    ),
  ]);
}

extension on Publisher {
  String get shortDescription {
    if (!hasDescription) {
      return '';
    }
    if (description!.length < 1010) return description!;
    return '${description!.substring(0, 1000)} [...]';
  }
}
