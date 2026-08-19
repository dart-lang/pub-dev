// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/db.dart';
import 'package:gcloud/storage.dart';

import 'appengine_context.dart';
import 'logging.dart';

abstract class ClientContext {
  /// Whether the application is currently running in the development
  /// environment.
  bool get isDevelopmentEnvironment;

  /// Whether the application is currently running in the production
  /// environment.
  bool get isProductionEnvironment;

  Services get services;

  AppEngineContext get applicationContext;

  /// The `TRACE_ID` value from the `X-Cloud-Trace-Context` request header.
  ///
  /// If `X-Cloud-Trace-Context` was not included in the request, the value will
  /// be `null`.
  ///
  /// See https://cloud.google.com/trace/docs/support for details.
  String? get traceId;
}

class Services {
  final DatastoreDB db;
  final Storage storage;
  final Logging logging;

  Services(this.db, this.storage, this.logging);
}
