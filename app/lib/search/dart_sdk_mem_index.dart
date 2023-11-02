// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dartdoc_data/dartdoc_index.dart';

import 'backend.dart';
import 'sdk_mem_index.dart';

final _logger = Logger('search.dart_sdk_mem_index');

/// Results from these libraries are ranked with lower score and
/// will be displayed only if the query has the library name, or
/// there are not other results that could match the query.
@visibleForTesting
const dartSdkLibraryWeights = <String, double>{
  'dart:html': 0.7,
};

/// Sets the Dart SDK in-memory index.
void registerDartSdkMemIndex(SdkMemIndex? index) {
  if (index != null) {
    ss.register(#_dartSdkMemIndex, index);
  }
}

/// The active Dart SDK in-memory index.
SdkMemIndex? get dartSdkMemIndex =>
    ss.lookup(#_dartSdkMemIndex) as SdkMemIndex?;

/// Tries to load Dart SDK's dartdoc `index.json` and build
/// a search index from it.
///
/// Returns `null` when the loading of `index.json` failed, or when there
/// was an error parsing the faile or building the index.
Future<SdkMemIndex?> createDartSdkMemIndex() async {
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
