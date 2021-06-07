// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:meta/meta.dart';

import 'models.dart';
import 'search_service.dart';
import 'token_index.dart';

/// In-memory index for SDK library search queries.
class SdkMemIndex {
  final String _sdk;
  final String _version;
  final Uri _baseUri;
  final _tokensPerLibrary = <String, TokenIndex>{};

  SdkMemIndex({
    @required String sdk,
    @required String version,
    @required Uri baseUri,
  })  : _sdk = sdk,
        _version = version,
        _baseUri = baseUri;

  SdkMemIndex.flutter()
      : _sdk = 'flutter',
        _version = null,
        _baseUri = Uri.parse('https://api.flutter.dev/flutter');

  Future<void> addDartdocIndex(DartdocIndex index) async {
    for (final f in index.entries) {
      final library = f.qualifiedName.split('.').first;
      final tokens = _tokensPerLibrary.putIfAbsent(library, () => TokenIndex());

      final text = f.qualifiedName.replaceAll('.', ' ').replaceAll(':', ' ');
      tokens.add(f.href, text);
    }
  }

  Future<List<SdkLibraryHit>> search(
    String query, {
    int limit = 2,
  }) async {
    final words = query.split(' ').where((e) => e.isNotEmpty).toList();
    if (words.isEmpty) return <SdkLibraryHit>[];

    final hits = <_Hit>[];
    for (final library in _tokensPerLibrary.keys) {
      final tokens = _tokensPerLibrary[library];
      final rs = tokens.searchWords(words).top(3, minValue: 0.05);
      if (rs.isEmpty) continue;

      hits.add(_Hit(library, rs));
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
              description: null,
              url: _baseUri.toString(), // TODO: fix
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
  final double score;

  _Hit(this.library, this.top) : score = top.getMaxValue();
}
