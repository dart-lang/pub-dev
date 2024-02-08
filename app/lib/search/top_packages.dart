// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:math';

import 'package:_pub_shared/search/search_form.dart';
import 'package:_pub_shared/search/tags.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';

import '../package/models.dart';
import '../package/search_adapter.dart';
import '../shared/cached_value.dart';

final _random = Random.secure();

/// Sets the [TopPackages] backend service.
void registerTopPackages(TopPackages backend) =>
    ss.register(#_topPackages, backend);

/// The active [TopPackages] backend service.
TopPackages get topPackages => ss.lookup(#_topPackages) as TopPackages;

/// Represents the backend for local cache of top packages.
class TopPackages {
  final _flutterFavorites = _cachedValue(
    'top-packages-flutter-favorites',
    query: PackageTags.isFlutterFavorite,
  );
  final _mostPopular =
      _cachedValue('top-packages-most-popular', order: SearchOrder.popularity);
  final _topDart = _cachedValue('top-packages-top-dart', query: SdkTag.sdkDart);
  final _topFlutter =
      _cachedValue('top-packages-top-flutter', query: SdkTag.sdkFlutter);

  late final _values = [
    _flutterFavorites,
    _mostPopular,
    _topDart,
    _topFlutter,
  ];

  bool _running = false;
  bool _closing = false;

  /// Starts the initial and schedules the periodic updates.
  Future<void> start() async {
    if (_running) {
      return;
    }
    if (_closing) {
      throw StateError(
        'TopPackages.start() cannot be called after TopPackages.close()',
      );
    }
    _running = true;
    await Future.wait(_values.map((v) => v.update()));
  }

  @visibleForTesting
  Future<void> update() async {
    for (final v in _values) {
      // ignore: invalid_use_of_visible_for_testing_member
      await v.update();
    }
  }

  /// Cancels periodic updates.
  Future<void> close() async {
    _closing = true;
    _running = false;
    await Future.wait(_values.map((v) => v.close()));
  }

  List<PackageView> flutterFavorites() {
    return _randomSelection(_flutterFavorites, 4);
  }

  List<PackageView> mostPopular() {
    return _randomSelection(_mostPopular, 6);
  }

  List<PackageView> topDart() {
    return _randomSelection(_topDart, 6);
  }

  List<PackageView> topFlutter() {
    return _randomSelection(_topFlutter, 6);
  }

  List<PackageView> _randomSelection(
      CachedValue<List<PackageView>> cachedValue, int count) {
    if (!cachedValue.isAvailable) {
      return <PackageView>[];
    }
    final available = <PackageView>[...?cachedValue.value];
    final selected = <PackageView>[];
    for (var i = 0; i < count && available.isNotEmpty; i++) {
      // The first item should come from the top results.
      final index = i == 0 && available.length > 20
          ? _random.nextInt(20)
          : _random.nextInt(available.length);
      selected.add(available.removeAt(index));
    }
    return selected;
  }
}

/// Creates a cached value to hold top-* packages.
///
/// It will get updated every 15 minutes, but in case of any outage, will keep
/// the values for 24 hours.
CachedValue<List<PackageView>> _cachedValue(
  String id, {
  String? query,
  SearchOrder? order,
}) {
  return CachedValue<List<PackageView>>(
    name: id,
    // The search results are cached in redis with a 5 minutes TTL.
    //
    // If we have a valid value locally, we don't initiate new search queries
    // for the top packages for 15 minutes, and after that we have a good chance
    // that we have a <5 minutes old value in the cache.
    //
    // We could reduce the 15 minutes to 5 minutes, but in practice it wouldn't
    // matter much, as the search index itself won't get updated only at
    // every 15 minutes.
    interval: Duration(minutes: 15),
    maxAge: Duration(hours: 24),
    updateFn: () async {
      final form = SearchForm(
        query: query,
        order: order,
        pageSize: 100,
      );
      final page = await searchAdapter.search(
        form,
        // Do not apply rate limit here.
        rateLimitKey: null,
      );
      return page.packageHits;
    },
  );
}
