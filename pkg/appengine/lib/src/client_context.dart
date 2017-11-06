// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library appengine.client_context;

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';
import 'package:memcache/memcache.dart';

import 'logging.dart';

abstract class ClientContext {
  /// Whether the application is currently running in the development
  /// environment.
  bool get isDevelopmentEnvironment;
  /// Whether the application is currently running in the production
  /// environment.
  bool get isProductionEnvironment;

  Services get services;
  Assets get assets;
}

class Services {
  final DatastoreDB db;
  final Storage storage;
  final Logging logging;
  final Memcache memcache;

  Services(this.db, this.storage, this.logging,this.memcache);
}

class AssetError implements Exception {
  final String message;

  AssetError(this.message);

  String toString() => "AssetError: $message";
}

abstract class Assets {
  /**
   * Read an asset. If [path] is not specified the path
   * from the active request is used.
   */
  Future<Stream<List<int>>> read([String path]);

  /**
   * Serve a asset to the active response. If [path]
   * is not specified the path from the active request is used.
   */
  void serve([String path]);
}
