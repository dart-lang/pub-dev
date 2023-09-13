// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/admin/actions/actions.dart';

import '../../audit/models.dart';
import '../../package/backend.dart';
import '../../package/models.dart';
import '../../publisher/backend.dart';
import '../../shared/datastore.dart';

final removePackageFromPublisher = AdminAction(
    name: 'remove-package-from-publisher',
    options: {
      'package': 'name of the package to remove from its current publisher'
    },
    summary:
        'Removes <package> from its current publisher, and makes that publisher\'s owners uploaders',
    description: '''
Removes <package> from its current publisher, and makes that publisher\'s owners
 uploaders.

Fails if that package currently has no publisher.

Example: given a publisher example.com with two members a@example.com and
 b@example.com, and a package:foo in the publisher.

Executing `remove-package-from-publisher  --package=foo` will remove foo from
the publisher and assign a@example.com and b@example.com as uploaders.

If the publisher has no members, the package will end up without uploaders.
''',
    invoke: (args) async {
      final packageName = args['package'];
      if (packageName == null) {
        throw InvalidInputException('The argument package must be given');
      }
      final package = (await packageBackend.lookupPackage(packageName))!;
      final currentPublisherId = package.publisherId;
      if (currentPublisherId == null) {
        throw NotAcceptableException(
            'Package $packageName is not currently in a publisher');
      }
      final currentPublisherMembers =
          (await publisherBackend.listPublisherMembers(currentPublisherId));

      await withRetryTransaction(dbService, (tx) async {
        final pkg = await tx.lookupValue<Package>(package.key);
        pkg.publisherId = null;
        pkg.uploaders = currentPublisherMembers.map((e) => e.userId).toList();
        pkg.updated = clock.now().toUtc();
        tx.insert(pkg);
        tx.insert(
          AuditLogRecord.packageRemovedFromPublisher(
            package: packageName,
            fromPublisherId: currentPublisherId,
          ),
        );
      });
      await purgePackageCache(packageName);
      await purgePublisherCache(publisherId: currentPublisherId);
      return {
        'previousPublisher': currentPublisherId,
        'package': package.name,
        'uploaders': [
          for (final member in currentPublisherMembers)
            {
              'email': member.email,
              'userId': member.userId,
            }
        ],
      };
    });
