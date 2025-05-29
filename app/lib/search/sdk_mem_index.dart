// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
// ignore: implementation_imports
import 'package:pana/src/dartdoc/dartdoc_index.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/search/backend.dart';

import 'search_service.dart';
import 'token_index.dart';

export 'package:pana/src/dartdoc/dartdoc_index.dart';

/// Sets the SDK index.
void registerSdkIndex(SdkIndex? index) {
  if (index != null) {
    ss.register(#_sdkIndex, index);
  }
}

/// The active SDK in-memory index.
SdkIndex? get sdkIndex => ss.lookup(#_sdkIndex) as SdkIndex?;

/// Results from these libraries are ranked with lower score and
/// will be displayed only if the query has the library name, or
/// there are not other results that could match the query.
const _libraryWeights = {
  'dart:html': 0.7,
};

/// Results from these API pages are ranked with lower score and
/// will be displayed only if the query has the library and the page
/// name, or there are not other results that could match the query.
const _defaultApiPageDirWeights = {
  'cupertino/CupertinoIcons': 0.25,
  'material/Icons': 0.25,
};

final _logger = Logger('search.dart_sdk_mem_index');
final _dartUri = Uri.parse('https://api.dart.dev/stable/latest/');
final _flutterUri = Uri.parse('https://api.flutter.dev/flutter/');

/// Tries to load Dart and Flutter SDK's dartdoc `index.json` and build
/// a search index from it.
///
/// Returns `null` when the loading of `index.json` failed, or when there
/// was an error parsing the file or building the index.
Future<SdkMemIndex?> createSdkMemIndex() async {
  try {
    final dartSdkContent =
        await loadOrFetchSdkIndexJsonAsString(SdkMemIndex.dartSdkIndexJsonUri);
    final flutterSdkContent = await loadOrFetchSdkIndexJsonAsString(
        SdkMemIndex._flutterSdkIndexJsonUri);
    return SdkMemIndex(
      dartIndex: DartdocIndex.parseJsonText(dartSdkContent),
      flutterIndex: DartdocIndex.parseJsonText(flutterSdkContent),
    );
  } catch (e, st) {
    _logger.warning('Unable to load SDK index.', e, st);
    return null;
  }
}

/// Defines the general interface for the SDK index.
// ignore: one_member_abstracts
abstract class SdkIndex {
  FutureOr<List<SdkLibraryHit>> search(
    String query, {
    int? limit,
    bool skipFlutter = false,
  });
}

/// In-memory index for SDK library search queries.
class SdkMemIndex implements SdkIndex {
  final _libraries = <String, _Library>{};
  final Map<String, double> _apiPageDirWeights;

  SdkMemIndex({
    required DartdocIndex dartIndex,
    required DartdocIndex flutterIndex,
    Map<String, double>? apiPageDirWeights,
  }) : _apiPageDirWeights = apiPageDirWeights ?? _defaultApiPageDirWeights {
    _addDartdocIndex('dart', _dartUri, dartIndex);
    _addDartdocIndex('flutter', _flutterUri, flutterIndex);
  }

  static final dartSdkIndexJsonUri =
      Uri.parse('https://api.dart.dev/stable/latest/index.json');
  static final _flutterSdkIndexJsonUri =
      Uri.parse('https://api.flutter.dev/flutter/index.json');

  void _addDartdocIndex(
    String sdk,
    Uri baseUri,
    DartdocIndex index,
  ) {
    final textsPerLibrary = <String, Map<String, String>>{};
    final baseUris = <String, Uri>{};
    final descriptions = <String, String>{};

    for (final f in index.entries) {
      final library = f.qualifiedName?.split('.').first;
      if (library == null) continue;
      if (f.href == null) continue;
      if (_libraries.containsKey(library)) continue;
      if (f.isLibrary) {
        baseUris[library] = baseUri.resolve(f.href!);

        final desc = f.desc?.replaceAll(RegExp(r'\s+'), ' ').trim();
        if (desc != null && desc.isNotEmpty) {
          descriptions[library] = desc;
        }
      }

      final text = f.qualifiedName?.replaceAll('.', ' ').replaceAll(':', ' ');
      if (text != null && text.isNotEmpty) {
        final texts = textsPerLibrary.putIfAbsent(library, () => {});
        texts[f.href!] = text;
      }
    }
    for (final e in textsPerLibrary.entries) {
      _libraries[e.key] = _Library(
        sdk: sdk,
        sdkBaseUri: baseUri,
        name: e.key,
        libraryUrl: (baseUris[e.key] ?? baseUri).toString(),
        description: descriptions[e.key],
        tokenIndex: TokenIndex.fromMap(e.value),
      );
    }
  }

  @override
  List<SdkLibraryHit> search(
    String query, {
    int? limit,
    bool skipFlutter = false,
  }) {
    limit ??= 2;
    final words = query.split(' ').where((e) => e.isNotEmpty).toList();
    if (words.isEmpty) return <SdkLibraryHit>[];

    final hits = <_Hit>[];
    for (final library in _libraries.values) {
      if (skipFlutter && library.isFlutter) continue;
      // We may reduce the rank of certain libraries, except when their name is
      // also part of the query. E.g. `dart:html` with `query=cursor` may be
      // scored lower than `query=html cursor`.
      final isQualifiedQuery = query.contains(library.lastNamePart);

      final plainResults = library.tokenIndex
          .withSearchWords(words, (score) => score.top(3, minValue: 0.05));
      if (plainResults.isEmpty) continue;

      final weightedResults = isQualifiedQuery
          ? plainResults
          : plainResults.map(
              (key, value) {
                final dir = p.dirname(key);
                final w = (_apiPageDirWeights[dir] ?? 1.0) * library.weight;
                return MapEntry(key, w * value);
              },
            );

      final hit = _Hit(library, weightedResults);
      if (hit.score > 0.25) {
        hits.add(hit);
      }
    }
    if (hits.isEmpty) return <SdkLibraryHit>[];

    hits.sort((a, b) => -a.score.compareTo(b.score));
    final bestScore = hits.first.score;
    final minScore = bestScore * 0.8;
    return hits
        .take(limit)
        .where((h) => h.score >= minScore)
        .map((hit) => SdkLibraryHit(
              sdk: hit.library.sdk,
              library: hit.library.name,
              description: hit.library.description,
              url: hit.library.libraryUrl,
              score: hit.score,
              apiPages: hit.top.entries
                  .map(
                    (e) => ApiPageRef(
                      path: e.key,
                      url: hit.library.sdkBaseUri.resolve(e.key).toString(),
                    ),
                  )
                  .toList(),
            ))
        .toList();
  }
}

class _Hit {
  final _Library library;
  final Map<String, double> top;

  _Hit(this.library, this.top);

  late final score = top.values.fold(0.0, (a, b) => max(a, b));
}

class _Library {
  final String sdk;
  final Uri sdkBaseUri;
  final String name;
  final String libraryUrl;
  final String? description;
  final TokenIndex<String> tokenIndex;

  _Library({
    required this.sdk,
    required this.sdkBaseUri,
    required this.name,
    required this.libraryUrl,
    required this.description,
    required this.tokenIndex,
  });

  late final isFlutter = sdk == 'flutter';
  late final weight = _libraryWeights[name] ?? 1.0;
  late final lastNamePart = name.split(':').last;
}
