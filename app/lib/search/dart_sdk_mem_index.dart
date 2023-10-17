// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dartdoc_data/dartdoc_index.dart';

import '../shared/cached_value.dart';
import 'backend.dart';
import 'sdk_mem_index.dart';
import 'search_service.dart';

final _logger = Logger('search.dart_sdk_mem_index');

/// Results from these libraries are ranked with lower score and
/// will be displayed only if the query has the library name, or
/// there are not other results that could match the query.
@visibleForTesting
const dartSdkLibraryWeights = <String, double>{
  'dart:html': 0.7,
};

/// Sets the Dart SDK in-memory index.
void registerDartSdkMemIndex(DartSdkMemIndex updater) =>
    ss.register(#_dartSdkMemIndex, updater);

/// The active Dart SDK in-memory index.
DartSdkMemIndex get dartSdkMemIndex =>
    ss.lookup(#_dartSdkMemIndex) as DartSdkMemIndex;

/// Dart SDK in-memory index that fetches `index.json` from
/// api.dart.dev and returns search results based on [SdkMemIndex].
class DartSdkMemIndex {
  final _index = CachedValue<SdkMemIndex>(
    name: 'dart-sdk-index',
    interval: Duration(days: 1),
    maxAge: Duration(days: 30),
    timeout: Duration(hours: 1),
    updateFn: _createDartSdkMemIndex,
  );

  Future<void> start() async {
    await _index.start();
  }

  Future<void> close() async {
    await _index.close();
  }

  List<SdkLibraryHit> search(String query, {int? limit}) {
    if (!_index.isAvailable) return <SdkLibraryHit>[];
    return _index.value!.search(query, limit: limit);
  }

  @visibleForTesting
  void setDartdocIndex(DartdocIndex index, {String? version}) {
    final smi = SdkMemIndex.dart(version: version);
    smi.addDartdocIndex(index);
    // ignore: invalid_use_of_visible_for_testing_member
    _index.setValue(smi);
  }
}

Future<SdkMemIndex?> _createDartSdkMemIndex() async {
  try {
    final index = SdkMemIndex.dart();
    final content = DartdocIndex.parseJsonText(
      await searchBackend.fetchSdkIndexContentAsString(
        baseUri: index.baseUri,
        relativePath: 'index.json',
      ),
    );
    await index.addDartdocIndex(content);
    index.addLibraryDescriptions(
      await searchBackend.fetchSdkLibraryDescriptions(
        baseUri: index.baseUri,
        libraryRelativeUrls: content.libraryRelativeUrls,
      ),
    );
    index.updateWeights(
      libraryWeights: dartSdkLibraryWeights,
      apiPageDirWeights: {},
    );
    return index;
  } catch (e, st) {
    _logger.warning('Unable to load Dart SDK index.', e, st);
    return null;
  }
}
