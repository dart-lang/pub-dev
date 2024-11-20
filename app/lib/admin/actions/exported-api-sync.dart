// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/api_export/api_exporter.dart';

import 'actions.dart';

final exportedApiSync = AdminAction(
  name: 'exported-api-sync',
  summary: 'Synchronize exported API bucket',
  description: '''
This command will trigger synchronization of exported API bucket.

This is the bucket from which API responses are served.

This synchronize packages specified with:
  --packages="foo bar"

Synchronize all packages with:
  --packages=ALL

Optionally, write rewrite of all files using:
  --force-write=true
''',
  options: {
    'packages': 'Space separated list of packages, use "ALL" for all!',
    'force-write': 'true/false if writes should be forced (default: false)',
  },
  invoke: (options) async {
    final forceWriteString = options['force-write'] ?? 'false';
    InvalidInputException.checkAnyOf(
      forceWriteString,
      'force-write',
      ['true', 'false'],
    );
    final forceWrite = forceWriteString == 'true';

    final packagesOpt = options['packages'] ?? '';
    final syncAll = packagesOpt == 'ALL';
    if (syncAll) {
      await apiExporter!.synchronizeExportedApi(forceWrite: forceWrite);
      return {
        'packages': 'ALL',
        'forceWrite': forceWrite,
      };
    } else {
      final packages = packagesOpt.split(' ').map((p) => p.trim()).toList();
      for (final p in packages) {
        InvalidInputException.checkPackageName(p);
      }
      for (final p in packages) {
        await apiExporter!.synchronizePackage(p, forceWrite: forceWrite);
      }
      return {
        'packages': packages,
        'forceWrite': forceWrite,
      };
    }
  },
);
