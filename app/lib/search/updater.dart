// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/db.dart';
import 'package:logging/logging.dart';

import '../frontend/models.dart';
import '../shared/mock_scores.dart';
import '../shared/search_service.dart';
import '../shared/utils.dart' show sliceList;

Logger _logger = new Logger('pub.search.updater');

class PackageIndexUpdater {
  final PackageIndex index;
  Timer _timer;
  bool _updating = false;

  PackageIndexUpdater(this.index);

  Future update({int limit}) async {
    if (_updating) {
      _logger.warning('Update called before previous round completed.');
      return;
    }
    try {
      _updating = true;
      await _doUpdate(limit);
    } catch (e, st) {
      _logger.severe('Error while updating search index.', e, st);
    } finally {
      _updating = false;
    }
  }

  Future _doUpdate(int limit) async {
    final List<Key> versionKeys = [];
    final Map<String, String> devVersions = {};

    _logger.info('Polling packages for changes.');
    int count = 0;
    await for (Package p in dbService.query(Package).run()) {
      final bool inIndex = await index.contains(
          _toUrl(p.name), p.latestVersion, p.latestDevVersion);
      if (inIndex) continue;
      versionKeys.add(p.latestVersionKey);
      devVersions[p.name] = p.latestDevVersion;
      count++;
      if (limit != null && limit <= count) break;
    }
    _logger.info('Found ${versionKeys.length} packages to update.');
    if (versionKeys.isEmpty) return;

    for (List<Key> slices in sliceList(versionKeys, 20)) {
      final Key firstKey = slices.first;
      final String firstPkg = firstKey.parent.id;
      final String firstVersion = firstKey.id;
      _logger.info('Updating packages staring with $firstPkg $firstVersion');
      final List<PackageVersion> versions = await dbService.lookup(slices);
      final List<PackageDocument> documents = versions
          .map((pv) => new PackageDocument(
                url: _toUrl(pv.package),
                package: pv.package,
                version: pv.version,
                devVersion: devVersions[pv.package],
                detectedTypes: pv.detectedTypes,
                description: pv.pubspec.description,
                lastUpdated: pv.shortCreated,
                readme: pv.readmeContent,
                popularity: mockScores[pv.package] ?? 0.0,
              ))
          .toList();
      await index.addAll(documents);
      _logger.info('Updated ${slices.length} packages.');
    }

    _logger.info('Calling index.merge() ...');
    await index.merge();
    _logger.info('index.merge() completed.');
  }

  void startPolling() {
    if (_timer == null) {
      _timer = new Timer.periodic(new Duration(hours: 4), (_) {
        update();
      });
      update();
    }
  }
}

String _toUrl(String package) => 'https://pub.dartlang.org/packages/$package';
