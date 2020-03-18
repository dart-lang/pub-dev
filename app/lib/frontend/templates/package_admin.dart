// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import 'detail_page.dart';
import 'layout.dart';
import 'package.dart';

/// Renders the `views/pkg/admin_page` template.
String renderPkgAdminPage(
  PackagePageData data,
  List<String> userPublishers,
) {
  final tabs = buildPackageTabs(
    packagePageData: data,
    adminTab: Tab.withContent(
      id: 'admin',
      title: 'Admin',
      contentHtml: templateCache.renderTemplate('pkg/admin_page', {
        'pkg_has_publisher': data.package.publisherId != null,
        'publisher_id': data.package.publisherId,
        'is_discontinued': data.package.isDiscontinued,
        'user_has_publisher': userPublishers.isNotEmpty,
        'user_publishers': userPublishers
            .map((s) => {
                  'publisher_id': s,
                  'selected': s == data.package.publisherId,
                })
            .toList(),
        'create_publisher_url': urls.createPublisherUrl(),
      }),
    ),
  );

  final content = renderDetailPage(
    headerHtml: renderPkgHeader(data),
    tabs: tabs,
    infoBoxLead: data.version.ellipsizedDescription,
    infoBoxHtml: renderPkgInfoBox(data),
  );

  return renderLayoutPage(
    PageType.package,
    content,
    title: '${data.package.name} package - Admin',
    pageData: pkgPageData(data.package, data.version),
    noIndex: true,
  );
}
