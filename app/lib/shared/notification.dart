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

  Future notifyAnalyzer(String package, String version) async {
    try {
      final String httpHostPort = activeConfiguration.analyzerServicePrefix;
      final String uri = '$httpHostPort/packages/$package/$version';
      await _doNotify(uri);
    } catch (e) {
      // we are running in travis
      _logger.info('Environment was not initialized: $e');
    }
  }

  Future notifySearch(String package) async {
    try {
      final String httpHostPort = activeConfiguration.searchServicePrefix;
      final String uri = '$httpHostPort/packages/$package';
      await _doNotify(uri);
    } catch (e) {
      // we are running in travis
      _logger.info('Environment was not initialized: $e');
    }
  }

  Future _doNotify(String uri) async {
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
