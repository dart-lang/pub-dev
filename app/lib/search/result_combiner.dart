// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';

import 'search_service.dart';

/// Combines the results from the primary package index and the optional Dart
/// SDK index.
class SearchResultCombiner {
  final PackageIndex primaryIndex;
  final PackageIndex dartSdkIndex;

  SearchResultCombiner({
    @required this.primaryIndex,
    @required this.dartSdkIndex,
  });

  Future<PackageSearchResult> search(ServiceSearchQuery query) async {
    final includeSdkResults =
        query.offset == 0 && query.hasFreeTextComponent && query.isNaturalOrder;
    if (!includeSdkResults) {
      return primaryIndex.search(query);
    }

    final primaryResult = await primaryIndex.search(query);
    final dartSdkResult = await dartSdkIndex
        .search(query.change(order: SearchOrder.text, offset: 0, limit: 2));

    return PackageSearchResult(
      timestamp: primaryResult.timestamp,
      totalCount: primaryResult.totalCount,
      highlightedHit: primaryResult.highlightedHit,
      packageHits: primaryResult.packageHits,
      sdkLibraryHits: dartSdkResult.sdkLibraryHits,
    );
  }
}
