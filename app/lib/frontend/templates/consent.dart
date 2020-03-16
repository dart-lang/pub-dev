// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/page_data.dart';
import 'package:meta/meta.dart';

import '../../shared/urls.dart' as urls;

import '_cache.dart';
import 'layout.dart';

/// Renders the `views/consent/page.mustache` template.
String renderConsentPage({
  @required String consentId,
  @required String title,
  @required String descriptionHtml,
}) {
  final content = templateCache.renderTemplate('consent/page', {
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

/// Renders the `views/consent/package_uploader_invite.mustache` template.
String renderPackageUploaderInvite({
  @required String invitingUserEmail,
  @required String packageName,
  @required String currentUserEmail,
}) {
  return templateCache.renderTemplate('consent/package_uploader_invite', {
    'inviting_user_email': invitingUserEmail,
    'package_name': packageName,
    'package_url': urls.pkgPageUrl(packageName),
    'current_user_email': currentUserEmail,
  });
}

/// Renders the `views/consent/publisher_member_invite.mustache` template.
String renderPublisherMemberInvite({
  @required String invitingUserEmail,
  @required String publisherId,
}) {
  return templateCache.renderTemplate('consent/publisher_member_invite', {
    'inviting_user_email': invitingUserEmail,
    'publisher_id': publisherId,
    'publisher_url': urls.publisherUrl(publisherId),
  });
}

/// Renders the `views/consent/publisher_contact_invite.mustache` template.
String renderPublisherContactInvite({
  @required String invitingUserEmail,
  @required String publisherId,
  @required String contactEmail,
}) {
  return templateCache.renderTemplate('consent/publisher_contact_invite', {
    'inviting_user_email': invitingUserEmail,
    'publisher_id': publisherId,
    'publisher_url': urls.publisherUrl(publisherId),
    'contact_email': contactEmail,
  });
}
