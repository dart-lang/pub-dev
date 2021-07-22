// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;

import '../job/backend.dart';

/// Sets the analyzer client.
void registerAnalyzerClient(AnalyzerClient client) =>
    ss.register(#_analyzerClient, client);

/// The active analyzer client.
AnalyzerClient get analyzerClient =>
    ss.lookup(#_analyzerClient) as AnalyzerClient;

/// Client methods that access the analyzer service.
class AnalyzerClient {
  Future<void> triggerAnalysis(
    String package,
    String? version,
    Set<String> dependentPackages, {
    bool isHighPriority = false,
  }) async {
    await jobBackend.trigger(
      JobService.analyzer,
      package,
      version: version,
      isHighPriority: isHighPriority,
    );
    // dependent packages are triggered with default priority
    for (final String package in dependentPackages) {
      await jobBackend.trigger(JobService.analyzer, package);
    }
  }
}
