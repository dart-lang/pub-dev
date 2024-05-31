// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/backend.dart';

import 'actions.dart';

final moderationCaseInfo = AdminAction(
  name: 'moderation-case-info',
  summary: 'Gets the moderation case information.',
  description: '''
Loads and displays the moderation case information.
''',
  options: {
    'case': 'The caseId to be loaded.',
  },
  invoke: (options) async {
    final caseId = options['case'];
    InvalidInputException.check(
      caseId != null && caseId.isNotEmpty,
      'case must be given',
    );

    final mc = await adminBackend.lookupModerationCase(caseId!);
    if (mc == null) {
      throw NotFoundException.resource(caseId);
    }

    return mc.toDebugInfo();
  },
);
