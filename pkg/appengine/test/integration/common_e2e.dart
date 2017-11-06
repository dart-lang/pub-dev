// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library test.integration.common_e2e;

import 'dart:async';
import 'dart:io';

import 'package:googleapis_auth/auth_io.dart' as auth;

// Environment variables for specifying the cloud project to use and the
// location of the service account key for that project.
const String PROJECT_ENV = 'E2E_TEST_PROJECT';
const String SERVICE_KEY_LOCATION_ENV = 'E2E_TEST_KEY';

// Default project and service key location used when running on the package
// bot.
const String DEFAULT_PROJECT = 'dart-gcloud-e2e';
const String DEFAULT_KEY_LOCATION =
    'gs://dart-archive-internal/keys/dart-gcloud-e2e.json';

bool onBot() {
  final name = Platform.isWindows ? 'USERNAME' : 'USER';
  return Platform.environment[name] == 'chrome-bot';
}

Future withServiceAccount(
    Future callback(
        String project, auth.ServiceAccountCredentials creds)) async {
  var project = Platform.environment[PROJECT_ENV];
  var serviceKeyLocation = Platform.environment[SERVICE_KEY_LOCATION_ENV];

  if (!onBot() && (project == null || serviceKeyLocation == null)) {
    throw new Exception(
        'Environment variables $PROJECT_ENV and $SERVICE_KEY_LOCATION_ENV '
        'required when not running on the package bot');
  }

  project = project ?? DEFAULT_PROJECT;
  serviceKeyLocation = serviceKeyLocation ?? DEFAULT_KEY_LOCATION;

  final keyJson = await _serviceKeyJson(serviceKeyLocation);
  final creds = new auth.ServiceAccountCredentials.fromJson(keyJson);
  return callback(project, creds);
}

Future<String> _serviceKeyJson(String serviceKeyLocation) async {
  if (!serviceKeyLocation.startsWith('gs://')) {
    return new File(serviceKeyLocation).readAsString();
  } else {
    ProcessResult result;
    if (onBot()) {
      // Use gsutil.py from depot_tools on the bots.
      final gsutilPath = Platform.operatingSystem == 'windows'
          ? 'E:\\b\\depot_tools\\gsutil.py'
          : '/b/depot_tools/gsutil.py';
      result = await Process.run(
          'python', [gsutilPath, 'cat', serviceKeyLocation],
          runInShell: true);
    } else {
      final gsutil = Platform.isWindows ? 'gsutil.cmd' : 'gsutil';
      result = await Process.run(gsutil, ['cat', serviceKeyLocation]);
    }
    if (result.exitCode != 0) {
      throw new Exception('Failed to run gsutil, ${result.stderr}');
    }
    return result.stdout;
  }
}
