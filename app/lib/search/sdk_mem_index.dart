// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// ignore: implementation_imports
import 'package:pana/src/dartdoc/dartdoc_index.dart';
import 'package:path/path.dart' as p;

import '../shared/versions.dart' show toolStableDartSdkVersion;
import 'search_service.dart';
import 'token_index.dart';

export 'package:pana/src/dartdoc/dartdoc_index.dart';

/// In-memory index for SDK library search queries.
class SdkMemIndex {
  final String _sdk;
  final String? _version;
  final Uri _baseUri;
  final _tokensPerLibrary = <String, TokenIndex>{};
  final _baseUriPerLibrary = <String, String>{};
  final _descriptionPerLibrary = <String, String>{};
  final _libraryWeights = <String, double>{};
  final _apiPageDirWeights = <String, double>{};

  SdkMemIndex({
    required String sdk,
    required String? version,
    required Uri baseUri,
  })  : _sdk = sdk,
        _version = version,
        _baseUri = baseUri;

  factory SdkMemIndex.dart({String? version}) {
    version ??= toolStableDartSdkVersion;
    final branch = version.contains('beta') ? 'beta' : 'stable';
    return SdkMemIndex(
        sdk: 'dart',
        version: version,
        baseUri: Uri.parse('https://api.dart.dev/$branch/$version/'));
  }

  factory SdkMemIndex.flutter() {
    return SdkMemIndex(
      sdk: 'flutter',
      version: null,
      baseUri: Uri.parse('https://api.flutter.dev/flutter/'),
    );
  }

  Uri get baseUri => _baseUri;

  Future<void> addDartdocIndex(
    DartdocIndex index, {
    Set<String>? allowedLibraries,
  }) async {
    for (final f in index.entries) {
      final library = f.qualifiedName?.split('.').first;
      if (library == null) continue;
      if (f.href == null) continue;
      if (allowedLibraries != null &&
          allowedLibraries.isNotEmpty &&
          !allowedLibraries.contains(library)) {
        continue;
      }
      if (f.isLibrary) {
        _baseUriPerLibrary[library] = _baseUri.resolve(f.href!).toString();
      }
      final tokens = _tokensPerLibrary.putIfAbsent(library, () => TokenIndex());

      final text = f.qualifiedName?.replaceAll('.', ' ').replaceAll(':', ' ');
      tokens.add(f.href!, text);
    }
  }

  /// Adds the descriptions for each library.
  void addLibraryDescriptions(Map<String, String> descriptions) {
    _descriptionPerLibrary.addAll(descriptions);
  }

  /// Updates the non-default weight for libraries.
  void updateWeights({
    required Map<String, double> libraryWeights,
    required Map<String, double> apiPageDirWeights,
  }) {
    _libraryWeights.addAll(libraryWeights);
    _apiPageDirWeights.addAll(apiPageDirWeights);
  }

  List<SdkLibraryHit> search(
    String query, {
    int? limit,
  }) {
    limit ??= 2;
    final words = query.split(' ').where((e) => e.isNotEmpty).toList();
    if (words.isEmpty) return <SdkLibraryHit>[];

    final hits = <_Hit>[];
    for (final library in _tokensPerLibrary.keys) {
      // We may recude the rank of certain libraries, except when their name is
      // also part of the query. E.g. `dart:html` with `query=cursor` may be
      // scored lower than `query=html cursor`.
      final isQualifiedQuery = query.contains(library.split(':').last);

      final tokens = _tokensPerLibrary[library]!;
      final plainResults = tokens.searchWords(words).top(3, minValue: 0.05);
      if (plainResults.isEmpty) continue;

      final libraryWeight = _libraryWeights[library] ?? 1.0;
      final weightedResults = isQualifiedQuery
          ? plainResults
          : plainResults.map(
              (key, value) {
                final dir = p.dirname(key);
                final w = (_apiPageDirWeights[dir] ?? 1.0) * libraryWeight;
                return w * value;
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
              sdk: _sdk,
              version: _version,
              library: hit.library,
              description: _descriptionPerLibrary[hit.library],
              url: _baseUriPerLibrary[hit.library] ?? _baseUri.toString(),
              score: hit.score,
              apiPages: hit.top
                  .getValues()
                  .entries
                  .map(
                    (e) => ApiPageRef(
                      path: e.key,
                      url: _baseUri.resolve(e.key).toString(),
                    ),
                  )
                  .toList(),
            ))
        .toList();
  }
}

class _Hit {
  final String library;
  final Score top;

  _Hit(this.library, this.top);

  late final score = top.maxValue;
}
