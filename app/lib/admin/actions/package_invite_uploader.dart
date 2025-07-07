// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/backend.dart';

import '../../account/backend.dart';
import '../../account/consent_backend.dart';
import '../../shared/configuration.dart';
import 'actions.dart';

final packageInviteUploader = AdminAction(
  name: 'package-invite-uploader',
  summary: 'invite an email to be uploader of a package',
  description: '''
Sends an invite to <email> to become uploader of <package>.
''',
  options: {
    'package': 'Package for which to add an uploader',
    'email': 'email to send invitation to',
  },
  invoke: (options) async {
    final packageName = options['package'] ??
        (throw InvalidInputException('Missing --package argument.'));

    final invitedEmail = options['email'] ??
        (throw InvalidInputException('Missing --email argument.'));

    final package = await packageBackend.lookupPackage(packageName);
    if (package == null) {
      throw NotFoundException.resource(packageName);
    }
    if (package.publisherId != null) {
      throw OperationForbiddenException.publisherOwnedPackageNoUploader(
          packageName, package.publisherId!);
    }
    final authenticatedAgent =
        await requireAuthenticatedAdmin(AdminPermission.invokeAction);

    final inviteStatus = await consentBackend.invitePackageUploader(
        packageName: packageName,
        uploaderEmail: invitedEmail,
        agent: authenticatedAgent);

    final uploaderUsers =
        await accountBackend.lookupUsersById(package.uploaders!);
    final isNotUploaderYet =
        !uploaderUsers.any((u) => u!.email == invitedEmail);
    InvalidInputException.check(
        isNotUploaderYet, '`$invitedEmail` is already an uploader.');

    return {
      'message': 'Invited user',
      'package': packageName,
      'emailSent': inviteStatus.emailSent,
      'email': invitedEmail,
    };
  },
);
