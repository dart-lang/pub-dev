// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/page_data.dart';
import 'package:_pub_shared/data/publisher_api.dart' as api;
import 'package:_pub_shared/search/search_form.dart' show SearchForm;

import '../../audit/models.dart';
import '../../frontend/templates/views/account/activity_log_table.dart';
import '../../package/search_adapter.dart' show SearchResultPage;
import '../../publisher/models.dart';
import '../../shared/urls.dart' as urls;
import '../dom/dom.dart' as d;
import 'detail_page.dart';
import 'layout.dart';
import 'listing.dart';
import 'views/publisher/admin_page.dart';
import 'views/publisher/create_page.dart';
import 'views/publisher/header_metadata.dart';
import 'views/publisher/publisher_list.dart';

/// Renders the create publisher page.
String renderCreatePublisherPage({
  required String? domain,
}) {
  return renderLayoutPage(
    PageType.standalone,
    createPublisherPageNode(domain: domain),
    title: 'Create publisher',
    noIndex: true, // no need to index, as the page is only for a logged-in user
  );
}

/// Renders the global publisher list page.
String renderPublisherListPage(List<PublisherSummary> publishers) {
  final content = publisherListNode(publishers: publishers, isGlobal: true);
  return renderLayoutPage(
    PageType.listing,
    content,
    title: 'Publishers',
    canonicalUrl: '/publishers',
  );
}

/// Renders the search results on the publisher's packages page.
String renderPublisherPackagesPage({
  required Publisher publisher,
  required PublisherPackagesPageKind kind,
  required SearchResultPage searchResultPage,
  required String? messageFromBackend,
  required PageLinks pageLinks,
  required SearchForm searchForm,
  required int totalCount,
  required bool isAdmin,
}) {
  final title = 'Packages of publisher ${publisher.publisherId}';

  final tabContent = d.fragment([
    listingInfo(
      searchForm: searchForm,
      totalCount: totalCount,
      ownedBy: publisher.publisherId,
      messageFromBackend: messageFromBackend,
    ),
    if (kind == PublisherPackagesPageKind.unlisted)
      d.markdown(
          '**Remark:** Unlisted packages are not included in search results by default, '
          'however, unlisted packages are still publicly available. Unlisted packages '
          'can also be discovered through search using the `show:unlisted` term.'),
    if (searchResultPage.hasHit) packageList(searchResultPage),
    paginationNode(pageLinks),
  ]);

  String canonicalUrl;
  List<Tab> packagesTabs;
  switch (kind) {
    case PublisherPackagesPageKind.listed:
      canonicalUrl = urls.publisherPackagesUrl(publisher.publisherId);
      packagesTabs = <Tab>[
        Tab.withContent(
          id: 'packages',
          title: 'Packages',
          contentNode: tabContent,
        ),
        if (isAdmin) _unlistedPackagesLinkTab(publisher.publisherId),
      ];
      break;
    case PublisherPackagesPageKind.unlisted:
      canonicalUrl = urls.publisherUnlistedPackagesUrl(publisher.publisherId);
      packagesTabs = <Tab>[
        _packagesLinkTab(publisher.publisherId),
        Tab.withContent(
          id: 'unlisted-packages',
          title: 'Unlisted packages',
          contentNode: tabContent,
        ),
      ];
      break;
  }

  final tabs = <Tab>[
    ...packagesTabs,
    if (isAdmin) _adminLinkTab(publisher.publisherId),
    if (isAdmin) _activityLogLinkTab(publisher.publisherId),
  ];

  final mainContent = renderDetailPage(
    headerNode: _renderDetailHeader(publisher),
    tabs: tabs,
    infoBoxNode: null,
  );

  return renderLayoutPage(
    PageType.publisher, mainContent,
    title: title,
    pageData: PageData(
      publisher: PublisherData(
        publisherId: publisher.publisherId,
      ),
    ),
    searchForm: searchForm,
    canonicalUrl: canonicalUrl,
    // index only the first listed page, if it has packages displayed without search query
    noIndex: publisher.isUnlisted ||
        kind == PublisherPackagesPageKind.unlisted ||
        searchResultPage.hasNoHit ||
        pageLinks.currentPage! > 1,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

/// Renders the publisher admin page.
String renderPublisherAdminPage({
  required Publisher publisher,
  required List<api.PublisherMember> members,
}) {
  final tabs = <Tab>[
    _packagesLinkTab(publisher.publisherId),
    Tab.withContent(
      id: 'admin',
      title: 'Admin',
      contentNode: publisherAdminPageNode(
        publisher: publisher,
        members: members,
      ),
    ),
    _activityLogLinkTab(publisher.publisherId),
  ];

  final content = renderDetailPage(
    headerNode: _renderDetailHeader(publisher),
    tabs: tabs,
    infoBoxNode: null,
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
    canonicalUrl: urls.publisherAdminUrl(publisher.publisherId),
    noIndex: true,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

/// Renders the publisher's activity log page.
String renderPublisherActivityLogPage({
  required Publisher publisher,
  required AuditLogRecordPage activities,
}) {
  final activityLog = activityLogNode(
    baseUrl: urls.publisherActivityLogUrl(publisher.publisherId),
    activities: activities,
    forCategory: 'publisher',
    forEntity: publisher.publisherId,
  );
  final tabs = <Tab>[
    _packagesLinkTab(publisher.publisherId),
    _adminLinkTab(publisher.publisherId),
    Tab.withContent(
      id: 'activity-log',
      title: 'Activity log',
      contentNode: activityLog,
    ),
  ];

  final content = renderDetailPage(
    headerNode: _renderDetailHeader(publisher),
    tabs: tabs,
    infoBoxNode: null,
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
    canonicalUrl: urls.publisherActivityLogUrl(publisher.publisherId),
    noIndex: true,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

d.Node _renderDetailHeader(Publisher publisher) {
  return renderDetailHeader(
    title: publisher.publisherId,
    metadataNode: publisherHeaderMetadataNode(publisher),
  );
}

Tab _packagesLinkTab(String publisherId) => Tab.withLink(
      id: 'packages',
      title: 'Packages',
      href: urls.publisherPackagesUrl(publisherId),
    );

Tab _unlistedPackagesLinkTab(String publisherId) => Tab.withLink(
      id: 'unlisted-packages',
      title: 'Unlisted packages',
      href: urls.publisherUnlistedPackagesUrl(publisherId),
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
