// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:pub_dartdoc_data/dartdoc_index.dart';

import 'backend.dart';
import 'sdk_mem_index.dart';

/// The index.json file contains overlap with the Dart SDK and also repeats
/// regular packages. The selected libraries are unique to the index.json.
///
/// TODO: try to find a way to derive this list automatically.
const _allowedLibraries = <String>{
  'dart:ui',
  'animation',
  'cupertino',
  'foundation',
  'gestures',
  'material',
  'painting',
  'physics',
  'rendering',
  'scheduler',
  'semantics',
  'services',
  'widgets',
  'flutter_test',
  'flutter_driver',
  'flutter_driver_extension',
  'flutter_web_plugins',
};

const _flutterApiPageDirWeights = <String, double>{
  'cupertino/CupertinoIcons': 0.7,
  'material/Icons': 0.7,
};

final _logger = Logger('search.flutter_sdk_mem_index');

/// Sets the Flutter SDK in-memory index.
void registerFlutterSdkMemIndex(SdkMemIndex? index) {
  if (index != null) {
    ss.register(#_flutterSdkMemIndex, index);
  }
}

/// The active Flutter SDK in-memory index.
SdkMemIndex? get flutterSdkMemIndex =>
    ss.lookup(#_flutterSdkMemIndex) as SdkMemIndex?;

/// Creates Flutter SDK in-memory index that fetches `index.json` from
/// api.flutter.dev and returns search results based on [SdkMemIndex].
Future<SdkMemIndex?> createFlutterSdkMemIndex() async {
  try {
    final index = SdkMemIndex.flutter();
    final content = DartdocIndex.parseJsonText(
      await searchBackend.fetchSdkIndexContentAsString(
        baseUri: index.baseUri,
        relativePath: 'index.json',
      ),
    );
    await index.addDartdocIndex(content, allowedLibraries: _allowedLibraries);
    index.addLibraryDescriptions(
      await searchBackend.fetchSdkLibraryDescriptions(
        baseUri: index.baseUri,
        libraryRelativeUrls: content.libraryRelativeUrls,
      ),
    );
    index.updateWeights(
      libraryWeights: {},
      apiPageDirWeights: _flutterApiPageDirWeights,
    );
    return index;
  } catch (e, st) {
    _logger.warning('Unable to load Flutter SDK index.', e, st);
    return null;
  }
}
