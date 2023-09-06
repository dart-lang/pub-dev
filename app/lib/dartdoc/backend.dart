// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/task/backend.dart';

import '../shared/datastore.dart';

import 'models.dart';

/// Sets the dartdoc backend.
void registerDartdocBackend(DartdocBackend backend) =>
    ss.register(#_dartdocBackend, backend);

/// The active dartdoc backend.
DartdocBackend get dartdocBackend =>
    ss.lookup(#_dartdocBackend) as DartdocBackend;

class DartdocBackend {
  final DatastoreDB _db;
  DartdocBackend(this._db);

  /// Scan the Datastore for [DartdocRun]s and remove everything.
  Future<void> deleteDartdocRuns() async {
    final query = _db.query<DartdocRun>();
    await _db.deleteWithQuery(query);
  }

  /// Resolves the best version to display for a /documentation/[package]/[version]/
  /// request. Also resolves the best URL it should be displayed under, in case it
  /// needs a redirect.
  ///
  /// Returns empty version and URL segment when there is no displayable version found.
  Future<ResolvedDocUrlVersion> resolveDocUrlVersion(
      String package, String version) async {
    return await cache.resolvedDocUrlVersion(package, version).get(() async {
      // Keep the `/latest/` URL if the latest finished is the latest version,
      // otherwise redirect to the latest finished version.
      if (version == 'latest') {
        final latestFinished = await taskBackend.latestFinishedVersion(package);
        if (latestFinished == null) {
          return ResolvedDocUrlVersion(version: '', segment: '');
        }
        final latestVersion = await packageBackend.getLatestVersion(package);
        return ResolvedDocUrlVersion(
          version: latestFinished,
          segment: latestFinished == latestVersion ? 'latest' : latestFinished,
        );
      }

      // May redirect to /latest/ URL if the version is latest version and it has a finished analysis.
      final latestVersion = await packageBackend.getLatestVersion(package);
      if (version == latestVersion) {
        final latestFinished = await taskBackend.latestFinishedVersion(package);
        if (version == latestFinished) {
          return ResolvedDocUrlVersion(
            version: version,
            segment: 'latest',
          );
        }
      }

      // TODO: check if analysis finished for this version, redirect to closest version if possible

      // Default: keep the URL on the version that was provided.
      return ResolvedDocUrlVersion(
        version: version,
        segment: version,
      );
    }) as ResolvedDocUrlVersion;
  }
}
