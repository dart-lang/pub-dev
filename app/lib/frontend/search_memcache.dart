// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';

import '../shared/memcache.dart';

final Logger _logger = new Logger('pub.search_memcache');

/// Sets the search memcache.
void registerSearchMemcache(SearchMemcache value) =>
    ss.register(#_searchMemcache, value);

/// The active search memcache.
SearchMemcache get searchMemcache => ss.lookup(#_searchMemcache);

class SearchMemcache {
  final Memcache _memcache;

  SearchMemcache(this._memcache);

  Future<String> getUiSearchPage(String url) async {
    try {
      return await _memcache.get(_key(url));
    } catch (e, st) {
      _logger.severe('ERROR', e, st);
      // ignore errors
    }
    _logger.fine('Couldn\'t find memcache entry for url: $url');
    return null;
  }

  Future setUiSearchPage(String url, String html) async {
    try {
      await _memcache.set(_key(url), html, expiration: searchUiPageExpiration);
    } catch (e, st) {
      _logger.warning('Couldn\'t set memcache entry for url: $url', e, st);
    }
  }

  String _key(String url) => '$searchUiPagePrefix$url';
}
