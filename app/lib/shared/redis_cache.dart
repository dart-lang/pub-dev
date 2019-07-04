// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:neat_cache/neat_cache.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:gcloud/db.dart' as db;
import 'package:appengine/appengine.dart';
import 'package:logging/logging.dart';

import '../frontend/models.dart' show Secret, SecretKey;
import 'versions.dart';

final Logger _log = Logger('rediscache');

/// The active cache.
///
/// Can only be used within the context of [withAppEngineAndCache].
Cache<List<int>> get cache => ss.lookup(#_cache) as Cache<List<int>>;

void _registerCache(Cache<List<int>> cache) => ss.register(#_cache, cache);

/// Run [fn] with AppEngine services and [cache].
///
/// See `package:appengine` for details on how [withAppEngineServices] sets up
/// services like datastore and logging.
Future withAppEngineAndCache(FutureOr Function() fn) async {
  return withAppEngineServices(() async {
    return await withCache(fn);
  });
}

// Run [fn] with a redis or an in-memory cache.
Future withCache(FutureOr Function() fn) async {
  // Use in-memory cache, if not running on AppEngine
  if (Platform.environment.containsKey('GAE_VERSION')) {
    return await _withRedisCache(fn);
  }
  _log.warning('using in-memory cache instead of redis');
  return await _withInmemoryCache(fn);
}

/// Run [fn] with [cache] connected to a redis cache.
Future _withRedisCache(FutureOr Function() fn) async {
  // TODO: use in-memory if GAE_VERSION is not set...
  final s = await db.dbService.lookup([
    db.dbService.emptyKey.append(Secret, id: SecretKey.redisConnectionString),
  ]);
  // Validate that we got a connection string
  if (s.isEmpty || !(s[0] is Secret) || (s[0] as Secret).value.isEmpty) {
    throw Exception('Secret ${SecretKey.redisConnectionString} is missing');
  }
  final connectionString = (s[0] as Secret).value;

  // Create and register a cache
  final cacheProvider = Cache.redisCacheProvider(connectionString);
  _registerCache(Cache(cacheProvider));

  try {
    // Call fn
    return await fn();
  } finally {
    await cacheProvider.close();
  }
}

/// Run [fn] with an in-memory cache for [cache].
Future _withInmemoryCache(FutureOr Function() fn) async {
  _registerCache(Cache(Cache.inMemoryCacheProvider(4096)));
  return await fn();
}

class SimpleMemcache {
  final Cache<String> _sCache;
  final Cache<List<int>> _bCache;

  SimpleMemcache(String prefix, Logger logger, Duration ttl)
      : _sCache = cache
            .withPrefix('$runtimeVersion/$prefix/')
            .withTTL(ttl)
            .withCodec(utf8),
        _bCache = cache.withPrefix('$runtimeVersion/$prefix/').withTTL(ttl);

  Future<String> getText(String key) => _sCache[key].get();
  Future setText(String key, String content) => _sCache[key].set(content);
  Future<List<int>> getBytes(String key) => _bCache[key].get();
  Future setBytes(String key, List<int> content) => _bCache[key].set(content);
  Future invalidate(String key) async => _bCache[key].purge();
}
