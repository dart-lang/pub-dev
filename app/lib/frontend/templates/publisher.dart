// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/page_data.dart';
import 'package:_pub_shared/data/publisher_api.dart' as api;
import 'package:_pub_shared/search/search_form.dart' show SearchForm;

import '../../audit/models.dart';
import '../../frontend/templates/views/account/activity_log_table.dart';
import '../../package/models.dart';
import '../../publisher/models.dart' show Publisher, PublisherSummary;
import '../../shared/urls.dart' as urls;
import '../dom/dom.dart' as d;
import 'detail_page.dart';
import 'layout.dart';
import 'views/landing/mini_list.dart';
import 'views/landing/page.dart';
import 'views/publisher/admin_page.dart';
import 'views/publisher/create_page.dart';
import 'views/publisher/header_metadata.dart';
import 'views/publisher/publisher_list.dart';

/// Renders the create publisher page.
String renderCreatePublisherPage() {
  return renderLayoutPage(
    PageType.standalone,
    createPublisherPageNode,
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

/// Renders the publisher's packages page.
String renderPublisherPackagesPage({
  required Publisher publisher,
  required List<PackageView> topPackages,
  required SearchForm searchForm,
  required bool isAdmin,
}) {
  final title = 'Publisher ${publisher.publisherId}';

  final tabContent = d.fragment([
    if (publisher.hasDescription) d.markdown(publisher.description!),
    if (topPackages.isEmpty) d.p(text: 'The publisher has no packages yet.'),
    if (topPackages.isNotEmpty)
      homePageBlockNode(
        shortId: 'publisher',
        title: 'Popular packages',
        info: d.text('Some of the most popular packages of this publisher.'),
        content: miniListNode('publisher-packages', topPackages),
        viewAllUrl: urls.searchUrl(q: 'publisher:${publisher.publisherId}'),
        viewAllEvent: 'view-all-event',
        viewAllLabel: 'Search the publisher\'s packages',
        viewAllExtraClass: 'left',
      ),
  ]);

  final tabs = <Tab>[
    Tab.withContent(
      id: 'about',
      title: 'About',
      contentNode: tabContent,
    ),
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
    publisherId: publisher.publisherId,
    searchForm: searchForm,
    canonicalUrl: searchForm.toSearchLink(),
    // index only if it has packages displayed
    noIndex: topPackages.isNotEmpty,
    // mainClasses: [wideHeaderDetailPageClassName],
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
    // mainClasses: [wideHeaderDetailPageClassName],
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
    // mainClasses: [wideHeaderDetailPageClassName],
  );
}

d.Node _renderDetailHeader(Publisher publisher) {
  return renderDetailHeader(
    title: publisher.publisherId,
    metadataNode: publisherHeaderMetadataNode(publisher),
  );
}

Tab _packagesLinkTab(String publisherId) => Tab.withLink(
      id: 'about',
      title: 'About',
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
