// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/backend.dart';

import 'actions.dart';

final packageVersionInfo = AdminAction(
  name: 'package-version-info',
  summary: 'Gets the package version information.',
  description: '''
Loads and displays the package version information.
''',
  options: {
    'package': 'The package to be loaded.',
    'version': 'The version to be loaded.',
  },
  invoke: (options) async {
    final package = options['package'];
    InvalidInputException.check(
      package != null && package.isNotEmpty,
      '`package` must be given',
    );

    final version = options['version'];
    InvalidInputException.check(
      version != null && version.isNotEmpty,
      '`version` must be given',
    );

    final pv = await packageBackend.lookupPackageVersion(package!, version!);
    if (pv == null) {
      throw NotFoundException.resource('$package/$version');
    }

    return {
      'package-version': {
        'package': pv.package,
        'version': pv.version,
        'created': pv.created?.toIso8601String(),
        'isModerated': pv.isModerated,
        if (pv.moderatedAt != null)
          'moderatedAt': pv.moderatedAt?.toIso8601String(),
      },
    };
  },
);
