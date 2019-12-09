// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import '../dartdoc/backend.dart';
import '../dartdoc/models.dart' show DartdocEntry;
import '../job/backend.dart';

final Logger _logger = Logger('dartdoc.client');

/// Sets the dartdoc client.
void registerDartdocClient(DartdocClient client) =>
    ss.register(#_dartdocClient, client);

/// The active dartdoc client.
DartdocClient get dartdocClient => ss.lookup(#_dartdocClient) as DartdocClient;

/// Client methods that access the dartdoc service.
class DartdocClient {
  Future<List<DartdocEntry>> getEntries(
      String package, List<String> versions) async {
    final resultFutures = <Future<DartdocEntry>>[];
    final pool = Pool(4); // concurrent requests
    for (String version in versions) {
      final future = pool.withResource(() => getEntry(package, version));
      resultFutures.add(future);
    }
    return await Future.wait(resultFutures);
  }

  Future<void> triggerDartdoc(
    String package,
    String version,
    Set<String> dependentPackages, {
    bool isHighPriority = false,
  }) async {
    await jobBackend.trigger(
      JobService.dartdoc,
      package,
      version: version,
      isHighPriority: isHighPriority,
    );
    // dependent packages are triggered with default priority
    for (final String package in dependentPackages) {
      await jobBackend.trigger(JobService.dartdoc, package);
    }
  }

  Future<void> close() async {
    // no-op
  }

  Future<String> getTextContent(
      String package, String version, String relativePath,
      {Duration timeout}) async {
    try {
      final entry = await dartdocBackend
          .getServingEntry(package, version)
          .timeout(timeout);
      if (entry == null || !entry.hasContent) {
        return null;
      }
      return await dartdocBackend
          .getTextContent(entry, relativePath)
          .timeout(timeout);
    } catch (e, st) {
      _logger.info(
          'Unable to read content for $package $version $relativePath', e, st);
    }
    return null;
  }

  Future<DartdocEntry> getEntry(String package, String version) async {
    return await dartdocBackend.getServingEntry(package, version);
  }
}
