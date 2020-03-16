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
    tabs.add(Tab.withLink(
      id: 'readme',
      title: 'Readme',
      href: urls.pkgReadmeUrl(package.name),
    ));
  }
  if (version.changelog != null) {
    tabs.add(Tab.withLink(
      id: 'changelog',
      title: 'Changelog',
      href: urls.pkgChangelogUrl(package.name),
    ));
  }
  if (version.example != null) {
    tabs.add(Tab.withLink(
      id: 'example',
      title: 'Example',
      href: urls.pkgExampleUrl(package.name),
    ));
  }
  tabs.add(Tab.withLink(
    id: 'installing',
    title: 'Installing',
    href: urls.pkgInstallUrl(package.name),
  ));
  tabs.add(Tab.withLink(
    id: 'versions',
    title: 'Versions',
    href: urls.pkgVersionsUrl(package.name),
  ));
  tabs.add(Tab.withLink(
      id: 'analysis',
      titleHtml: renderScoreBox(
        PackageView.fromModel(
            package: package, version: version, scoreCard: analysis?.card),
        isTabHeader: true,
      ),
      href: urls.pkgScoreUrl(package.name)));
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
