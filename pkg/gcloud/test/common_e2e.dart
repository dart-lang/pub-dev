// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library gcloud.test.common_e2e;

import 'dart:async';
import 'dart:io';

import 'package:unittest/unittest.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

import 'common.dart';

const PROJECT = 'test-project';

// Environment variables for specifying the cloud project to use and the
// location of the service account key for that project.
const String PROJECT_ENV = 'GCLOUD_E2E_TEST_PROJECT';
const String SERVICE_KEY_LOCATION_ENV = 'GCLOUD_E2E_TEST_KEY';

// Default project and service key location used when running on the package
// bot.
const String DEFAULT_PROJECT = 'dart-gcloud-e2e';
const String DEFAULT_KEY_LOCATION =
    'gs://dart-archive-internal/keys/dart-gcloud-e2e.json';

// Used for storage e2e tests:
//
// List operations on buckets are eventually consistent. Bucket deletion is
// also dependent on list operations to ensure the bucket is empty before
// deletion.
//
// So this can make tests flaky. The following delay is introduced as an
// attempt to account for that.
const STORAGE_LIST_DELAY = const Duration(seconds: 5);

bool onBot() {
  // When running on the package-bot the current user is chrome-bot.
  var envName;
  if (Platform.isWindows) {
    envName = 'USERNAME';
  } else {
    envName = 'USER';
  }
  return Platform.environment[envName] == 'chrome-bot';
}

// Get the service key from the specified location.
Future<String> serviceKeyJson(String serviceKeyLocation) {
  if (!serviceKeyLocation.startsWith('gs://')) {
    return new File(serviceKeyLocation).readAsString();
  }
  var future;
  if (onBot()) {
    future = Process.run(
        'python', ['third_party/gsutil/gsutil', 'cat', serviceKeyLocation],
        runInShell: true);
  } else {
    var gsutil = Platform.isWindows ? 'gsutil.cmd' : 'gsutil';
    future = Process.run(gsutil, ['cat', serviceKeyLocation]);
  }
  return future.then((result) {
    if (result.exitCode != 0) {
      throw new Exception('Failed to run gsutil, ${result.stderr}');
    }
    return result.stdout;
  });
}

typedef Future AuthCallback(String project, http.Client client);

Future withAuthClient(List<String> scopes, AuthCallback callback,
    {bool trace: false}) {
  String project = Platform.environment[PROJECT_ENV];
  String serviceKeyLocation = Platform.environment[SERVICE_KEY_LOCATION_ENV];

  if (!onBot() && (project == null || serviceKeyLocation == null)) {
    throw new StateError(
        'Envoronment variables $PROJECT_ENV and $SERVICE_KEY_LOCATION_ENV '
        'required when not running on the package bot');
  }

  project = project != null ? project : DEFAULT_PROJECT;
  serviceKeyLocation =
      serviceKeyLocation != null ? serviceKeyLocation : DEFAULT_KEY_LOCATION;

  return serviceKeyJson(serviceKeyLocation).then((keyJson) {
    var creds = new auth.ServiceAccountCredentials.fromJson(keyJson);
    return auth
        .clientViaServiceAccount(creds, scopes)
        .then((http.Client client) {
      if (trace) client = new TraceClient(client);
      return callback(project, client).whenComplete(() => client.close());
    });
  });
}

Future runE2EUnittest(Function callback) {
  var config = new E2EConfiguration();

  unittestConfiguration = config;
  callback();

  return config.done;
}

class E2EConfiguration extends SimpleConfiguration {
  final Completer _completer = new Completer();

  Future get done => _completer.future;

  onDone(success) {
    new Future.sync(() {
      super.onDone(success);
    })
        .then((_) => _completer.complete(_))
        .catchError((error, stack) => _completer.completeError(error, stack));
  }
}
