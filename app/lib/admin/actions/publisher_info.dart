// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/publisher/backend.dart';

import 'actions.dart';

final publisherInfo = AdminAction(
  name: 'publisher-info',
  summary: 'Gets the publisher information.',
  description: '''
Loads and displays the publisher information.
''',
  options: {
    'publisher': 'The publisherId to be loaded.',
  },
  invoke: (options) async {
    final publisherId = options['publisher'];
    InvalidInputException.check(
      publisherId != null && publisherId.isNotEmpty,
      '`publisher` must be given',
    );

    final p = await publisherBackend.getPublisher(publisherId!);
    if (p == null) {
      throw NotFoundException.resource(publisherId);
    }

    return {
      'publisher': {
        'publisherId': p.publisherId,
        'created': p.created?.toIso8601String(),
        'contactEmail': p.contactEmail,
        'isModerated': p.isModerated,
        if (p.moderatedAt != null)
          'moderatedAt': p.moderatedAt?.toIso8601String(),
      },
    };
  },
);
