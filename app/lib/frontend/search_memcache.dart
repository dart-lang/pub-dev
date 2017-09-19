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
  final SimpleMemcache _uiPage;

  SearchMemcache(Memcache memcache)
      : _uiPage = new SimpleMemcache(
          _logger,
          memcache,
          searchUiPagePrefix,
          searchUiPageExpiration,
        );

  Future<String> getUiSearchPage(String url) => _uiPage.getText(url);

  Future setUiSearchPage(String url, String html) => _uiPage.setText(url, html);
}
