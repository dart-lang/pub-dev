// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/task/backend.dart';

final taskBumpPriority = AdminAction(
  name: 'task-bump-priority',
  summary: 'Increase priority for task scheduling of specific package',
  description: '''
This action will lower the `PackageState.pendingAt` property for the given
package. This should cause an analysis task for the package to be scheduled
sooner.

This will always set `pendingAt` to the same value, it will not trigger new
analysis, if none is pending, merely increase the priority. Calling it multiple
times will have no effect, it will always set `pendingAt` to the same value.

This is intended for debugging, or solving one-off issues.
''',
  options: {
    'package': 'Name of package whose priority should be bumped',
  },
  invoke: (options) async {
    final package = options['package']!;
    InvalidInputException.checkPackageName(package);

    await taskBackend.adminBumpPriority(package);

    return {'message': 'Priority may have been bumped, good luck!'};
  },
);
