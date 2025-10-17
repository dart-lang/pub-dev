// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:clock/clock.dart';
import 'package:postgres/postgres.dart';
import 'package:pub_dev/database/database.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:test/test.dart';

import '../shared/test_services.dart';

void main() {
  group('Postgresql connection on CI', () {
    test('connects to CI instance', () async {
      final pubPostgresUrl = envConfig.pubPostgresUrl;
      if (pubPostgresUrl == null) {
        markTestSkipped('PUB_POSTGRES_URL was not specified.');
        return;
      }
      try {
        await Connection.open(
          Endpoint(host: 'localhost', database: 'postgres'),
        );
      } catch (e, st) {
        print(e);
        print(st);
      }
      final conn = await Connection.openFromUrl(pubPostgresUrl);
      final rs1 = await conn.execute('SELECT 1;');
      expect(rs1[0][0], 1);

      final dbName =
          'pubtemp_${clock.now().millisecondsSinceEpoch.toRadixString(36)}';
      await conn.execute('CREATE DATABASE $dbName');
      await conn.execute('DROP DATABASE $dbName');
    });

    testWithProfile(
      'registered database scope',
      fn: () async {
        final name = await primaryDatabase!.verifyConnection();
        expect(name, contains('fake_pub_'));
      },
    );
  });
}
