// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/admin/backend.dart';

final toolList = AdminAction(
  name: 'tool-list',
  summary: 'List legacy tools',
  description: '''
Print a list of legacy tools, these can be invoked with the `tool-execute`
command.
''',
  options: {},
  invoke: (options) async {
    return {
      'tools': availableTools.keys
          .map((k) => {
                'tool': k,
              })
          .toList(),
    };
  },
);
