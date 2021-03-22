// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import 'package:pub_dev/shared/configuration.dart';

void main() {
  test('Foo config from yaml file', () async {
    final config =
        Configuration.fromYamlFile('test/shared/test_data/foo_config.yaml');
    final expectedValue = 'foo';
    expect(config.projectId, expectedValue);
    expect(config.packageBucketName, expectedValue);
    expect(config.dartdocStorageBucketName, expectedValue);
    expect(config.popularityDumpBucketName, expectedValue);
    expect(config.admins[0].email, 'foo@foo.foo');
    expect(config.admins[0].oauthUserId, '42');
    expect(config.admins[0].permissions.contains(AdminPermission.listUsers),
        isTrue);
  });

  test('Prod config from yaml file', () async {
    final config = Configuration.fromYamlFile('config/prod-config.yaml');
    final expectedConfig = Configuration.prod();
    expect(config.toJson(), expectedConfig.toJson());
  });

  test('Staging config from yaml file', () async {
    final config = Configuration.fromYamlFile('config/staging-config.yaml');
    final expectedConfig = Configuration.staging();
    expect(config.toJson(), expectedConfig.toJson());
  });
}
