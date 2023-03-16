// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../account/models.dart';
import '../../audit/models.dart';
import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import 'detail_page.dart';
import 'layout.dart';
import 'package.dart';
import 'views/account/activity_log_table.dart';
import 'views/pkg/admin_page.dart';

/// Renders the package admin page.
String renderPkgAdminPage(
  PackagePageData data,
  List<String> userPublishers,
  List<User> uploaderUsers,
  List<String> retractableVersions,
  List<String> retractedVersions,
) {
  final tabs = buildPackageTabs(
    data: data,
    adminTab: Tab.withContent(
      id: 'admin',
      title: 'Admin',
      contentNode: packageAdminPageNode(
        package: data.package!,
        userPublishers: userPublishers,
        uploaderUsers: uploaderUsers,
        retractableVersions: retractableVersions,
        retractedVersions: retractedVersions,
      ),
    ),
  );

  final content = renderDetailPage(
    headerNode: renderPkgHeader(data),
    tabs: tabs,
    infoBoxLead: data.version!.ellipsizedDescription,
    infoBoxNode: renderPkgInfoBox(data),
  );

  return renderLayoutPage(
    PageType.package,
    content,
    title: '${data.package!.name} package - Admin',
    pageData: pkgPageData(
      data.package!,
      data.version!,
      editable: true,
    ),
    noIndex: true,
  );
}

String renderPkgActivityLogPage(
  PackagePageData data,
  AuditLogRecordPage activities,
) {
  final activityLog = activityLogNode(
    baseUrl: urls.pkgActivityLogUrl(data.package!.name!),
    activities: activities,
    forCategory: 'package',
    forEntity: data.package!.name!,
  );
  final tabs = buildPackageTabs(
    data: data,
    activityLogTab: Tab.withContent(
      id: 'activity-log',
      title: 'Activity Log',
      contentNode: activityLog,
    ),
  );
  final content = renderDetailPage(
    headerNode: renderPkgHeader(data),
    tabs: tabs,
    infoBoxLead: data.version!.ellipsizedDescription,
    infoBoxNode: renderPkgInfoBox(data),
  );
  return renderLayoutPage(
    PageType.package,
    content,
    title: '${data.package!.name} package - Admin',
    pageData: pkgPageData(data.package!, data.version!),
    noIndex: true,
  );
}
