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
import '../../shared/utils.dart' show shortDateFormat;

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
    authorizedNode().toString(),
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

  final packageListHtml =
      searchResultPage.hasNoHit ? '' : renderPackageList(searchResultPage);
  final paginationHtml = paginationNode(pageLinks).toString();

  final tabContent = [
    renderListingInfo(
      searchForm: searchForm,
      totalCount: totalCount,
      ownedBy: 'you',
      messageFromBackend: messageFromBackend,
    ),
    packageListHtml,
    paginationHtml,
  ].join('\n');
  final content = renderDetailPage(
    headerHtml: _accountDetailHeader(user, userSessionData),
    tabs: [
      Tab.withContent(
          id: 'my-packages', title: 'My packages', contentHtml: tabContent),
      _myLikedPackagesLink(),
      _myPublishersLink(),
      _myActivityLogLink(),
    ],
    infoBoxHtml: null,
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
  final likedPackagesListHtml = likedPackageListNode(likes).toString();

  final resultCountHtml = likes.isNotEmpty
      ? '<p>You like ${likes.length} ${likes.length == 1 ? 'package' : 'packages'}. </p>'
      : '<p>You have not liked any packages yet.</p>';

  final tabContent = [
    resultCountHtml,
    likedPackagesListHtml,
  ].join('\n');
  final content = renderDetailPage(
    headerHtml: _accountDetailHeader(user, userSessionData),
    tabs: [
      _myPackagesLink(),
      Tab.withContent(
          id: 'my-liked-packages',
          title: 'My liked packages',
          contentHtml: tabContent),
      _myPublishersLink(),
      _myActivityLogLink(),
    ],
    infoBoxHtml: null,
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
    headerHtml: _accountDetailHeader(user, userSessionData),
    tabs: [
      _myPackagesLink(),
      _myLikedPackagesLink(),
      Tab.withContent(
        id: 'my-publishers',
        title: 'My publishers',
        contentHtml: pln.toString(),
      ),
      _myActivityLogLink(),
    ],
    infoBoxHtml: null,
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
    headerHtml: _accountDetailHeader(user, userSessionData),
    tabs: [
      _myPackagesLink(),
      _myLikedPackagesLink(),
      _myPublishersLink(),
      Tab.withContent(
        id: 'my-activity-log',
        title: 'My activity log',
        contentHtml: activityLog.toString(),
      ),
    ],
    infoBoxHtml: null,
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

String _accountDetailHeader(User user, UserSessionData userSessionData) {
  final shortJoined = shortDateFormat.format(user.created!);
  return renderDetailHeader(
    title: userSessionData.name,
    imageUrl: userSessionData.imageUrlOfSize(200),
    metadataNode: d.fragment([
      d.p(text: user.email!),
      d.p(text: 'Joined on $shortJoined'),
    ]),
  );
}
