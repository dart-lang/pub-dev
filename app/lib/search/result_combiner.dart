// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:_pub_shared/search/tags.dart';
import 'package:collection/collection.dart';

import 'mem_index.dart';
import 'sdk_mem_index.dart';
import 'search_service.dart';

/// Combines the results from the primary package index and the optional Dart
/// SDK index.
class SearchResultCombiner {
  final InMemoryPackageIndex primaryIndex;
  final SdkMemIndex? dartSdkMemIndex;
  final SdkMemIndex? flutterSdkMemIndex;

  SearchResultCombiner({
    required this.primaryIndex,
    required this.dartSdkMemIndex,
    required this.flutterSdkMemIndex,
  });

  PackageSearchResult search(ServiceSearchQuery query) {
    final primaryResult = primaryIndex.search(query);
    if (!query.includeSdkResults) {
      return primaryResult;
    }

    final queryFlutterSdk = query.tagsPredicate.hasNoTagPrefix('sdk:') ||
        query.tagsPredicate.hasTag(SdkTag.sdkFlutter);
    final sdkLibraryHits = [
      ...?dartSdkMemIndex?.search(query.query!, limit: 2),
      if (queryFlutterSdk)
        ...?flutterSdkMemIndex?.search(query.query!, limit: 2),
    ];
    if (sdkLibraryHits.isNotEmpty) {
      // Do not display low SDK scores if the package hits are more relevant on the page.
      //
      // Note: we used to pick the lowest item's score for this threshold, but it was not ideal,
      //       because promoted hit of the exact package name match may have very low score.
      final primaryHitsTopScore =
          primaryResult.packageHits.map((a) => a.score ?? 0.0).maxOrNull ?? 0.0;
      if (primaryHitsTopScore > 0) {
        sdkLibraryHits.removeWhere((hit) => hit.score < primaryHitsTopScore);
      }
      sdkLibraryHits.sort((a, b) => -a.score.compareTo(b.score));
    }

    return PackageSearchResult(
      timestamp: primaryResult.timestamp,
      totalCount: primaryResult.totalCount,
      packageHits: primaryResult.packageHits,
      sdkLibraryHits: sdkLibraryHits.take(3).toList(),
    );
  }
}
