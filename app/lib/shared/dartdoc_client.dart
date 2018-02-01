// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;

import 'configuration.dart';
import 'notification.dart' show notifyService;

/// Sets the dartdoc client.
void registerDartdocClient(DartdocClient client) =>
    ss.register(#_dartdocClient, client);

/// The active dartdoc client.
DartdocClient get dartdocClient => ss.lookup(#_dartdocClient);

/// Client methods that access the dartdoc service.
class DartdocClient {
  final http.Client _client = new http.Client();
  String get _dartdocServiceHttpHostPort =>
      activeConfiguration.dartdocServicePrefix;

  Future triggerDartdoc(
      String package, String version, Set<String> dependentPackages) async {
    await notifyService(_client, _dartdocServiceHttpHostPort, package, version);

    for (final String package in dependentPackages) {
      await notifyService(_client, _dartdocServiceHttpHostPort, package, null);
    }
  }

  Future close() async {
    _client.close();
  }
}
