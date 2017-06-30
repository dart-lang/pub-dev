// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart' as ss;

import '../frontend/models.dart';
import '../shared/mock_scores.dart';
import '../shared/search_service.dart';

/// Sets the backend service.
void registerSearchBackend(SearchBackend backend) =>
    ss.register(#_searchBackend, backend);

/// The active backend service.
SearchBackend get searchBackend => ss.lookup(#_searchBackend);

/// Datastore-related access methods for the search service
class SearchBackend {
  final DatastoreDB _db;

  SearchBackend(this._db);

  /// Loads the list of packages, their latest stable versions and returns a
  /// matching list of [PackageDocument] objects for search.
  /// When a package or its latest version is missing, the method returns with
  /// null at the given index.
  Future<List<PackageDocument>> loadDocuments(List<String> packageNames) async {
    final List<Key> packageKeys = packageNames
        .map((String name) => _db.emptyKey.append(Package, id: name))
        .toList();
    final List<Package> packages = await _db.lookup(packageKeys);

    // Load only for the existing packages.
    final List<Key> versionKeys = packages
        .where((p) => p != null)
        .map((p) => p.latestVersionKey)
        .toList();
    final List<PackageVersion> versionList = await _db.lookup(versionKeys);
    final Map<String, PackageVersion> versions = new Map.fromIterable(
        versionList.where((pv) => pv != null),
        key: (PackageVersion pv) => pv.package);

    final List<PackageDocument> results = new List(packages.length);
    for (int i = 0; i < packages.length; i++) {
      final Package p = packages[i];
      if (p == null) continue;
      final PackageVersion pv = versions[p.name];
      if (pv == null) continue;

      results[i] = new PackageDocument(
        url: _toUrl(pv.package),
        package: pv.package,
        version: pv.version,
        devVersion: p.latestDevVersion,
        detectedTypes: pv.detectedTypes,
        description: pv.pubspec.description,
        lastUpdated: pv.shortCreated,
        readme: pv.readmeContent,
        popularity: mockScores[pv.package] ?? 0.0,
      );
    }
    return results;
  }

  Stream<String> listPackages({DateTime updatedAfter}) {
    final Query q = _db.query(Package);
    if (updatedAfter != null) {
      q.filter('updated >=', updatedAfter);
    }
    return q.run().map((Model m) => (m as Package).name);
  }
}

String _toUrl(String package) => 'https://pub.dartlang.org/packages/$package';
