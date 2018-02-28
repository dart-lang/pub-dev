// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pool/pool.dart';

import '../dartdoc/dartdoc_runner.dart' show statusFilePath;
import '../dartdoc/models.dart' show DartdocEntry;

import 'configuration.dart';
import 'notification.dart' show notifyService;

export '../dartdoc/models.dart' show DartdocEntry;

final Logger _logger = new Logger('dartdoc.client');

/// Sets the dartdoc client.
void registerDartdocClient(DartdocClient client) =>
    ss.register(#_dartdocClient, client);

/// The active dartdoc client.
DartdocClient get dartdocClient => ss.lookup(#_dartdocClient);

/// Client methods that access the dartdoc service.
class DartdocClient {
  final http.Client _client = new http.Client();
  String get _dartdocServiceHttpHostPort =>
      activeConfiguration.dartdocServicePrefix;

  Future<List<DartdocEntry>> getEntries(
      String package, List<String> versions) async {
    final resultFutures = <Future<DartdocEntry>>[];
    final pool = new Pool(4); // concurrent requests
    for (String version in versions) {
      final future = pool.withResource(() => _getEntry(package, version));
      resultFutures.add(future);
    }
    return await Future.wait(resultFutures);
  }

  Future triggerDartdoc(
      String package, String version, Set<String> dependentPackages) async {
    await notifyService(_client, _dartdocServiceHttpHostPort, package, version);

    for (final String package in dependentPackages) {
      await notifyService(_client, _dartdocServiceHttpHostPort, package, null);
    }
  }

  Future close() async {
    _client.close();
  }

  Future<DartdocEntry> _getEntry(String package, String version) async {
    final url =
        '$_dartdocServiceHttpHostPort/documentation/$package/$version/$statusFilePath';
    try {
      final rs = await _client.get(url);
      if (rs.statusCode != 200) return null;
      return new DartdocEntry.fromBytes(rs.bodyBytes);
    } catch (e) {
      _logger.info('Error requesting entry for: $package $version');
    }
    return null;
  }
}
