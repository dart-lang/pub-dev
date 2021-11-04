// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/models.dart' show LikeData, User, UserSessionData;
import '../../audit/models.dart';
import '../../frontend/templates/views/account/activity_log_table.dart';
import '../../package/search_adapter.dart' show SearchResultPage;
import '../../publisher/models.dart' show PublisherSummary;
import '../../search/search_form.dart' show SearchForm;
import '../../shared/urls.dart' as urls;

import '../dom/dom.dart' as d;
import 'detail_page.dart';
import 'layout.dart';
import 'listing.dart';
import 'views/account/authorized.dart';
import 'views/pkg/liked_package_list.dart';
import 'views/publisher/publisher_list.dart';

/// Renders the response that is displayed after pub client authorizes successfully.
String renderAuthorizedPage() {
  return renderLayoutPage(
    PageType.package,
    authorizedNode,
    title: 'Pub Authorized Successfully',
    noIndex: true,
  );
}

/// Renders the search results on the current user's packages page.
String renderAccountPackagesPage({
  required User user,
  required UserSessionData userSessionData,
  required SearchResultPage searchResultPage,
  required String? messageFromBackend,
  required PageLinks pageLinks,
  required SearchForm searchForm,
  required int totalCount,
}) {
  final isSearch = searchForm.hasQuery;
  String title = 'My packages';
  if (isSearch && pageLinks.currentPage! > 1) {
    title += ' | Page ${pageLinks.currentPage}';
  }

  final tabContent = d.fragment([
    listingInfo(
      searchForm: searchForm,
      totalCount: totalCount,
      ownedBy: 'you',
      messageFromBackend: messageFromBackend,
    ),
    if (searchResultPage.hasHit) packageList(searchResultPage),
    paginationNode(pageLinks),
  ]);
  final content = renderDetailPage(
    headerNode: _accountDetailHeader(user, userSessionData),
    tabs: [
      Tab.withContent(
          id: 'my-packages', title: 'My packages', contentNode: tabContent),
      _myLikedPackagesLink(),
      _myPublishersLink(),
      _myActivityLogLink(),
    ],
    infoBoxNode: null,
  );

  return renderLayoutPage(
    PageType.account,
    content,
    title: title,
    searchForm: searchForm,
    noIndex: true,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

/// Renders the current user's liked packages page.
String renderMyLikedPackagesPage({
  required User user,
  required UserSessionData userSessionData,
  required List<LikeData> likes,
}) {
  final resultCount = likes.isNotEmpty
      ? d.p(
          text:
              'You like ${likes.length} ${likes.length == 1 ? 'package' : 'packages'}.')
      : d.p(text: 'You have not liked any packages yet.');

  final tabContent = d.fragment([
    resultCount,
    likedPackageListNode(likes),
  ]);
  final content = renderDetailPage(
    headerNode: _accountDetailHeader(user, userSessionData),
    tabs: [
      _myPackagesLink(),
      Tab.withContent(
          id: 'my-liked-packages',
          title: 'My liked packages',
          contentNode: tabContent),
      _myPublishersLink(),
      _myActivityLogLink(),
    ],
    infoBoxNode: null,
  );

  return renderLayoutPage(
    PageType.account,
    content,
    title: 'My liked packages',
    noIndex: true,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

/// Renders the current user's publishers page.
String renderAccountPublishersPage({
  required User user,
  required UserSessionData userSessionData,
  required List<PublisherSummary> publishers,
}) {
  final pln = publisherListNode(publishers: publishers, isGlobal: false);
  final content = renderDetailPage(
    headerNode: _accountDetailHeader(user, userSessionData),
    tabs: [
      _myPackagesLink(),
      _myLikedPackagesLink(),
      Tab.withContent(
        id: 'my-publishers',
        title: 'My publishers',
        contentNode: pln,
      ),
      _myActivityLogLink(),
    ],
    infoBoxNode: null,
  );

  return renderLayoutPage(
    PageType.account,
    content,
    title: 'My publishers',
    noIndex: true,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

/// Renders the current user's activity page.
String renderAccountMyActivityPage({
  required User user,
  required UserSessionData userSessionData,
  required AuditLogRecordPage activities,
}) {
  final activityLog = activityLogNode(
    baseUrl: urls.myActivityLogUrl(),
    activities: activities,
    forCategory: 'you',
  );

  final content = renderDetailPage(
    headerNode: _accountDetailHeader(user, userSessionData),
    tabs: [
      _myPackagesLink(),
      _myLikedPackagesLink(),
      _myPublishersLink(),
      Tab.withContent(
        id: 'my-activity-log',
        title: 'My activity log',
        contentNode: activityLog,
      ),
    ],
    infoBoxNode: null,
  );

  return renderLayoutPage(
    PageType.account,
    content,
    title: 'My activity log',
    noIndex: true,
    mainClasses: [wideHeaderDetailPageClassName],
  );
}

Tab _myPackagesLink() => Tab.withLink(
    id: 'my-packages', title: 'My packages', href: urls.myPackagesUrl());

Tab _myLikedPackagesLink() => Tab.withLink(
    id: 'my-liked-packages',
    title: 'My liked packages',
    href: urls.myLikedPackagesUrl());

Tab _myPublishersLink() => Tab.withLink(
    id: 'my-publishers', title: 'My publishers', href: urls.myPublishersUrl());

Tab _myActivityLogLink() => Tab.withLink(
    id: 'my-activity-log',
    title: 'My activity log',
    href: urls.myActivityLogUrl());

d.Node _accountDetailHeader(User user, UserSessionData userSessionData) {
  return renderDetailHeader(
    title: userSessionData.name,
    imageUrl: userSessionData.imageUrlOfSize(200),
    metadataNode: d.fragment([
      d.p(text: user.email!),
      d.p(children: [
        d.text('Joined on '),
        d.shortTimestamp(user.created!),
      ]),
    ]),
  );
}
