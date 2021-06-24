// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:retry/retry.dart';

import '../shared/cached_value.dart';
import 'models.dart';
import 'sdk_mem_index.dart';
import 'search_service.dart';

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

final _logger = Logger('search.flutter_sdk_mem_index');

/// Sets the Flutter SDK in-memory index.
void registerFlutterSdkMemIndex(FlutterSdkMemIndex updater) =>
    ss.register(#_flutterSdkMemIndex, updater);

/// The active Flutter SDK in-memory index.
FlutterSdkMemIndex get flutterSdkMemIndex =>
    ss.lookup(#_flutterSdkMemIndex) as FlutterSdkMemIndex;

/// Flutter SDK in-memory index that fetches `index.json` from
/// api.flutter.dev and returns search results based on [SdkMemIndex].
class FlutterSdkMemIndex {
  final _index = CachedValue<SdkMemIndex>(
    name: 'flutter-sdk-index',
    interval: Duration(days: 1),
    maxAge: Duration(days: 30),
    timeout: Duration(hours: 1),
    updateFn: _createFlutterSdkMemIndex,
  );

  Future<void> start() async {
    await _index.start();
  }

  Future<void> close() async {
    await _index.close();
  }

  Future<List<SdkLibraryHit>> search(String query, {int? limit}) async {
    if (!_index.isAvailable) return <SdkLibraryHit>[];
    return await _index.value!.search(query, limit: limit);
  }
}

Future<SdkMemIndex?> _createFlutterSdkMemIndex() async {
  try {
    return await retry(
      () async {
        final index = SdkMemIndex.flutter();
        final uri = index.baseUri.resolve('index.json');
        final rs = await http.get(uri);
        if (rs.statusCode != 200) {
          throw Exception('Unexpected status code for $uri: ${rs.statusCode}');
        }
        final content = DartdocIndex.parseJsonText(rs.body);
        await index.addDartdocIndex(content,
            allowedLibraries: _allowedLibraries);
        return index;
      },
      maxAttempts: 3,
    );
  } catch (e, st) {
    _logger.warning('Unable to load Flutter SDK index.', e, st);
    return null;
  }
}
