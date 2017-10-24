// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';

import 'configuration.dart';
import 'handlers.dart';

final Logger _logger = new Logger('pub.notification');

void registerNotificationClient(NotificationClient client) =>
    ss.register(#_notificationClient, client);

NotificationClient get notificationClient => ss.lookup(#_notificationClient);

class NotificationClient {
  final http.Client _client = new http.Client();

  Future notifyAnalyzer(
      String package, String version, Set<String> dependentPackages) async {
    await _doNotify(
        activeConfiguration.analyzerServicePrefix, package, version);

    for (final package in dependentPackages) {
      return _doNotify(
          activeConfiguration.analyzerServicePrefix, package, null);
    }
  }

  Future notifyDartdoc(String package, String version) =>
      _doNotify(activeConfiguration.dartdocServicePrefix, package, version);

  Future notifySearch(String package) =>
      _doNotify(activeConfiguration.searchServicePrefix, package, null);

  Future _doNotify(String servicePrefix, String package, String version) async {
    var uri = '$servicePrefix/packages/$package';
    if (version != null) {
      uri = '$uri/$version';
    }
    try {
      final response =
          await _client.post(uri, headers: await prepareNotificationHeaders());
      if (response.statusCode != 200) {
        _logger.warning('Notification request on $uri failed. '
            'Status code: ${response.statusCode}. '
            'Body: ${response.body}');
      }
    } catch (e) {
      _logger.severe('Notification request on $uri aborted: $e');
    }
  }

  Future close() async {
    _client.close();
  }
}
