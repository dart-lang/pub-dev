// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/models.dart' show LikeData, User, UserSessionData;
import '../../audit/models.dart';
import '../../frontend/templates/views/account/activity_log_table.dart';
import '../../package/models.dart';
import '../../publisher/models.dart' show PublisherSummary;
import '../../shared/urls.dart' as urls;

import '../dom/dom.dart' as d;
import '_consts.dart';
import 'detail_page.dart';
import 'layout.dart';
import 'views/account/authorized.dart';
import 'views/pkg/liked_package_list.dart';
import 'views/pkg/package_list.dart';
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
  required List<PackageView> packageHits,
  required String? startPackage,
  required String? nextPackage,
}) {
  String title = 'My packages';
  final hasStartPackage = startPackage != null && startPackage.isNotEmpty;
  if (hasStartPackage) {
    title += ' | starting with $startPackage';
  }

  final hasNoPackage = startPackage == null && packageHits.isEmpty;

  final prefix = 'List of your packages without a verified publisher';
  final tabContent = d.fragment([
    if (hasNoPackage)
      d.p(text: '$prefix: you have no package where you are an uploader.')
    else if (hasStartPackage)
      d.markdown('$prefix, starting with `$startPackage`:')
    else
      d.p(text: '$prefix:'),
    listOfPackagesNode(
      searchForm: null,
      sdkLibraryHits: [],
      packageHits: packageHits,
    ),
    if (nextPackage != null)
      d.div(
        child: d.a(
          classes: ['link-button'],
          href: urls.myPackagesUrl(next: nextPackage),
          text: 'Next...',
        ),
      ),
  ]);
  final content = renderDetailPage(
    headerNode: _accountDetailHeader(user, userSessionData),
    tabs: [
      _myPublishersLink(),
      Tab.withContent(
          id: 'my-packages',
          title: myPackagesTabTitle,
          contentNode: tabContent),
      _myLikedPackagesLink(),
      _myActivityLogLink(),
    ],
    infoBoxNode: null,
  );

  return renderLayoutPage(
    PageType.account,
    content,
    title: title,
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
      _myPublishersLink(),
      _myPackagesLink(),
      Tab.withContent(
          id: 'my-liked-packages',
          title: myLikedPackagesTabTitle,
          contentNode: tabContent),
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
      Tab.withContent(
        id: 'my-publishers',
        title: myPublishersTabTitle,
        contentNode: pln,
      ),
      _myPackagesLink(),
      _myLikedPackagesLink(),
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
      _myPublishersLink(),
      _myPackagesLink(),
      _myLikedPackagesLink(),
      Tab.withContent(
        id: 'my-activity-log',
        title: myActivityLogTabTitle,
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
    id: 'my-packages', title: myPackagesTabTitle, href: urls.myPackagesUrl());

Tab _myLikedPackagesLink() => Tab.withLink(
    id: 'my-liked-packages',
    title: myLikedPackagesTabTitle,
    href: urls.myLikedPackagesUrl());

Tab _myPublishersLink() => Tab.withLink(
    id: 'my-publishers',
    title: myPublishersTabTitle,
    href: urls.myPublishersUrl());

Tab _myActivityLogLink() => Tab.withLink(
    id: 'my-activity-log',
    title: myActivityLogTabTitle,
    href: urls.myActivityLogUrl());

d.Node _accountDetailHeader(User user, UserSessionData userSessionData) {
  return renderDetailHeader(
    title: userSessionData.name,
    image: d.Image(
      src: userSessionData.imageUrlOfSize(200),
      alt: 'user profile picture',
      width: 200,
      height: 200,
    ),
    metadataNode: d.fragment([
      d.p(text: user.email!),
      d.p(children: [
        d.text('Joined '),
        d.xAgoTimestamp(user.created!, datePrefix: 'on'),
      ]),
    ]),
  );
}
