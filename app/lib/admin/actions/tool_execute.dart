// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/admin/backend.dart';

final toolExecute = AdminAction(
  name: 'tool-execute',
  summary: 'Execute legacy tool',
  description: '''
Execute a legacy tool. Beware that args will be split on comma, hence, it's not
possible to call them with arguments that contain comma.
''',
  options: {
    'tool': 'name of tool to execute',
    'args': 'comma separated list of arguments',
  },
  invoke: (options) async {
    final toolName = options['tool'] ??
        (throw InvalidInputException('Missing --tool argument'));
    final argsOption = options['args'] ??
        (throw InvalidInputException('Missing --args argument'));
    final args = argsOption.split(',');
    InvalidInputException.check(toolName.isNotEmpty, 'tool must given');

    final tool = availableTools[toolName];
    if (tool == null) {
      throw NotFoundException.resource(toolName);
    }

    final message = await tool(args);

    return {'message': message};
  },
);
