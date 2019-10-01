// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:client_data/page_data.dart';
import 'package:meta/meta.dart';

import '../../package/models.dart' show PackageView;
import '../../search/search_service.dart' show SearchQuery;
import '../../shared/urls.dart';

import '_cache.dart';
import 'layout.dart';
import 'listing.dart';

/// Renders the `views/authorized.mustache` template.
String renderAuthorizedPage() {
  final String content = templateCache.renderTemplate('authorized', {});
  return renderLayoutPage(PageType.package, content,
      title: 'Pub Authorized Successfully', includeSurvey: false);
}

/// Renders the `views/uploader_approval.mustache` template.
String renderUploaderApprovalPage(
    String package, String inviteEmail, String uploaderEmail, String authUrl) {
  final String content = templateCache.renderTemplate('uploader_approval', {
    'invite_email': inviteEmail,
    'package': package,
    'package_url': pkgPageUrl(package),
    'full_site_url': fullSiteUrl,
    'primary_host': primaryHost,
    'auth_url': authUrl,
  });
  return renderLayoutPage(PageType.package, content,
      title: 'Uploader invitation', includeSurvey: false);
}

/// Renders the `views/consent.mustache` template.
String renderConsentPage(String consentId) {
  final content = templateCache.renderTemplate('consent', {});
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
        '$totalCount packages for <code>${htmlEscape.convert(searchQuery.query)}</code>';
  } else {
    resultCountHtml =
        totalCount > 0 ? '$totalCount packages.' : 'You have no packages.';
  }

  final packageListHtml = packages.isEmpty ? '' : renderPackageList(packages);
  final paginationHtml = renderPagination(pageLinks);

  final content = [resultCountHtml, packageListHtml, paginationHtml].join('\n');

  return renderLayoutPage(
    PageType.listing,
    content,
    title: title,
    searchQuery: searchQuery,
    noIndex: true,
  );
}
