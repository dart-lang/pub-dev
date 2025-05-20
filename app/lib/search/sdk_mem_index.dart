// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:meta/meta.dart';
// ignore: implementation_imports
import 'package:pana/src/dartdoc/dartdoc_index.dart';
import 'package:path/path.dart' as p;
import 'package:pub_dev/search/flutter_sdk_mem_index.dart';

import 'search_service.dart';
import 'token_index.dart';

export 'package:pana/src/dartdoc/dartdoc_index.dart';

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

/// In-memory index for SDK library search queries.
class SdkMemIndex {
  final _libraries = <String, _Library>{};
  final Map<String, double> _apiPageDirWeights;

  SdkMemIndex({
    required String sdk,
    required Uri baseUri,
    required DartdocIndex index,
    Set<String>? allowedLibraries,
    Map<String, double>? apiPageDirWeights,
  }) : _apiPageDirWeights = apiPageDirWeights ?? _defaultApiPageDirWeights {
    _addDartdocIndex(sdk, baseUri, index, allowedLibraries);
  }

  static SdkMemIndex dart({required DartdocIndex index}) {
    return SdkMemIndex(
      sdk: 'dart',
      baseUri: Uri.parse('https://api.dart.dev/stable/latest/'),
      index: index,
    );
  }

  factory SdkMemIndex.flutter({required DartdocIndex index}) {
    return SdkMemIndex(
      sdk: 'flutter',
      baseUri: Uri.parse('https://api.flutter.dev/flutter/'),
      index: index,
      allowedLibraries: flutterSdkAllowedLibraries,
    );
  }

  static final dartSdkIndexJsonUri =
      Uri.parse('https://api.dart.dev/stable/latest/index.json');
  static final flutterSdkIndexJsonUri =
      Uri.parse('https://api.flutter.dev/flutter/index.json');

  void _addDartdocIndex(
    String sdk,
    Uri baseUri,
    DartdocIndex index,
    Set<String>? allowedLibraries,
  ) {
    final textsPerLibrary = <String, Map<String, String>>{};
    final baseUris = <String, Uri>{};
    final descriptions = <String, String>{};

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
        name: e.key,
        baseUri: baseUris[e.key] ?? baseUri,
        description: descriptions[e.key],
        tokenIndex: TokenIndex.fromMap(e.value),
      );
    }
  }

  List<SdkLibraryHit> search(
    String query, {
    int? limit,
  }) {
    limit ??= 2;
    final words = query.split(' ').where((e) => e.isNotEmpty).toList();
    if (words.isEmpty) return <SdkLibraryHit>[];

    final hits = <_Hit>[];
    for (final library in _libraries.values) {
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
              url: hit.library.url,
              score: hit.score,
              apiPages: hit.top.entries
                  .map(
                    (e) => ApiPageRef(
                      path: e.key,
                      url: hit.library.baseUri.resolve(e.key).toString(),
                    ),
                  )
                  .toList(),
            ))
        .toList();
  }

  @visibleForTesting
  String? getLibraryDescription(String library) =>
      _libraries[library]?.description;
}

class _Hit {
  final _Library library;
  final Map<String, double> top;

  _Hit(this.library, this.top);

  late final score = top.values.fold(0.0, (a, b) => max(a, b));
}

class _Library {
  final String sdk;
  final String name;
  final Uri baseUri;
  final String? description;
  final TokenIndex<String> tokenIndex;

  _Library({
    required this.sdk,
    required this.name,
    required this.baseUri,
    required this.description,
    required this.tokenIndex,
  });

  late final url = baseUri.toString();
  late final weight = _libraryWeights[name] ?? 1.0;
  late final lastNamePart = name.split(':').last;
}
