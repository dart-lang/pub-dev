// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/models.dart';
import 'package:pub_dev/publisher/backend.dart';
import 'package:pub_dev/shared/datastore.dart';

import 'actions.dart';

final packagePublisherSet = AdminAction(
  name: 'package-publisher-set',
  summary: 'Sets the publisher for a package.',
  description: 'Sets a new `publisherId` for a `package`.',
  options: {
    'package': 'The package to be updated.',
    'publisher': 'The `publisherId` to set.',
  },
  invoke: (options) async {
    final packageName = options['package'];
    final publisherId = options['publisher'];

    if (packageName == null) {
      throw InvalidInputException('Missing --package argument.');
    }
    if (publisherId == null) {
      throw InvalidInputException('Missing --publisher argument.');
    }

    final package = (await packageBackend.lookupPackage(packageName))!;
    final publisher = await publisherBackend.lookupPublisher(publisherId);
    if (publisher == null || !publisher.isVisible) {
      InvalidInputException(
        'Publisher `$publisherId` does not exists or is not visible.',
      );
    }
    final currentPublisherId = package.publisherId;
    if (currentPublisherId != publisherId) {
      await withRetryTransaction(dbService, (tx) async {
        final pkg = await tx.lookupValue<Package>(package.key);
        pkg.publisherId = publisherId;
        pkg.updated = clock.now().toUtc();
        tx.insert(pkg);
      });
      await purgePublisherCache(publisherId);
      triggerPackagePostUpdates(
        packageName,
        skipReanalysis: true,
        skipArchiveExport: true,
      );
      if (currentPublisherId != null) {
        await purgePublisherCache(currentPublisherId);
      }
    }

    final pkg = await packageBackend.lookupPackage(packageName);
    return {
      'before': {'publisherId': currentPublisherId},
      'after': {'publisherId': pkg!.publisherId},
    };
  },
);
