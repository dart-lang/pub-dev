// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';

import 'flutter_sdk_mem_index.dart';
import 'search_service.dart';

/// Combines the results from the primary package index and the optional Dart
/// SDK index.
class SearchResultCombiner {
  final PackageIndex primaryIndex;
  final PackageIndex dartSdkIndex;
  final FlutterSdkMemIndex flutterSdkMemIndex;

  SearchResultCombiner({
    @required this.primaryIndex,
    @required this.dartSdkIndex,
    @required this.flutterSdkMemIndex,
  });

  Future<PackageSearchResult> search(ServiceSearchQuery query) async {
    if (!query.includeSdkResults) {
      return primaryIndex.search(query);
    }

    final primaryResult = await primaryIndex.search(query);
    final dartSdkResult = await dartSdkIndex
        .search(query.change(order: SearchOrder.text, offset: 0, limit: 2));
    final flutterSdkResults =
        await flutterSdkMemIndex.search(query.query, limit: 2);
    final sdkLibraryHits = [
      if (dartSdkResult.sdkLibraryHits != null) ...dartSdkResult.sdkLibraryHits,
      ...flutterSdkResults,
    ];
    sdkLibraryHits.sort((a, b) => -a.score.compareTo(b.score));

    return PackageSearchResult(
      timestamp: primaryResult.timestamp,
      totalCount: primaryResult.totalCount,
      highlightedHit: primaryResult.highlightedHit,
      packageHits: primaryResult.packageHits,
      sdkLibraryHits: sdkLibraryHits.take(3).toList(),
    );
  }
}
