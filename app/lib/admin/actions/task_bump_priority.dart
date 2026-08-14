// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/task/backend.dart';

final taskBumpPriority = AdminAction(
  name: 'task-bump-priority',
  summary: 'Increase priority and schedule analysis of specific package.',
  description: '''
This action bumps the priority of the given package.
Pending/running analysis will be cancelled and analysis of all versions will be
queued at highest priority.

It will also immediately trigger an analysis worker instance if quota is available.
If the instance quota limit is reached or instance creation fails, the priority
remains bumped and the background scheduler will pick it up as soon as possible.
''',
  options: {
    'package': 'Name of package whose priority should be bumped',
  },
  invoke: (options) async {
    final package =
        options['package'] ??
        (throw InvalidInputException('Needs a package name'));
    InvalidInputException.checkPackageName(package);
    // Make sure package exists.
    final pkg = await packageBackend.lookupPackage(package);
    if (pkg == null) {
      throw InvalidInputException('No package $package');
    }
    return await taskBackend.adminBumpPriority(package);
  },
);
