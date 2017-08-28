// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.appengine_repository.keys;

import 'dart:async';

import 'package:gcloud/db.dart';

import 'models.dart';

const String notificationSecretKey = 'notification-secret';

/// Uses the datastore API in the current service scope to retrieve custom
/// search API Key.
Future<String> customSearchKeyFromDB() async {
  final db = dbService;

  final privateKeyKey = db.emptyKey.append(PrivateKey, id: 'api');
  final PrivateKey apiKey = (await db.lookup([privateKeyKey])).first;

  if (apiKey == null) {
    throw new Exception('Could not find Custom search API key in DB.');
  }

  return apiKey.value;
}

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
