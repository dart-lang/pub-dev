// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../analyzer/analyzer_client.dart';
import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import '_cache.dart';
import 'detail_page.dart';
import 'layout.dart';
import 'misc.dart';
import 'package.dart';

/// Renders the `views/pkg/admin_page` template.
String renderPkgAdminPage(
  Package package,
  List<String> uploaderEmails,
  PackageVersion version,
  AnalysisView analysis,
  List<String> userPublishers,
) {
  final tabs = <Tab>[];
  if (version.readme != null) {
    tabs.add(readmeTabLink(package.name));
  }
  if (version.changelog != null) {
    tabs.add(changelogTabLink(package.name));
  }
  if (version.example != null) {
    tabs.add(exampleTabLink(package.name));
  }
  tabs.add(installingTabLink(package.name));
  tabs.add(versionsTabLink(package.name));
  tabs.add(scoreTabLink(PackageView.fromModel(
      package: package, version: version, scoreCard: analysis?.card)));
  tabs.add(Tab.withContent(
    id: 'admin',
    title: 'Admin',
    contentHtml: templateCache.renderTemplate('pkg/admin_page', {
      'pkg_has_publisher': package.publisherId != null,
      'publisher_id': package.publisherId,
      'is_discontinued': package.isDiscontinued,
      'user_has_publisher': userPublishers.isNotEmpty,
      'user_publishers': userPublishers
          .map((s) => {
                'publisher_id': s,
                'selected': s == package.publisherId,
              })
          .toList(),
      'create_publisher_url': urls.createPublisherUrl(),
    }),
  ));

  final content = renderDetailPage(
    headerHtml: renderPkgHeader(package, version, false, analysis),
    tabs: tabs,
    infoBoxLead: version.ellipsizedDescription,
    infoBoxHtml: renderPkgInfoBox(package, version, uploaderEmails, analysis),
  );

  return renderLayoutPage(
    PageType.package,
    content,
    title: '${package.name} package - Admin',
    pageData: pkgPageData(package, version),
    noIndex: true,
  );
}
