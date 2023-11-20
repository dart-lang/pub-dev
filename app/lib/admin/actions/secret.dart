// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/admin/actions/actions.dart';
import 'package:pub_dev/service/secret/backend.dart';

final setSecret = AdminAction(
  name: 'secret',
  summary: 'View, set or clear a secret value',
  description: '''
Get, set or remove a "secret" admin value affecting the site.

If a `--value` is given, the secret will be set to that value. An empty value
will clear the secret.

To just inspect a secret, use the `get-secret` action.

Possible secrets are [${SecretKey.values}] or prefixed ${SecretKey.oauthPrefix}.

The `announcement` secret will update the banner shown at the top of the pub.dev
site and is usually cached for 30 minutes. So expect at least that long before
the change is picked up.

The `upload-restriction` is restriction applied on uploads.

This feature is intended as an emergency brake if the site is experiencing
overload or is being attacked.

Valid values for `upload-restriction` are:
 * `no-uploads`, no package publications will be accepted by the server,
 * `only-updates`, publication of new packages will not be accepted, but new versions of existing packages will be accepted, and,
 * `no-restriction`, (default) publication of new packages and new versions is allowed.
''',
  options: {
    'id':
        'The secret to view/update. One of [${SecretKey.values}] or prefixed ${SecretKey.oauthPrefix}.',
    'value': 'The new value.',
  },
  invoke: (options) async {
    final secretId = options['id']!;
    InvalidInputException.check(
      secretId.isNotEmpty,
      'id must be given',
    );
    InvalidInputException.check(
      SecretKey.isValid(secretId),
      'ID should be one of [${SecretKey.values}] or prefixed'
      ' ${SecretKey.oauthPrefix}.',
    );

    final value = options['value']!;

    final currentValue = await secretBackend.lookup(secretId);

    await secretBackend.update(secretId, value);
    return {
      'message': 'Value updated.',
      'previousValue': currentValue,
      'newValue': value
    };
  },
);
