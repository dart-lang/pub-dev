// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:logging/logging.dart';
import 'package:memcache/memcache.dart';

const Duration indexUiPageExpiration = const Duration(minutes: 10);
const Duration packageJsonExpiration = const Duration(minutes: 10);
const Duration packageUiPageExpiration = const Duration(minutes: 10);
const Duration analyzerDataExpiration = const Duration(minutes: 60);
const Duration searchUiPageExpiration = const Duration(minutes: 10);

const String indexUiPageKey = 'pub_index';
const String packageJsonPrefix = 'package_json_';
const String packageUiPagePrefix = 'package_ui_';
const String analyzerDataPrefix = 'dart_analyzer_api_';
const String searchUiPagePrefix = 'dart_search_ui_';

class SimpleMemcache<T> {
  final Logger _logger;
  final Memcache _memcache;
  final String _prefix;
  final Duration _expiration;

  SimpleMemcache(this._logger, this._memcache, this._prefix, this._expiration);

  String _key(T key) => '$_prefix$key';

  Future<String> getText(T key) async {
    try {
      return await _memcache.get(_key(key));
    } catch (e, st) {
      _logger.severe('Error accessing memcache:', e, st);
    }
    _logger.fine('Couldn\'t find memcache entry for $key');
    return null;
  }

  Future setText(T key, String content) async {
    try {
      await _memcache.set(_key(key), content, expiration: _expiration);
    } catch (e, st) {
      _logger.warning('Couldn\'t set memcache entry for $key', e, st);
    }
  }

  Future invalidate(T key) async {
    try {
      await _memcache.remove(_key(key));
    } catch (e, st) {
      _logger.warning('Couldn\'t remove memcache entry for $key', e, st);
    }
  }
}
