// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/publisher_api.dart' as api;
import 'package:client_data/page_data.dart';

import '../../audit/models.dart';
import '../../frontend/request_context.dart';
import '../../frontend/templates/views/account/activity_log_table.dart';
import '../../package/search_adapter.dart' show SearchResultPage;
import '../../publisher/models.dart' show Publisher, PublisherSummary;
import '../../search/search_form.dart' show SearchForm;
import '../../shared/markdown.dart';
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
    noIndex: true, // no need to index, as the page is only for a logged-in user
  );
}

/// Renders the `views/publisher/publisher_list.mustache` template
String renderPublisherList(List<PublisherSummary> publishers,
    {required bool isGlobal}) {
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
String renderPublisherListPage(List<PublisherSummary> publishers) {
  final content = renderPublisherList(publishers, isGlobal: true);
  return renderLayoutPage(
    PageType.listing,
    content,
    title: 'Publishers',
    canonicalUrl: '/publishers',
  );
}

/// Returns the formatted short description of the publisher description.
String? _shortDescriptionHtml(Publisher publisher) {
  if (!publisher.hasDescription) '';
  String? description = publisher.description;
  if (description != null && description.length > 1010) {
    description = description.substring(0, 1000) + '[...]';
  }
  return markdownToHtml(description, inlineOnly: true);
}

/// Renders the search results on the publisher's packages page.
String renderPublisherPackagesPage({
  required Publisher publisher,
  required SearchResultPage searchResultPage,
  required String? messageFromBackend,
  required PageLinks pageLinks,
  required SearchForm searchForm,
  required int totalCount,
  required bool isAdmin,
}) {
  final isSearch = searchForm.hasQuery;
  String title = 'Packages of publisher ${publisher.publisherId}';
  if (isSearch && pageLinks.currentPage! > 1) {
    title += ' | Page ${pageLinks.currentPage}';
  }

  final packageListHtml =
      searchResultPage.hasNoHit ? '' : renderPackageList(searchResultPage);
  final paginationHtml = renderPagination(pageLinks).toString();

  final tabContent = [
    renderListingInfo(
      searchForm: searchForm,
      totalCount: totalCount,
      ownedBy: publisher.publisherId,
      messageFromBackend: messageFromBackend,
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
    if (isAdmin) _adminLinkTab(publisher.publisherId!),
    if (isAdmin && requestContext.displayActivityLog)
      _activityLogLinkTab(publisher.publisherId!),
  ];

  final mainContent = renderDetailPage(
    headerHtml: _renderDetailHeader(publisher),
    tabs: tabs,
    infoBoxHtml: null,
  );

  return renderLayoutPage(
    PageType.publisher, mainContent,
    title: title,
    pageData: PageData(
      publisher: PublisherData(
        publisherId: publisher.publisherId!,
      ),
    ),
    publisherId: publisher.publisherId,
    searchForm: searchForm,
    canonicalUrl: searchForm.toSearchLink(),
    // index only the first page, if it has packages displayed without search query
    noIndex:
        searchResultPage.hasNoHit || isSearch || pageLinks.currentPage! > 1,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

/// Renders the `views/publisher/admin_page.mustache` template.
String renderPublisherAdminPage({
  required Publisher publisher,
  required List<api.PublisherMember> members,
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
    _packagesLinkTab(publisher.publisherId!),
    Tab.withContent(
      id: 'admin',
      title: 'Admin',
      contentHtml: adminContent,
    ),
    if (requestContext.displayActivityLog)
      _activityLogLinkTab(publisher.publisherId!),
  ];

  final content = renderDetailPage(
    headerHtml: _renderDetailHeader(publisher),
    tabs: tabs,
    infoBoxHtml: null,
  );
  return renderLayoutPage(
    PageType.publisher,
    content,
    title: 'Publisher: ${publisher.publisherId}',
    pageData: PageData(
      publisher: PublisherData(
        publisherId: publisher.publisherId!,
      ),
    ),
    canonicalUrl: urls.publisherAdminUrl(publisher.publisherId!),
    noIndex: true,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

/// Renders the publisher's activity log page.
String renderPublisherActivityLogPage({
  required Publisher publisher,
  required AuditLogRecordPage activities,
}) {
  final activityLogNode = renderActivityLog(
    baseUrl: urls.publisherActivityLogUrl(publisher.publisherId!),
    activities: activities,
    forCategory: 'publisher',
    forEntity: publisher.publisherId!,
  );
  final tabs = <Tab>[
    _packagesLinkTab(publisher.publisherId!),
    _adminLinkTab(publisher.publisherId!),
    Tab.withContent(
      id: 'activity-log',
      title: 'Activity log',
      contentHtml: activityLogNode.toString(),
    ),
  ];

  final content = renderDetailPage(
    headerHtml: _renderDetailHeader(publisher),
    tabs: tabs,
    infoBoxHtml: null,
  );
  return renderLayoutPage(
    PageType.publisher,
    content,
    title: 'Publisher: ${publisher.publisherId}',
    pageData: PageData(
      publisher: PublisherData(
        publisherId: publisher.publisherId!,
      ),
    ),
    canonicalUrl: urls.publisherActivityLogUrl(publisher.publisherId!),
    noIndex: true,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

String _renderDetailHeader(Publisher publisher) {
  final websiteUri = urls.parseValidUrl(publisher.websiteUrl);
  final websiteRel = (websiteUri?.shouldIndicateUgc ?? false) ? 'ugc' : null;
  final metadataHtml = templateCache.renderTemplate(
    'publisher/header_metadata',
    {
      'short_created': shortDateFormat.format(publisher.created!),
      'has_description': publisher.hasDescription,
      'description_html': _shortDescriptionHtml(publisher),
      'has_contact_email': publisher.hasContactEmail,
      'contact_email': publisher.contactEmail,
      'has_website_url': websiteUri != null,
      'website_url': publisher.websiteUrl,
      'website_url_displayed': urls.displayableUrl(publisher.websiteUrl),
      'website_url_rel': websiteRel,
    },
  );
  return renderDetailHeader(
    title: publisher.publisherId,
    metadataHtml: metadataHtml,
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

Tab _activityLogLinkTab(String publisherId) => Tab.withLink(
      id: 'activity-log',
      title: 'Activity log',
      href: urls.publisherActivityLogUrl(publisherId),
    );
