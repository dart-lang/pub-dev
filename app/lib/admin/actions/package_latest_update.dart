// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/backend.dart';

import 'actions.dart';

final packageLatestUpdate = AdminAction(
  name: 'package-latest-update',
  summary: 'Updates the latest version of a package or all packages.',
  description: '''
Ensures Package.latestVersion / latestPreviewVersion / latestPrereleaseVersion is up-to-date.

When no package is specified, all packages will be updated.
''',
  options: {
    'package': 'The package to be updated (optional).',
    'concurrency':
        'The concurrently running update operations (defaults to 10).',
  },
  invoke: (options) async {
    final package = options['package'];
    final concurrency = int.parse(options['concurrency'] ?? '10');

    if (package != null) {
      final updated = await packageBackend.updatePackageVersions(package);
      return {
        'updated': updated,
      };
    } else {
      final stat = await packageBackend.updateAllPackageVersions(
          concurrency: concurrency);
      return {
        'updatedCount': stat,
      };
    }
  },
);
