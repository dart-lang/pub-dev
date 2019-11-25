// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/page_data.dart';
import 'package:meta/meta.dart';

import '../../account/models.dart' show LikeData, User;
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
import 'publisher.dart' show renderPublisherList;

/// Renders the `views/authorized.mustache` template.
String renderAuthorizedPage() {
  final String content = templateCache.renderTemplate('authorized', {});
  return renderLayoutPage(PageType.package, content,
      title: 'Pub Authorized Successfully', includeSurvey: false);
}

/// Renders the `views/consent.mustache` template.
String renderConsentPage({
  @required String consentId,
  @required String title,
  @required String descriptionHtml,
}) {
  final content = templateCache.renderTemplate('consent', {
    'title': title,
    'description_html': descriptionHtml,
  });
  return renderLayoutPage(
    PageType.standalone,
    content,
    title: 'Consent',
    pageData: PageData(consentId: consentId),
    includeSurvey: false,
  );
}

/// Renders the search results on the current user's packages page.
String renderAccountPackagesPage({
  @required User user,
  @required List<PackageView> packages,
  @required PageLinks pageLinks,
  @required SearchQuery searchQuery,
  @required int totalCount,
}) {
  final isSearch = searchQuery.hasQuery;
  String title = 'My packages';
  if (isSearch && pageLinks.currentPage > 1) {
    title += ' | Page ${pageLinks.currentPage}';
  }

  String resultCountHtml;
  if (isSearch) {
    resultCountHtml =
        '$totalCount owned ${totalCount == 1 ? 'package' : 'packages'} for '
        '<code>${htmlEscape.convert(searchQuery.query)}</code>';
  } else {
    resultCountHtml = totalCount > 0
        ? 'You own $totalCount ${totalCount == 1 ? 'package' : 'packages'}.'
        : 'You have not published any packages yet. Learn more about '
            '<a href="https://dart.dev/tools/pub/publishing">publishing packages</a>.';
  }

  final packageListHtml = packages.isEmpty ? '' : renderPackageList(packages);
  final paginationHtml = renderPagination(pageLinks);

  final tabContent = [
    renderSortControl(searchQuery),
    resultCountHtml,
    packageListHtml,
    paginationHtml,
  ].join('\n');
  final content = renderDetailPage(
    headerHtml: _accountDetailHeader(user),
    tabs: [
      Tab.withContent(
          id: 'packages', title: 'My packages', contentHtml: tabContent),
      if (requestContext.isExperimental) _myLikedPackagesLink(),
      _myPublishersLink(),
    ],
    infoBoxHtml: _accountInfoBox(user),
  );

  return renderLayoutPage(
    PageType.account,
    content,
    title: title,
    searchQuery: searchQuery,
    noIndex: true,
  );
}

/// Renders the current user's liked packages page.
String renderMyLikedPackagesPage(
    {@required User user, @required List<LikeData> likes}) {
  final likedPackagesListHtml = renderMyLikedPackagesList(likes);

  final resultCountHtml = likes.isNotEmpty
      ? 'You like ${likes.length} ${likes.length == 1 ? 'package' : 'packages'}. '
      : 'You have not liked any packages yet.';

  final tabContent = [
    resultCountHtml,
    likedPackagesListHtml,
  ].join('\n');
  final content = renderDetailPage(
    headerHtml: _accountDetailHeader(user),
    tabs: [
      _myPackagesLink(),
      Tab.withContent(
          id: 'liked-packages',
          title: 'My liked packages',
          contentHtml: tabContent),
      _myPublishersLink(),
    ],
    infoBoxHtml: _accountInfoBox(user),
  );

  return renderLayoutPage(
    PageType.account,
    content,
    title: 'My liked packages',
    noIndex: true,
  );
}

/// Renders the current user's publishers page.
String renderAccountPublishersPage({
  @required User user,
  @required List<Publisher> publishers,
}) {
  final publisherListHtml = renderPublisherList(publishers, isGlobal: false);

  final content = renderDetailPage(
    headerHtml: _accountDetailHeader(user),
    tabs: [
      _myPackagesLink(),
      if (requestContext.isExperimental) _myLikedPackagesLink(),
      Tab.withContent(
          id: 'publishers',
          title: 'My publishers',
          contentHtml: publisherListHtml),
    ],
    infoBoxHtml: _accountInfoBox(user),
  );

  return renderLayoutPage(
    PageType.account,
    content,
    title: 'My publishers',
    noIndex: true,
  );
}

Tab _myPackagesLink() =>
    Tab.withLink(id: 'packages', title: 'My packages', href: '/my-packages');

Tab _myLikedPackagesLink() => Tab.withLink(
    id: 'liked-packages',
    title: 'My liked packages',
    href: urls.myLikedPackagesUrl());

Tab _myPublishersLink() => Tab.withLink(
    id: 'publishers', title: 'My publishers', href: '/my-publishers');

String _accountDetailHeader(User user) {
  final shortJoined = shortDateFormat.format(user.created);
  return renderDetailHeader(
    title: 'User ${user.email}',
    metadataHtml: htmlEscape.convert('Joined on $shortJoined'),
  );
}

String _accountInfoBox(User user) {
  final shortJoined = shortDateFormat.format(user.created);
  return templateCache.renderTemplate('account/info_box', {
    'email': user.email,
    'joined_short': shortJoined,
  });
}
