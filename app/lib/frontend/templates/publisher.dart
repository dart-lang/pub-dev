// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/publisher_api.dart' as api;
import 'package:client_data/page_data.dart';
import 'package:meta/meta.dart';

import '../../package/models.dart' show PackageView;
import '../../publisher/models.dart' show Publisher;
import '../../search/search_service.dart' show SearchQuery;
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart' show shortDateFormat;

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

/// Renders the `views/publisher/publisher_list.mustache` template
String renderPublisherList(List<Publisher> publishers,
    {@required bool isGlobal}) {
  return templateCache.renderTemplate('publisher/publisher_list', {
    'title': isGlobal ? 'Publishers' : null,
    'no_publisher_message': isGlobal
        ? 'No publisher has been registered.'
        : 'You have no publisher',
    'has_publishers': publishers.isNotEmpty,
    'publishers': publishers
        .map(
          (p) => {
            'publisher_id': p.publisherId,
            'url': urls.publisherUrl(p.publisherId),
            'short_created': shortDateFormat.format(p.created),
          },
        )
        .toList(),
  });
}

/// Renders the `views/publisher/publisher_list.mustache` template on a standard
/// layout.
String renderPublisherListPage(List<Publisher> publishers) {
  final content = renderPublisherList(publishers, isGlobal: true);
  return renderLayoutPage(
    PageType.listing,
    content,
    title: 'Publishers',
  );
}

/// Renders the `views/publisher/info_box.mustache` template.
String _renderPublisherInfoBox(Publisher publisher) {
  String description = publisher.description ?? '';
  if (description != null && description.length > 210) {
    description = description.substring(0, 200) + '[...]';
  }
  return templateCache.renderTemplate('publisher/info_box', {
    'has_description': description != null && description.isNotEmpty,
    'description_html': htmlEscape.convert(description),
    'publisher_id': publisher.publisherId,
    'website_url': publisher.websiteUrl,
    'contact_email': publisher.contactEmail,
    'list_packages_search_link':
        urls.searchUrl(q: 'publisher:${publisher.publisherId}'),
  });
}

/// Renders the search results on the publisher's packages page.
String renderPublisherPackagesPage({
  @required Publisher publisher,
  @required List<PackageView> packages,
  @required PageLinks pageLinks,
  @required SearchQuery searchQuery,
  @required int totalCount,
  @required bool isAdmin,
}) {
  final isSearch = searchQuery.hasQuery;
  String title = 'Packages of publisher ${publisher.publisherId}';
  if (isSearch && pageLinks.currentPage > 1) {
    title += ' | Page ${pageLinks.currentPage}';
  }

  String resultCountHtml;
  if (isSearch) {
    resultCountHtml =
        '$totalCount package(s) owned by <code>${publisher.publisherId}</code> for search query '
        '<code>${htmlEscape.convert(searchQuery.query)}</code>';
  } else {
    resultCountHtml = totalCount > 0
        ? '$totalCount package(s) owned by <code>${publisher.publisherId}</code>.'
        : '<code>${publisher.publisherId}</code> has no packages.';
  }

  final packageListHtml = packages.isEmpty ? '' : renderPackageList(packages);
  final paginationHtml = renderPagination(pageLinks);

  final tabContent =
      [resultCountHtml, packageListHtml, paginationHtml].join('\n');

  final tabs = <Tab>[
    Tab.withContent(
      id: 'packages',
      title: 'Packages',
      contentHtml: tabContent,
    ),
    if (isAdmin) _adminLinkTab(publisher.publisherId),
  ];

  final mainContent = renderDetailPage(
    headerHtml: _renderDetailHeader(publisher),
    tabs: tabs,
    infoBoxHtml: _renderPublisherInfoBox(publisher),
  );

  return renderLayoutPage(
    PageType.publisher, mainContent,
    title: title,
    pageData: PageData(
      publisher: PublisherData(
        publisherId: publisher.publisherId,
      ),
    ),
    publisherId: publisher.publisherId,
    searchQuery: searchQuery,
    // only index the first page, and if search query is not active
    noIndex: isSearch || pageLinks.currentPage > 1,
  );
}

/// Renders the `views/publisher/admin_page.mustache` template.
String renderPublisherAdminPage({
  @required Publisher publisher,
  @required List<api.PublisherMember> members,
}) {
  final String adminContent =
      templateCache.renderTemplate('publisher/admin_page', {
    'publisher_id': publisher.publisherId,
    'description': publisher.description,
    'website_url': publisher.websiteUrl,
    'contact_email': publisher.contactEmail,
    'member_list': members.map((m) => {
          'user_id': m.userId,
          'email': m.email,
          'role': m.role,
        }),
  });
  final tabs = <Tab>[
    _packagesLinkTab(publisher.publisherId),
    Tab.withContent(
      id: 'admin',
      title: 'Admin',
      contentHtml: adminContent,
      isMarkdown: true,
    ),
  ];

  final content = renderDetailPage(
    headerHtml: _renderDetailHeader(publisher),
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

String _renderDetailHeader(Publisher publisher) {
  final shortCreated = shortDateFormat.format(publisher.created);
  return renderDetailHeader(
    title: publisher.publisherId,
    metadataHtml: htmlEscape.convert('Publisher registered on $shortCreated.'),
    isPublisher: true,
  );
}

Tab _packagesLinkTab(String publisherId) => Tab.withLink(
      id: 'packages',
      title: 'Packages',
      href: urls.publisherPackagesUrl(publisherId),
    );

Tab _adminLinkTab(String publisherId) => Tab.withLink(
      id: 'admin',
      title: 'Admin',
      href: urls.publisherAdminUrl(publisherId),
    );
