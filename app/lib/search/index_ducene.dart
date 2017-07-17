// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:ducene/analysis.dart';
import 'package:ducene/document.dart';
import 'package:ducene/search.dart';
import 'package:ducene/util.dart';
import 'package:gcloud/service_scope.dart' as ss;

import '../shared/search_service.dart';

import 'text_utils.dart';

/// The [PackageIndex] registered in the current service scope.
PackageIndex get packageIndex => ss.lookup(#packageIndexService);

/// Register a new [PackageIndex] in the current service scope.
void registerPackageIndex(PackageIndex index) =>
    ss.register(#packageIndexService, index);

class DucenePackageIndex implements PackageIndex {
  final String directory;
  final _MultiNgramAnalyzer _analyzer = new _MultiNgramAnalyzer(3);
  Directory _fsDir;
  IndexHolder _index;
  DateTime _lastUpdated;
  Future _initFuture;

  DucenePackageIndex({this.directory});

  Future _init() async {
    if (_initFuture != null) return _initFuture;
    assert(_index == null);
    _initFuture = new Future(() async {
      IndexHolderDirectory indexDir;
      if (directory != null) {
        // Temporarily everything is in memory, because ducene is not using async
        // IO, and that blocks appengine's health checks, killing the machine
        // before it got any chance to setup.
        // TODO: fix ducene to handle async FS properly
        // _fsDir = new Directory(directory);
        // indexDir = new FSIndexHolderDirectory(_fsDir);
        indexDir = new RAMIndexHolderDirectory();
      } else {
        indexDir = new RAMIndexHolderDirectory();
      }
      _index = await DirectoryHolder.open(indexDir);
    });
    return _initFuture;
  }

  @override
  bool get isReady => _lastUpdated != null;

  @override
  Future<int> indexSize() async {
    if (_fsDir == null) return -1;
    return _fsDir.list(recursive: true).asyncMap((FileSystemEntity fse) async {
      if (fse is File) {
        return fse.length();
      }
      return 0;
    }).fold(0, (int sum, int v) => sum + v);
  }

  @override
  Future add(PackageDocument doc) async {
    await _init();
    final Document duceneDoc = _createDuceneDocument(doc);
    await _index.updateDocuments([duceneDoc]);
  }

  Document _createDuceneDocument(PackageDocument doc) {
    final Document duceneDoc = new Document()
      ..append('id', doc.url)
      ..append('package', doc.package, analyzer: _analyzer)
      ..append('version', doc.version)
      ..append('devVersion', doc.devVersion)
      ..append(
        'description',
        compactDescription(doc.description),
        analyzer: _analyzer,
        stored: true,
      )
      ..append('lastUpdated', doc.lastUpdated)
      ..append(
        'readme',
        compactReadme(doc.readme),
        analyzer: _analyzer,
        stored: false,
      )
      ..append('popularity', doc.popularity.toString());
    if (doc.detectedTypes != null && doc.detectedTypes.isNotEmpty) {
      duceneDoc.append('detectedTypes', doc.detectedTypes);
    }
    return duceneDoc;
  }

  @override
  Future addAll(Iterable<PackageDocument> documents) async {
    await _init();
    await _index.updateDocuments(documents.map(_createDuceneDocument));
  }

  @override
  Future contains(String url, String version, String devVersion) async {
    if (!isReady) return false;
    final IndexSearcher searcher = _index.newRealTimeIndexSearcher();
    final query = new BoolQuery(Op.and)
      ..append('id', url)
      ..append('version', version)
      ..append('devVersion', devVersion);
    final TopDocs topDocs = await searcher.search(query, 1);
    return topDocs.scoreDocs.length == 1;
  }

  @override
  Future removeUrl(String url) async {
    await _init();
    await _index.deleteDocuments(new BoolQuery()..append('id', url));
  }

  @override
  Future merge() async {
    await _init();
    await _index.forceMerge();
    _lastUpdated = new DateTime.now().toUtc();
  }

  @override
  Future<PackageSearchResult> search(PackageQuery query) async {
    if (!isReady) return new PackageSearchResult.notReady();

    await _init();
    final IndexSearcher searcher = _index.newRealTimeIndexSearcher();
    final String queryText = compactText(query.text, maxLength: 200);
    final duceneQuery = new BoolQuery()
      ..append('package', queryText, analyzer: _analyzer, boost: 4.0)
      ..append('description', queryText, analyzer: _analyzer, boost: 2.0)
      ..append('readme', queryText, analyzer: _analyzer);
    if (query.type != null) {
      duceneQuery
          .addFilter(new TermQuery(new Term('detectedTypes', query.type)));
    }

    final int offset = query.offset ?? 0;
    final int limit = max(minSearchLimit, query.limit ?? 100);

    final TopDocs topPackages = await searcher.search(
      duceneQuery,
      maxSearchResults + minSearchLimit, // additional results for extended bias
      scoreSort: new TFIDFScoreSort(),
    );

    List<PackageScore> packages = [];
    for (ScoreDoc sd in topPackages.scoreDocs) {
      final Document doc = await searcher.doc(sd.doc);
      final double bias = double.parse(doc.get('popularity')) * 20;

      packages.add(new PackageScore(
        url: doc.get('id'),
        package: doc.get('package'),
        version: doc.get('version'),
        devVersion: doc.get('devVersion'),
        // TODO: normalize values and calibrate bias weight
        score: sd.score + bias,
      ));
    }
    packages.sort((a, b) => -a.score.compareTo(b.score));
    if (packages.length > maxSearchResults) {
      packages = packages.sublist(0, maxSearchResults);
    }
    final int totalCount = packages.length;

    if (packages.length <= offset) {
      packages = [];
    } else {
      packages = packages.sublist(offset);
    }
    if (packages.length > limit) {
      packages = packages.sublist(0, limit);
    }

    assert(_lastUpdated.isUtc);
    return new PackageSearchResult(
      indexUpdated: _lastUpdated.toIso8601String(),
      totalCount: totalCount,
      packages: packages,
    );
  }
}

class _MultiNgramAnalyzer extends Analyzer {
  _MultiNgramAnalyzer(int n) {
    tokenizer = new _MultiNgramTokenizer(n);
  }
}

class _MultiNgramTokenizer extends Tokenizer {
  final int _n;
  _MultiNgramTokenizer(this._n);

  @override
  Iterable<String> tokenize(String text) {
    text = normalizeBeforeIndexing(text);
    if (text.isEmpty) return [];
    final Set<String> ngrams = new Set();
    for (int ngramLength = 1; ngramLength <= _n; ngramLength++) {
      if (text.length <= ngramLength) {
        ngrams.add(text);
      } else {
        for (int i = 0; i <= text.length - ngramLength; i++) {
          ngrams.add(text.substring(i, i + ngramLength));
        }
      }
    }
    return ngrams;
  }
}
