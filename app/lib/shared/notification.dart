// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io' show HttpHeaders;

import 'package:gcloud/db.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:shelf/shelf.dart' as shelf;

import '../frontend/models.dart';
import 'handlers.dart' show jsonResponse;
import 'task_client.dart';

final Logger _logger = new Logger('pub.notification');

const String apiNotificationEndpoint = '/api/notification';
const String notificationSecretKey = 'notification-secret';

String _cachedNotificationSecret;

class _NotificationData {
  final String package;
  final String version;

  _NotificationData(this.package, this.version);

  factory _NotificationData.fromMap(Map<String, dynamic> map) =>
      new _NotificationData(map['package'] as String, map['version'] as String);

  bool get isValid => package != null;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'package': package,
        'version': version,
      };

  @override
  String toString() => '$package $version';
}

/// Gets the shared notification secret from the datastore (or local cache).
///
/// Ignoring cache invalidations for now, because at worst the notification is
/// not acknowledged, and the related processing will happen 10 minutes later.
Future<String> _getNotificationSecret() async {
  if (_cachedNotificationSecret == null) {
    final db = dbService;
    final key = db.emptyKey.append(PrivateKey, id: notificationSecretKey);
    final PrivateKey privateKey = (await db.lookup([key])).first;
    _cachedNotificationSecret = privateKey?.value;
  }
  return _cachedNotificationSecret;
}

Future<bool> _validateNotificationSecret(shelf.Request request) async {
  final String received = request.headers['x-notification-secret'];
  if (received == null) return false;
  final String secret = await _getNotificationSecret();
  return received == secret;
}

Future<Map<String, String>> _prepareNotificationHeaders() async => {
      'x-notification-secret': await _getNotificationSecret(),
      HttpHeaders.contentTypeHeader: 'application/json',
    };

Future notifyService(http.Client client, String servicePrefix, String package,
    String version) async {
  final uri = '$servicePrefix$apiNotificationEndpoint';
  final data = new _NotificationData(package, version);
  try {
    _logger.fine('Notification HTTP POST $uri with $data');
    final response = await client.post(uri,
        body: json.encode(data.toMap()),
        headers: await _prepareNotificationHeaders());
    if (response.statusCode != 200) {
      _logger.warning('Notification request on $uri with $data failed. '
          'Status code: ${response.statusCode}. '
          'Body: ${response.body}');
    }
  } catch (e) {
    _logger.severe('Notification request on $uri aborted: $e');
  }
}

/// Handles requests for: /api/notification
Future<shelf.Response> notificationHandler(shelf.Request request) async {
  final String requestMethod = request.method?.toUpperCase();
  if (requestMethod == 'POST' && await _validateNotificationSecret(request)) {
    try {
      final Map<String, dynamic> map =
          json.decode(await request.readAsString());
      final data = new _NotificationData.fromMap(map);
      if (data.isValid) {
        _logger.info('Received notification: $data');
        triggerTask(data.package, data.version);
        return jsonResponse({'success': true});
      } else {
        return jsonResponse({'success': false});
      }
    } catch (e, st) {
      _logger.warning('Error processing notification', e, st);
      return jsonResponse({'success': false});
    }
  }
  return jsonResponse({'success': false});
}
