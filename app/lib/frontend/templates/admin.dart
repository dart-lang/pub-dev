// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:meta/meta.dart';

import '../../account/models.dart' show LikeData, User, UserSessionData;
import '../../package/search_adapter.dart' show SearchResultPage;
import '../../publisher/models.dart' show PublisherSummary;
import '../../search/search_form.dart' show SearchForm;
import '../../shared/urls.dart' as urls;
import '../../shared/utils.dart' show shortDateFormat;

import '_cache.dart';
import 'detail_page.dart';
import 'layout.dart';
import 'listing.dart';
import 'publisher.dart' show renderPublisherList;

/// Renders the `views/account/authorized.mustache` template.
String renderAuthorizedPage() {
  final String content = templateCache.renderTemplate('account/authorized', {});
  return renderLayoutPage(
    PageType.package,
    content,
    title: 'Pub Authorized Successfully',
    noIndex: true,
  );
}

/// Renders the search results on the current user's packages page.
String renderAccountPackagesPage({
  @required User user,
  @required UserSessionData userSessionData,
  @required SearchResultPage searchResultPage,
  @required String messageFromBackend,
  @required PageLinks pageLinks,
  @required SearchForm searchForm,
  @required int totalCount,
}) {
  final isSearch = searchForm.hasQuery;
  String title = 'My packages';
  if (isSearch && pageLinks.currentPage > 1) {
    title += ' | Page ${pageLinks.currentPage}';
  }

  final packageListHtml =
      searchResultPage.hasNoHit ? '' : renderPackageList(searchResultPage);
  final paginationHtml = renderPagination(pageLinks);

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
          id: 'packages', title: 'My packages', contentHtml: tabContent),
      _myLikedPackagesLink(),
      _myPublishersLink(),
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
  @required User user,
  @required UserSessionData userSessionData,
  @required List<LikeData> likes,
}) {
  final likedPackagesListHtml = renderMyLikedPackagesList(likes);

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
          id: 'liked-packages',
          title: 'My liked packages',
          contentHtml: tabContent),
      _myPublishersLink(),
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
  @required User user,
  @required UserSessionData userSessionData,
  @required List<PublisherSummary> publishers,
}) {
  final publisherListHtml = renderPublisherList(publishers, isGlobal: false);

  final content = renderDetailPage(
    headerHtml: _accountDetailHeader(user, userSessionData),
    tabs: [
      _myPackagesLink(),
      _myLikedPackagesLink(),
      Tab.withContent(
          id: 'publishers',
          title: 'My publishers',
          contentHtml: publisherListHtml),
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

Tab _myPackagesLink() => Tab.withLink(
    id: 'packages', title: 'My packages', href: urls.myPackagesUrl());

Tab _myLikedPackagesLink() => Tab.withLink(
    id: 'liked-packages',
    title: 'My liked packages',
    href: urls.myLikedPackagesUrl());

Tab _myPublishersLink() => Tab.withLink(
    id: 'publishers', title: 'My publishers', href: urls.myPublishersUrl());

String _accountDetailHeader(User user, UserSessionData userSessionData) {
  final shortJoined = shortDateFormat.format(user.created);
  return renderDetailHeader(
    title: userSessionData.name,
    imageUrl: userSessionData.imageUrlOfSize(200),
    metadataHtml: '<p>${htmlEscape.convert(user.email)}</p>'
        '<p>${htmlEscape.convert('Joined on $shortJoined')}</p>',
  );
}
