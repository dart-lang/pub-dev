// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
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

class IndexUpdater {
  final DatastoreDB _db;
  final InMemoryPackageIndex _packageIndex;

  IndexUpdater(this._db, this._packageIndex);

  /// Loads the package index snapshot, or if it fails, creates a minimal
  /// package index with only package names and minimal information.
  Future<void> init() async {
    final isReady = await _initSnapshot();
    if (!isReady) {
      _logger.info('Loading minimum package index...');
      final documents = await searchBackend.loadMinimumPackageIndex().toList();
      _packageIndex.addPackages(documents);
      _logger.info(
          'Minimum package index loaded with ${documents.length} packages.');
    }
  }

  /// Updates all packages in the index.
  /// It is slower than searchBackend.loadMinimum_packageIndex, but provides a
  /// complete document for the index.
  @visibleForTesting
  Future<void> updateAllPackages() async {
    final documents = <PackageDocument>[];
    await for (final p in _db.query<Package>().run()) {
      final doc = await searchBackend.loadDocument(p.name!);
      documents.add(doc);
    }
    _packageIndex.addPackages(documents);
  }

  /// Returns whether the snapshot was initialized and loaded properly.
  Future<bool> _initSnapshot() async {
    try {
      _logger.info('Loading snapshot...');
      final documents = await searchBackend.fetchSnapshotDocuments();
      if (documents == null) {
        return false;
      }
      _packageIndex.addPackages(documents);
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
