// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../frontend/models.dart';

final Logger _logger = new Logger('pub.notification');

const String notificationSecretKey = 'notification-secret';

String _cachedNotificationSecret;

/// Gets the shared notification secret from the datastore (or local cache).
///
/// Ignoring cache invalidations for now, because at worst the notification is
/// not acknowledged, and the related processing will happen 10 minutes later.
Future<String> getNotificationSecret() async {
  if (_cachedNotificationSecret == null) {
    final db = dbService;
    final key = db.emptyKey.append(PrivateKey, id: notificationSecretKey);
    final PrivateKey privateKey = (await db.lookup([key])).first;
    _cachedNotificationSecret = privateKey?.value;
  }
  return _cachedNotificationSecret;
}

Future<bool> validateNotificationSecret(shelf.Request request) async {
  final String received = request.headers['x-notification-secret'];
  if (received == null) return false;
  final String secret = await getNotificationSecret();
  return received == secret;
}

Future<Map<String, String>> prepareNotificationHeaders() async => {
      'x-notification-secret': await getNotificationSecret(),
    };

Future notifyService(http.Client client, String servicePrefix, String package,
    String version) async {
  var uri = '$servicePrefix/packages/$package';
  if (version != null) {
    uri = '$uri/$version';
  }
  try {
    _logger.fine('Notification HTTP POST $uri');
    final response =
        await client.post(uri, headers: await prepareNotificationHeaders());
    if (response.statusCode != 200) {
      _logger.warning('Notification request on $uri failed. '
          'Status code: ${response.statusCode}. '
          'Body: ${response.body}');
    }
  } catch (e) {
    _logger.severe('Notification request on $uri aborted: $e');
  }
}
