// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:pub_dev/shared/configuration.dart';
import 'package:test/test.dart';
import 'package:yaml/yaml.dart' as yaml;

void main() {
  test('Foo config from yaml file', () async {
    final config = Configuration.fromYamlFile(
      'test/shared/test_data/foo_config.yaml',
    );
    final expectedValue = 'foo';
    expect(config.projectId, expectedValue);
    expect(config.canonicalPackagesBucketName, expectedValue);
    expect(config.reportsBucketName, expectedValue);
    expect(config.downloadCountsBucketName, expectedValue);
    expect(config.admins![0].email, 'foo@foo.foo');
    expect(config.admins![0].oauthUserId, '42');
    expect(
      config.admins![0].permissions.contains(AdminPermission.listUsers),
      isTrue,
    );
  });

  test(
    'Cloud Run config selects cloudRun* URLs when K_SERVICE is set',
    () async {
      final gaeConfig = Configuration.fromYamlFile(
        'config/dartlang-pub-dev.yaml',
        environment: {
          'GOOGLE_CLOUD_PROJECT': 'dartlang-pub-dev',
          'GAE_VERSION': '20261020t120000',
        },
      );
      expect(
        gaeConfig.searchServicePrefix,
        'https://20261020t120000-dot-search-dot-dartlang-pub-dev.appspot.com',
      );
      expect(
        gaeConfig.fallbackSearchServicePrefix,
        'https://search-dot-dartlang-pub-dev.appspot.com',
      );
      expect(
        gaeConfig.defaultServiceBaseUrl,
        'https://20261020t120000-dot-dartlang-pub-dev.appspot.com',
      );

      final cloudRunConfig = Configuration.fromYamlFile(
        'config/dartlang-pub-dev.yaml',
        environment: {
          'GOOGLE_CLOUD_PROJECT': 'dartlang-pub-dev',
          'GAE_VERSION': '20261020t120000',
          'K_SERVICE': 'default',
        },
      );
      expect(
        cloudRunConfig.searchServicePrefix,
        'https://v-20261020t120000---search-621485135717.us-central1.run.app',
      );
      expect(
        cloudRunConfig.fallbackSearchServicePrefix,
        'https://search-621485135717.us-central1.run.app',
      );
      expect(
        cloudRunConfig.defaultServiceBaseUrl,
        'https://v-20261020t120000---default-621485135717.us-central1.run.app',
      );
    },
  );

  test('content replacement success', () {
    expect(
      Configuration.replaceEnvVariables('a{{B}}c{{B}}d', {'B': 'bb'}),
      'abbcbbd',
    );
  });

  test('content replacement failed', () {
    expect(
      () => Configuration.replaceEnvVariables('a{{B}}c', {'C': 'bb'}),
      throwsA(isArgumentError),
    );
  });

  test('configuration files content', () async {
    final files = Directory('config')
        .listSync()
        .whereType<File>()
        .where((f) => f.path.endsWith('.yaml'))
        .toList();
    expect(files, hasLength(2));

    for (final f in files) {
      // serialization
      final fileContent = f.readAsStringSync();
      final replacedContent = Configuration.replaceEnvVariables(fileContent, {
        'GOOGLE_CLOUD_PROJECT': 'test',
        'GAE_VERSION': '1234',
      });
      final jsonContent = json.decode(
        json.encode(yaml.loadYaml(replacedContent)),
      );
      final config = Configuration.fromJson(
        jsonContent as Map<String, dynamic>,
      );
      final serialized = json.decode(json.encode(config.toJson()));
      expect(serialized, jsonContent);

      // rate limit rules
      final modelFileContent = await File(
        'lib/audit/models.dart',
      ).readAsString();
      final rateLimits = config.rateLimits ?? <RateLimit>[];
      for (final limit in rateLimits) {
        expect(
          modelFileContent.contains("'${limit.operation}'"),
          isTrue,
          reason: limit.operation,
        );
      }
      // no duplicate rules
      expect(
        rateLimits.map((e) => '${e.operation}/${e.scope}').toSet().length,
        rateLimits.length,
      );
      // some rules for prod config
      if (config.isProduction) {
        expect(rateLimits, hasLength(greaterThan(10)));
      }

      // expect bucket names are non-null
      expect(config.allBucketNames, isNotEmpty);
    }
  });
}
