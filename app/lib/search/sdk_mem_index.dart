// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:meta/meta.dart';
// ignore: implementation_imports
import 'package:pana/src/dartdoc/dartdoc_index.dart';
import 'package:path/path.dart' as p;

import '../shared/versions.dart';
import 'search_service.dart';
import 'token_index.dart';

export 'package:pana/src/dartdoc/dartdoc_index.dart';

/// In-memory index for SDK library search queries.
class SdkMemIndex {
  final String _sdk;
  final String? _version;
  final Uri _baseUri;
  final _tokensPerLibrary = <String, TokenIndex<String>>{};
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

  static Future<SdkMemIndex> dart() async {
    return SdkMemIndex(
      sdk: 'dart',
      version: runtimeSdkVersion,
      baseUri: Uri.parse('https://api.dart.dev/stable/latest/'),
    );
  }

  factory SdkMemIndex.flutter() {
    return SdkMemIndex(
      sdk: 'flutter',
      version: null,
      baseUri: Uri.parse('https://api.flutter.dev/flutter/'),
    );
  }

  late final indexJsonUri = _baseUri.resolve('index.json');

  Future<void> addDartdocIndex(
    DartdocIndex index, {
    Set<String>? allowedLibraries,
  }) async {
    final textsPerLibrary = <String, Map<String, String>>{};
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

        final desc = f.desc?.replaceAll(RegExp(r'\s+'), ' ').trim();
        if (desc != null && desc.isNotEmpty) {
          _descriptionPerLibrary[library] = desc;
        }
      }

      final text = f.qualifiedName?.replaceAll('.', ' ').replaceAll(':', ' ');
      if (text != null && text.isNotEmpty) {
        final texts = textsPerLibrary.putIfAbsent(library, () => {});
        texts[f.href!] = text;
      }
    }
    for (final e in textsPerLibrary.entries) {
      _tokensPerLibrary[e.key] = TokenIndex.fromMap(e.value);
    }
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
      // We may reduce the rank of certain libraries, except when their name is
      // also part of the query. E.g. `dart:html` with `query=cursor` may be
      // scored lower than `query=html cursor`.
      final isQualifiedQuery = query.contains(library.split(':').last);

      final tokens = _tokensPerLibrary[library]!;
      final plainResults = tokens.withSearchWords(
          words, (score) => score.top(3, minValue: 0.05));
      if (plainResults.isEmpty) continue;

      final libraryWeight = _libraryWeights[library] ?? 1.0;
      final weightedResults = isQualifiedQuery
          ? plainResults
          : plainResults.map(
              (key, value) {
                final dir = p.dirname(key);
                final w = (_apiPageDirWeights[dir] ?? 1.0) * libraryWeight;
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
              sdk: _sdk,
              version: _version,
              library: hit.library,
              description: _descriptionPerLibrary[hit.library],
              url: _baseUriPerLibrary[hit.library] ?? _baseUri.toString(),
              score: hit.score,
              apiPages: hit.top.entries
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

  @visibleForTesting
  String? getLibraryDescription(String library) =>
      _descriptionPerLibrary[library];
}

class _Hit {
  final String library;
  final Map<String, double> top;

  _Hit(this.library, this.top);

  late final score = top.values.fold(0.0, (a, b) => max(a, b));
}
