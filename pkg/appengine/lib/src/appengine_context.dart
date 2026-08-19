// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

class AppEngineContext {
  final String applicationID;
  final String partition;
  final String version;
  final String module;
  final String instance;
  final String? instanceId;
  final bool isDevelopmentEnvironment;

  AppEngineContext(
      this.isDevelopmentEnvironment,
      this.applicationID,
      this.version,
      this.module,
      this.instance,
      this.instanceId,
      Uri? pubServeUrl)
      : partition = '';

  String get fullQualifiedApplicationId => '$partition~$applicationID';
}
