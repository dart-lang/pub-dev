// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/page_data.dart';

import '../../publisher/models.dart' show Publisher;
import '../../shared/markdown.dart';
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import 'detail_page.dart';
import 'layout.dart';

/// Renders the `views/publisher/create.mustache` template.
String renderCreatePublisherPage() {
  final String content = templateCache.renderTemplate('publisher/create', {});
  return renderLayoutPage(
    PageType.standalone,
    content,
    title: 'Create publisher',
    noIndex: true,
  );
}

/// Renders the publisher page with the main description as tab content.
String renderPublisherPage(Publisher publisher) {
  final tabs = <Tab>[
    Tab.withContent(
      id: 'about',
      title: 'About',
      contentHtml: markdownToHtml(publisher.description, null),
      isMarkdown: true,
    ),
    Tab.withLink(
      id: 'admin',
      title: 'Admin',
      href: urls.publisherAdminUrl(publisher.publisherId),
      isHidden: true,
    ),
  ];

  final content = renderDetailPage(
    headerHtml: renderDetailHeader(title: publisher.publisherId),
    tabs: tabs,
    infoBoxHtml: _renderPublisherInfoBox(publisher),
  );

  return renderLayoutPage(
    PageType.publisher,
    content,
    title: 'Publisher: ${publisher.publisherId}',
    pageData: PageData(
      publisher: PublisherData(
        publisherId: publisher.publisherId,
      ),
    ),
  );
}

/// Renders the `views/publisher/info_box.mustache` template.
String _renderPublisherInfoBox(Publisher publisher) {
  return templateCache.renderTemplate('publisher/info_box', {
    'description': _extractDescription(publisher.description),
    'publisher_id': publisher.publisherId,
    'website_url': publisher.websiteUrl,
    'contact_email': publisher.contactEmail,
  });
}

/// Extracts the first larger text block(s) from the markdown description of the
/// publisher.
String _extractDescription(String text) {
  if (text == null) return null;

  final blocks = text
      .trim()
      .split('\n\n')
      .map((s) => s.trim())
      .where(
        (s) =>
            s.isNotEmpty &&
            !s.startsWith('#') &&
            !s.startsWith('=') &&
            !s.startsWith('-'),
      )
      .toList();
  if (blocks.isEmpty) return null;

  final allText = blocks.join(' ');
  return allText.length < 220 ? allText : allText.substring(0, 200) + '[...]';
}

/// Renders the `views/publisher/admin_page.mustache` template.
String renderPublisherAdminPage(Publisher publisher) {
  final String adminContent =
      templateCache.renderTemplate('publisher/admin_page', {
    'publisher_id': publisher.publisherId,
    'description': publisher.description,
    'website_url': publisher.websiteUrl,
    'contact_email': publisher.contactEmail,
  });
  final tabs = <Tab>[
    Tab.withLink(
      id: 'about',
      title: 'About',
      href: urls.publisherUrl(publisher.publisherId),
    ),
    Tab.withContent(
      id: 'admin',
      title: 'Admin',
      contentHtml: adminContent,
      isMarkdown: true,
    ),
  ];

  final content = renderDetailPage(
    headerHtml: renderDetailHeader(title: publisher.publisherId),
    tabs: tabs,
    infoBoxHtml: _renderPublisherInfoBox(publisher),
  );
  return renderLayoutPage(
    PageType.publisher,
    content,
    title: 'Publisher: ${publisher.publisherId}',
    pageData: PageData(
      publisher: PublisherData(
        publisherId: publisher.publisherId,
      ),
    ),
    noIndex: true,
  );
}
