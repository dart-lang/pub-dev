// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

import '../package/models.dart' show Package;
import '../shared/datastore.dart';
import '../shared/exceptions.dart';

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
      int cnt = 0;
      await for (final pd in searchBackend.loadMinimumPackageIndex()) {
        await _packageIndex.addPackage(pd);
        cnt++;
        if (cnt % 500 == 0) {
          _logger.info('Loaded $cnt minimum package data (${pd.package})');
        }
      }
      await _packageIndex.markReady();
      _logger.info('Minimum package index loaded with $cnt packages.');
    }
  }

  /// Updates all packages in the index.
  /// It is slower than searchBackend.loadMinimum_packageIndex, but provides a
  /// complete document for the index.
  @visibleForTesting
  Future<void> updateAllPackages() async {
    await for (final p in _db.query<Package>().run()) {
      try {
        final doc = await searchBackend.loadDocument(p.name!);
        await _packageIndex.addPackage(doc);
      } on RemovedPackageException catch (_) {
        await _packageIndex.removePackage(p.name!);
      }
    }
    await _packageIndex.markReady();
  }

  /// Returns whether the snapshot was initialized and loaded properly.
  Future<bool> _initSnapshot() async {
    try {
      _logger.info('Loading snapshot...');
      final documents = await searchBackend.fetchSnapshotDocuments();
      if (documents == null) {
        return false;
      }
      await _packageIndex.addPackages(documents);
      // Arbitrary sanity check that the snapshot is not entirely bogus.
      // Index merge will enable search.
      if (documents.length > 10) {
        _logger.info('Merging index after snapshot.');
        await _packageIndex.markReady();
        _logger.info('Snapshot load completed.');
        return true;
      }
    } catch (e, st) {
      _logger.warning('Error while fetching snapshot.', e, st);
    }
    return false;
  }
}
