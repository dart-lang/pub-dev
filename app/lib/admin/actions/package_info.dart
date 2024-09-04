// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/backend.dart';

import 'actions.dart';

final packageInfo = AdminAction(
  name: 'package-info',
  summary: 'Gets the package information.',
  description: '''
Loads and displays the package information.
''',
  options: {
    'package': 'The package to be loaded.',
  },
  invoke: (options) async {
    final package = options['package'];
    InvalidInputException.check(
      package != null && package.isNotEmpty,
      '`package` must be given',
    );

    final p = await packageBackend.lookupPackage(package!);
    if (p == null) {
      throw NotFoundException.resource(package);
    }

    return {
      'package': {
        'name': p.name,
        'created': p.created?.toIso8601String(),
        'publisherId': p.publisherId,
        'latestVersion': p.latestVersion,
        'isModerated': p.isModerated,
        if (p.moderatedAt != null)
          'moderatedAt': p.moderatedAt?.toIso8601String(),
      },
    };
  },
);
