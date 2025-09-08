// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/search/tags.dart';
import 'package:collection/collection.dart';

import 'sdk_mem_index.dart';
import 'search_service.dart';

/// Combines the results from the primary package index and the optional Dart
/// SDK index.
class SearchResultCombiner implements SearchIndex {
  final SearchIndex primaryIndex;
  final SdkIndex? sdkIndex;

  SearchResultCombiner({required this.primaryIndex, required this.sdkIndex});

  @override
  FutureOr<IndexInfo> indexInfo() async {
    return await primaryIndex.indexInfo();
  }

  @override
  FutureOr<bool> isReady() async {
    return await primaryIndex.isReady();
  }

  @override
  Future<PackageSearchResult> search(ServiceSearchQuery query) async {
    if (sdkIndex == null || !query.includeSdkResults) {
      return await primaryIndex.search(query);
    }

    final queryFlutterSdk =
        query.tagsPredicate.hasNoTagPrefix('sdk:') ||
        query.tagsPredicate.hasTag(SdkTag.sdkFlutter);
    final results = await Future.wait([
      Future(() => primaryIndex.search(query)),
      Future(
        () => sdkIndex!.search(
          query.query!,
          limit: 2,
          skipFlutter: !queryFlutterSdk,
        ),
      ),
    ]);
    final primaryResult = results[0] as PackageSearchResult;
    final sdkLibraryHits = results[1] as List<SdkLibraryHit>;

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
    }

    return primaryResult.change(
      sdkLibraryHits: sdkLibraryHits.take(3).toList(),
    );
  }
}
