// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:pub_dev/shared/redis_cache.dart';

import '../package/backend.dart';
import '../task/backend.dart';
import 'models.dart';

/// Sets the dartdoc backend.
void registerDartdocBackend(DartdocBackend backend) =>
    ss.register(#_dartdocBackend, backend);

/// The active dartdoc backend.
DartdocBackend get dartdocBackend =>
    ss.lookup(#_dartdocBackend) as DartdocBackend;

class DartdocBackend {
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
          return ResolvedDocUrlVersion.empty();
        }
        final latestVersion = await packageBackend.getLatestVersion(package);
        return ResolvedDocUrlVersion(
          version: latestFinished,
          urlSegment:
              latestFinished == latestVersion ? 'latest' : latestFinished,
        );
      }

      // Do not resolve if package version does not exists.
      final pv = await packageBackend.lookupPackageVersion(package, version);
      if (pv == null) {
        return ResolvedDocUrlVersion.empty();
      }

      // Select the closest version (may be the same as version) that has a finished analysis.
      final closest =
          await taskBackend.closestFinishedVersion(package, version);
      return ResolvedDocUrlVersion(
        version: closest ?? version,
        urlSegment: closest ?? version,
      );
    }) as ResolvedDocUrlVersion;
  }
}
