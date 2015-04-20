// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.backend_test;

import 'dart:io';
import 'package:unittest/unittest.dart';

import '../bin/configuration.dart' as cfg;

main() {
  test('prod', () {
    var config = new cfg.Configuration.prod();
    expect(config.useDbKeys, isTrue);
    expect(config.useApiaryDatastore, isFalse);
    expect(config.packageBucketName, 'pub.dartlang.org');
    expect(config.projectId, isNull);
    expect(config.hasCredentials, isFalse);
  });

  test('prod_io', () {
    var config = new cfg.Configuration.prod_io();
    expect(config.useDbKeys, isTrue);
    expect(config.useApiaryDatastore, isTrue);
    expect(config.packageBucketName, 'pub.dartlang.org');
    expect(config.projectId, 'dartlang-pub');
    expect(config.hasCredentials, isTrue);
  });

  test('dev', () {
    var config = new cfg.Configuration.dev('my-project', 'my-bucket');
    expect(config.useDbKeys, isFalse);
    expect(config.useApiaryDatastore, isFalse);
    expect(config.projectId, 'my-project');
    expect(config.packageBucketName, 'my-bucket');
    expect(config.hasCredentials, isTrue);
  });

  test('dev_io', () {
    var config = new cfg.Configuration.dev_io('my-project', 'my-bucket');
    expect(config.useDbKeys, isFalse);
    expect(config.useApiaryDatastore, isTrue);
    expect(config.projectId, 'my-project');
    expect(config.packageBucketName, 'my-bucket');
    expect(config.hasCredentials, isTrue);

    config = config.replace(projectId: 'my-other-project');
    expect(config.useDbKeys, isFalse);
    expect(config.useApiaryDatastore, isTrue);
    expect(config.projectId, 'my-other-project');
    expect(config.packageBucketName, 'my-bucket');

    config = config.replace(packageBucketName: 'my-other-bucket');
    expect(config.useDbKeys, isFalse);
    expect(config.useApiaryDatastore, isTrue);
    expect(config.projectId, 'my-other-project');
    expect(config.packageBucketName, 'my-other-bucket');

    config = config.replace(useDbKeys: true);
    expect(config.useDbKeys, isTrue);
    expect(config.useApiaryDatastore, isTrue);
    expect(config.projectId, 'my-other-project');
    expect(config.packageBucketName, 'my-other-bucket');

    config = config.replace(useApiaryDatastore: false);
    expect(config.useDbKeys, isTrue);
    expect(config.useApiaryDatastore, isFalse);
    expect(config.projectId, 'my-other-project');
    expect(config.packageBucketName, 'my-other-bucket');

    Directory tempDir;
    try {
      // Service key which has been revoked!
      var key =
r'''{
  "private_key_id": "be22d05caa0f138d2d8b1c2a9dd18556afa19e35",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIICdwIBADANBgkqhkiG9w0BAQEFAASCAmEwggJdAgEAAoGBAOg7cTEV38XcG4xv\nPU8nJHq37aa/WwY/Btr0IsjNRa52njZXFwYcEgYnDUyuLtvrpz3RgkJ3/tnamTfS\nCp4mhEKaRIifYKM3ttDx+L97ZEURNx38zWLW3vgmZx/PME7T1X6hIs9uMJfK4Obs\n1UTUUWyfodyq++2yK1aYr3L4DJ3nAgMBAAECgYEA0GNGlv1B55IzRjkrkrNVEKmr\nH03mqBw2UpNwAy/vrzXRkoFjr5/QrKSuUniao806LUaq1GpIzcRSaLyZuoBlfIhn\nFoAZUdJoanHWRvM5ZTUMzZx7arxuVRJgz8qeP4prlsS+o/d0IUwRSFkdaZrGsMkW\nt+srZxEeeTfg0rUnp0ECQQD+UdKXwTLN9flMHEpMzVChTSp9XGsoaZHnDrb6EVm1\n+X1umHXKGrSnHxhLFB38A91eohFFiGECXURYu12RR2cjAkEA6cRCTyeP+7sTOVe8\nSds12Hw0lJxLH5DwiQKFaLf4UVFBhKJ7HcOpZg2RS1P/bAe4NZQlPLEBnCycjD8e\n4fi8bQJAdk1tnzY6AeEIJMWMMonXlhElUMdq+ZOSUV9g8pabmrECDi5RrMAbhRpL\n3LDw+ch6c4kEa8nzBnyITJZsAiaq7QJAOlDgbdijvZucnxh4+z+5Pgk2IMCgqP5C\nUxuS5l3Gj5qiqpDR/8nYz4Gg9la9CFkgphUP+QT7LteeMgppDNw9PQJBAMlS35on\nC2ozCTbsfl0Kh5I3BYeiQCYew1/rPyb3rK5CXECVfcmuTvB+j3zEwuamSyZcbJIN\nqsEZOmfkeWFvT6c\u003d\n-----END PRIVATE KEY-----\n",
  "client_email": "208106123065-c4ojja0si03rvlf710v4uo7pcv6o89vn@developer.gserviceaccount.com",
  "client_id": "208106123065-c4ojja0si03rvlf710v4uo7pcv6o89vn.apps.googleusercontent.com",
  "type": "service_account"
}''';
      tempDir = Directory.systemTemp.createTempSync();
      var file =
          new File(tempDir.path + '/key')..writeAsStringSync(key);
      config = config.replace(credentialsFile: file.path);
      expect(config.hasCredentials, isTrue);
      expect(config.credentials, isNotNull);
    } finally {
      tempDir.deleteSync(recursive: true);
    }
  });
}