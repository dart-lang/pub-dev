// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/data/page_data.dart';

import '../dom/dom.dart' as d;

import 'layout.dart';
import 'views/consent/package_uploader_invite.dart';
import 'views/consent/page.dart';
import 'views/consent/publisher_contact_invite.dart';
import 'views/consent/publisher_member_invite.dart';

/// Renders the consent page template.
String renderConsentPage({
  required String consentId,
  required String title,
  required String descriptionHtml,
}) {
  final content = consentPageNode(
    title: title,
    description: d.unsafeRawHtml(descriptionHtml),
  );
  return renderLayoutPage(
    PageType.standalone,
    content,
    title: 'Consent',
    noIndex: true,
    pageData: PageData(
      consentId: consentId,
      sessionAware: true,
    ),
  );
}

/// Renders the package uploader invite template.
String renderPackageUploaderInvite({
  required String invitingUserEmail,
  required String packageName,
  required String? currentUserEmail,
}) {
  return packageUploaderInviteNode(
    invitingUserEmail: invitingUserEmail,
    packageName: packageName,
    currentUserEmail: currentUserEmail,
  ).toString();
}

/// Renders the publisher member invite template.
String renderPublisherMemberInvite({
  required String invitingUserEmail,
  required String publisherId,
}) {
  return publisherMemberInviteNode(
    invitingUserEmail: invitingUserEmail,
    publisherId: publisherId,
  ).toString();
}

/// Renders the publisher contact invite template.
String renderPublisherContactInvite({
  required String invitingUserEmail,
  required String publisherId,
  required String contactEmail,
}) {
  return publisherContactInviteNode(
    invitingUserEmail: invitingUserEmail,
    publisherId: publisherId,
    contactEmail: contactEmail,
  ).toString();
}
