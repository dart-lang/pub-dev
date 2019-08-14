// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../analyzer/analyzer_client.dart';
import '../../package/models.dart';
import '../../shared/urls.dart' as urls;

import '../static_files.dart';

import '_cache.dart';
import 'layout.dart';
import 'misc.dart';
import 'package.dart';

/// Renders the `views/pkg/admin_page` template.
String renderPkgAdminPage(
  Package package,
  List<String> uploaderEmails,
  PackageVersion version,
  AnalysisView analysis,
) {
  final card = analysis?.card;

  final tabs = <Tab>[];
  if (version.readme != null) {
    tabs.add(Tab.withLink(
      id: 'readme',
      title: 'Readme',
      href: urls.pkgPageUrl(package.name, fragment: '-readme-tab-'),
    ));
  }
  if (version.changelog != null) {
    tabs.add(Tab.withLink(
      id: 'changelog',
      title: 'Changelog',
      href: urls.pkgPageUrl(package.name, fragment: '-changelog-tab-'),
    ));
  }
  if (version.example != null) {
    tabs.add(Tab.withLink(
      id: 'example',
      title: 'Example',
      href: urls.pkgPageUrl(package.name, fragment: '-example-tab-'),
    ));
  }
  tabs.add(Tab.withLink(
    id: 'installing',
    title: 'Installing',
    href: urls.pkgPageUrl(package.name, fragment: '-installing-tab-'),
  ));
  tabs.add(Tab.withLink(
    id: 'versions',
    title: 'Versions',
    href: urls.pkgVersionsUrl(package.name),
  ));
  tabs.add(Tab.withLink(
      id: 'analysis',
      titleHtml: renderScoreBox(card?.overallScore,
          isSkipped: card?.isSkipped ?? false,
          isNewPackage: package.isNewPackage()),
      href: urls.pkgPageUrl(package.name, fragment: '-analysis-tab-')));
  tabs.add(Tab.withContent(
    id: 'admin',
    title: 'Admin',
    contentHtml: templateCache.renderTemplate('pkg/admin_page', {
      'is_discontinued': package.isDiscontinued == true,
    }),
  ));

  final values = {
    'header_html': renderPkgHeader(package, version, analysis),
    'tabs_html': renderPkgTabs(tabs),
    'icons': staticUrls.versionsTableIcons,
    'sidebar_html':
        renderPkgSidebar(package, version, uploaderEmails, analysis),
    // TODO: render schema_org_pkgmeta_json
  };
  final content = templateCache.renderTemplate('pkg/show', values);

  return renderLayoutPage(
    PageType.package,
    content,
    title: '${package.name} package - Admin',
    pageData: pkgPageData(package, version),
    noIndex: true,
  );
}
