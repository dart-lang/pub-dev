import 'dart:async' show FutureOr;

import 'redis_cache.dart' show withAppEngineAndCache;
import 'storage_retry.dart' show withStorageRetry;

/// Run [fn] with services;
///
///  * AppEngine: storage and datastore,
///  * Redis cache, and,
///  * storage wrapped with retry.
Future<void> withServices(FutureOr<void> Function() fn) async {
  return await withAppEngineAndCache(() async {
    return await withStorageRetry(fn);
  });
}
