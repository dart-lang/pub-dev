// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/utils/http.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/package/overrides.dart';
import 'package:pub_dev/search/models.dart';
import 'package:pub_dev/search/search_service.dart';

import '../package/models.dart' show Package;
import '../shared/datastore.dart';

import 'backend.dart';
import 'mem_index.dart';

final Logger _logger = Logger('pub.search.updater');

/// Sets the index updater.
void registerIndexUpdater(IndexUpdater updater) =>
    ss.register(#_indexUpdater, updater);

/// The active index updater.
IndexUpdater get indexUpdater => ss.lookup(#_indexUpdater) as IndexUpdater;

/// Loads a search snapshot from an URL or from a local file and builds
/// an in-memory package index from it.
Future<InMemoryPackageIndex> loadInMemoryPackageIndexFromUrl(String url) async {
  late String textContent;
  if (url.startsWith('http://') || url.startsWith('https://')) {
    textContent = await httpGetWithRetry(
      Uri.parse(url),
      responseFn: (rs) => rs.body,
    );
  } else {
    final file = File(url);
    textContent = utf8.decode(gzip.decode(await file.readAsBytes()));
  }
  final content = json.decode(textContent) as Map<String, Object?>;
  final snapshot = SearchSnapshot.fromJson(content);
  return InMemoryPackageIndex(
    documents: snapshot.documents!.values.where(
      (d) => !isSdkPackage(d.package),
    ),
  );
}

/// Saves the provided [documents] into a local search snapshot file.
Future<void> saveInMemoryPackageIndexToFile(
  Iterable<PackageDocument> documents,
  String path,
) async {
  final file = File(path);
  final snapshot = SearchSnapshot();
  for (final doc in documents) {
    snapshot.add(doc);
  }
  await file.writeAsBytes(
    gzip.encode(utf8.encode(json.encode(snapshot.toJson()))),
  );
}

class IndexUpdater {
  final DatastoreDB _db;

  IndexUpdater(this._db);

  /// Loads the package index snapshot, or if it fails, creates a minimal
  /// package index with only package names and minimal information.
  Future<void> init() async {
    final isReady = await _initSnapshot();
    if (!isReady) {
      _logger.info('Loading minimum package index...');
      final documents = await searchBackend.loadMinimumPackageIndex().toList();
      updatePackageIndex(InMemoryPackageIndex(documents: documents));
      _logger.info(
        'Minimum package index loaded with ${documents.length} packages.',
      );
    }
  }

  /// Updates all packages in the index.
  /// It is slower than searchBackend.loadMinimum_packageIndex, but provides a
  /// complete document for the index.
  @visibleForTesting
  Future<void> updateAllPackages() async {
    final documents = await loadAllPackageDocuments();
    updatePackageIndex(InMemoryPackageIndex(documents: documents));
  }

  /// Loads all packages as PackageDocuments.
  @visibleForTesting
  Future<List<PackageDocument>> loadAllPackageDocuments() async {
    final documents = <PackageDocument>[];
    await for (final p in _db.query<Package>().run()) {
      final doc = await searchBackend.loadDocument(p.name!);
      documents.add(doc);
    }
    return documents;
  }

  /// Returns whether the snapshot was initialized and loaded properly.
  Future<bool> _initSnapshot() async {
    try {
      _logger.info('Loading snapshot...');
      final documents = await searchBackend.fetchSnapshotDocuments();
      if (documents == null) {
        return false;
      }
      updatePackageIndex(InMemoryPackageIndex(documents: documents));
      // Arbitrary sanity check that the snapshot is not entirely bogus.
      // Index merge will enable search.
      if (documents.length > 10) {
        _logger.info('Snapshot load completed.');
        return true;
      }
    } catch (e, st) {
      _logger.warning('Error while fetching snapshot.', e, st);
    }
    return false;
  }
}
