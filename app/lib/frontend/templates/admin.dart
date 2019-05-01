// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../shared/urls.dart';

import '_cache.dart';
import 'layout.dart';

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
