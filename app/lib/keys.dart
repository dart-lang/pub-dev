// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library pub_dartlang_org.appengine_repository.keys;

import 'dart:async';

import 'package:gcloud/db.dart';

import 'models.dart';

/// Uses the datastore API in the current service scope to retrieve custom
/// search API Key.
Future<String> customSearchKeyFromDB() async {
  var db = dbService;

  var privateKeyKey = db.emptyKey.append(PrivateKey, id: 'api');
  PrivateKey apiKey = (await db.lookup([privateKeyKey])).first;

  if (apiKey == null) {
    throw new Exception('Could not find Custom search API key in DB.');
  }

  return apiKey.value;
}
