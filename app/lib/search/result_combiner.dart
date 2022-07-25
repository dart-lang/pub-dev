// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/search/tags.dart';

import 'dart_sdk_mem_index.dart';
import 'flutter_sdk_mem_index.dart';
import 'search_service.dart';

/// Combines the results from the primary package index and the optional Dart
/// SDK index.
class SearchResultCombiner {
  final PackageIndex primaryIndex;
  final DartSdkMemIndex dartSdkMemIndex;
  final FlutterSdkMemIndex flutterSdkMemIndex;

  SearchResultCombiner({
    required this.primaryIndex,
    required this.dartSdkMemIndex,
    required this.flutterSdkMemIndex,
  });

  Future<PackageSearchResult> search(ServiceSearchQuery query) async {
    if (!query.includeSdkResults) {
      return primaryIndex.search(query);
    }

    final primaryResult = await primaryIndex.search(query);
    final queryFlutterSdk = query.tagsPredicate.hasNoTagPrefix('sdk:') ||
        query.tagsPredicate.hasTag(SdkTag.sdkFlutter);
    final sdkLibraryHits = [
      ...await dartSdkMemIndex.search(query.query!, limit: 2),
      if (queryFlutterSdk)
        ...await flutterSdkMemIndex.search(query.query!, limit: 2),
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
