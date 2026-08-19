// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:grpc/grpc.dart' as grpc;
import 'package:appengine/src/grpc_api_impl/datastore_impl.dart'
    as grpc_datastore_impl;

// Environment variable for specifying the cloud project to use
const String PROJECT_ENV = 'E2E_TEST_PROJECT';

bool onBot() {
  // Check for GitHub Actions.
  if (Platform.environment['CI'] == 'true') {
    return true;
  }

  // Redundent GitHub Actions check.
  if (Platform.environment.containsKey('GITHUB_ACTION')) {
    return true;
  }

  // Chromium LUCI check.
  final name = Platform.isWindows ? 'USERNAME' : 'USER';
  return Platform.environment[name] == 'chrome-bot';
}

Future<dynamic> withAuthenticator(
  List<String> scopes,
  Future Function(String project, grpc.HttpBasedAuthenticator authenticator)
      callback,
) async {
  var project = Platform.environment[PROJECT_ENV];

  if (project == null) {
    throw Exception('Environment variable $PROJECT_ENV is required!');
  }

  // Use ADC
  final authenticator = await grpc.applicationDefaultCredentialsAuthenticator(
    grpc_datastore_impl.OAuth2Scopes,
  );
  return callback(project, authenticator);
}
