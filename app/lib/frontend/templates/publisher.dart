// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/page_data.dart';

import '../../package/models.dart' show PackageView;
import '../../publisher/models.dart' show Publisher;
import '../../shared/markdown.dart';
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import 'detail_page.dart';
import 'layout.dart';
import 'listing.dart';

/// Renders the `views/publisher/create.mustache` template.
String renderCreatePublisherPage() {
  final String content = templateCache.renderTemplate('publisher/create', {});
  return renderLayoutPage(
    PageType.standalone,
    content,
    title: 'Create publisher',
    // TODO: enable indexing after we have launched publishers.
    noIndex: true,
  );
}

/// Renders the publisher page with the top packages as tab content.
String renderPublisherPage(Publisher publisher, List<PackageView> packages) {
  final tabContent = packages.isEmpty
      ? 'The publisher has no packages.'
      : renderPackageList(packages);

  final tabs = <Tab>[
    Tab.withContent(
      id: 'packages',
      title: 'Top Packages',
      contentHtml: tabContent,
    ),
    _aboutLinkTab(publisher.publisherId),
    _adminLinkTab(publisher.publisherId),
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

/// Renders the publisher page with the main description as tab content.
String renderPublisherAboutPage(Publisher publisher) {
  final tabs = <Tab>[
    _packagesLinkTab(publisher.publisherId),
    Tab.withContent(
      id: 'about',
      title: 'About',
      contentHtml: markdownToHtml(publisher.description, null),
      isMarkdown: true,
    ),
    _adminLinkTab(publisher.publisherId),
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
    'search_link': urls.searchUrl(q: 'publisher:${publisher.publisherId}'),
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
    _packagesLinkTab(publisher.publisherId),
    _aboutLinkTab(publisher.publisherId),
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

Tab _packagesLinkTab(String publisherId) => Tab.withLink(
      id: 'packages',
      title: 'Top Packages',
      href: urls.publisherUrl(publisherId),
    );

Tab _aboutLinkTab(String publisherId) => Tab.withLink(
      id: 'about',
      title: 'About',
      href: urls.publisherAboutUrl(publisherId),
    );

Tab _adminLinkTab(String publisherId) => Tab.withLink(
      id: 'admin',
      title: 'Admin',
      href: urls.publisherAdminUrl(publisherId),
      isHidden: true,
    );
