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

import '../request_context.dart';

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
    noIndex: true, // no need to index, as the page is only for a logged-in user
  );
}

/// Renders the `views/publisher/publisher_list.mustache` template
String renderPublisherList(List<Publisher> publishers,
    {@required bool isGlobal}) {
  final noPublisherHtml = isGlobal
      ? 'No publisher has been registered.'
      : 'You are not a member of any <a href="https://dart.dev/tools/pub/verified-publishers" target="_blank" rel="noreferrer">verified publishers</a>.';
  return templateCache.renderTemplate('publisher/publisher_list', {
    'is_global': isGlobal,
    'title': isGlobal ? 'Publishers' : null,
    'no_publisher_message_html': noPublisherHtml,
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
    'create_publisher_url': urls.createPublisherUrl(),
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

/// Returns the formatted short description of the publisher description.
String _shortDescriptionHtml(Publisher publisher) {
  if (!publisher.hasDescription) '';
  String description = publisher.description;
  if (description != null && description.length > 1010) {
    description = description.substring(0, 1000) + '[...]';
  }
  return htmlEscape.convert(description);
}

/// Renders the `views/publisher/info_box.mustache` template.
String _renderPublisherInfoBox(Publisher publisher) {
  if (requestContext.isExperimental) return null;
  final descriptionHtml = _shortDescriptionHtml(publisher);
  return templateCache.renderTemplate('publisher/info_box', {
    'has_description': descriptionHtml != null && descriptionHtml.isNotEmpty,
    'description_html': descriptionHtml,
    'publisher_id': publisher.publisherId,
    'website_url': publisher.websiteUrl,
    'website_url_displayed': urls.displayableUrl(publisher.websiteUrl),
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

  String resultCountHtml() {
    if (isSearch) {
      return '$totalCount package(s) owned by <code>${publisher.publisherId}</code> for search query '
          '<code>${htmlEscape.convert(searchQuery.query)}</code>';
    } else {
      return totalCount > 0
          ? '$totalCount package(s) owned by <code>${publisher.publisherId}</code>.'
          : '<code>${publisher.publisherId}</code> has no packages.';
    }
  }

  final packageListHtml = packages.isEmpty
      ? ''
      : renderPackageList(packages, searchQuery: searchQuery);
  final paginationHtml = renderPagination(pageLinks);

  final tabContent = [
    if (!requestContext.isExperimental) renderSortControl(searchQuery),
    if (!requestContext.isExperimental) resultCountHtml(),
    if (requestContext.isExperimental)
      renderListingInfo(
        searchQuery: searchQuery,
        totalCount: totalCount,
        ownedBy: publisher.publisherId,
      ),
    packageListHtml,
    paginationHtml,
  ].join('\n');

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
    mainClasses:
        requestContext.isExperimental ? [wideHeaderDetailPageClassName] : null,
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
    'member_list': members
        .map((m) => {
              'user_id': m.userId,
              'email': m.email,
              'role': m.role,
            })
        .toList(),
  });
  final tabs = <Tab>[
    _packagesLinkTab(publisher.publisherId),
    Tab.withContent(
      id: 'admin',
      title: 'Admin',
      contentHtml: adminContent,
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
    mainClasses:
        requestContext.isExperimental ? [wideHeaderDetailPageClassName] : null,
  );
}

String _renderDetailHeader(Publisher publisher) {
  final metadataHtml = templateCache.renderTemplate(
    'publisher/header_metadata',
    {
      'short_created': shortDateFormat.format(publisher.created),
      'has_description': publisher.hasDescription,
      'description_html': _shortDescriptionHtml(publisher),
      'has_contact_email': publisher.hasContactEmail,
      'contact_email': publisher.contactEmail,
      'has_website_url': publisher.hasWebsiteUrl,
      'website_url': publisher.websiteUrl,
      'website_url_displayed': urls.displayableUrl(publisher.websiteUrl),
    },
  );
  return renderDetailHeader(
    title: publisher.publisherId,
    metadataHtml: metadataHtml,
    // do not render the shield on the new UI
    isPublisher: !requestContext.isExperimental,
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
