// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:meta/meta.dart';

import '../shared/utils.dart' show boundedList;

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

  Future<PackageSearchResult> search(SearchQuery query) async {
    final includeSdkResults = shouldIncludeSdkResults(query);
    if (!includeSdkResults) {
      return primaryIndex.search(query);
    }

    // Setting the query to request an unbounded result set. The original offset
    // and limit will be applied after the result sets are merged.
    final primaryQuery = query.change(offset: 0, limit: 0);
    final primaryResult = await primaryIndex.search(primaryQuery);
    final threshold = primaryResult.packages.isEmpty
        ? 0.0
        : (primaryResult.packages.first.score ?? 0.0) / 2;

    final dartSdkResult = await dartSdkIndex
        .search(query.change(order: SearchOrder.text, offset: 0, limit: 3));

    final allPackages = [
      primaryResult.packages,
      dartSdkResult.packages.where((ps) => ps.score >= threshold).toList(),
    ].expand((list) => list).toList();

    final matchedPackage = query.parsedQuery.text;
    final matchedPackageIsFirst = primaryResult.packages.isNotEmpty &&
        primaryResult.packages.first.package == matchedPackage;
    allPackages.sort((a, b) {
      // matching package name should be the first
      if (matchedPackageIsFirst && a.package == matchedPackage) return -1;
      if (matchedPackageIsFirst && b.package == matchedPackage) return 1;

      // otherwise sort on score
      return -a.score.compareTo(b.score);
    });

    final packages =
        boundedList(allPackages, offset: query.offset, limit: query.limit);

    return PackageSearchResult(
      indexUpdated: primaryResult.indexUpdated,
      totalCount: allPackages.length,
      packages: packages,
    );
  }
}

/// Whether the results for the query should include SDK results.
bool shouldIncludeSdkResults(SearchQuery query) {
  // No reason to display SDK packages if:
  // - there is no text query
  // - the query is about a filter (e.g. dependency or package-prefix)
  final hasFreeTextComponent = query.offset == 0 &&
      query.hasQuery &&
      query.parsedQuery.text != null &&
      query.parsedQuery.text.isNotEmpty;
  // No reason to display SDK packages if:
  // - the order is based on analysis score (e.g. health)
  // - the order is based on timestamp (e.g. created time)
  final isNaturalOrder = query.order == null ||
      query.order == SearchOrder.top ||
      query.order == SearchOrder.text;
  return hasFreeTextComponent && isNaturalOrder;
}
