import 'dart:async' show FutureOr;

import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';

import '../account/backend.dart';
import '../history/backend.dart';
import '../job/backend.dart';
import '../scorecard/backend.dart';
import '../shared/analyzer_client.dart';

import 'redis_cache.dart' show withAppEngineAndCache;
import 'storage_retry.dart' show withStorageRetry;

/// Run [fn] with services;
///
///  * AppEngine: storage and datastore,
///  * Redis cache, and,
///  * storage wrapped with retry.
Future<void> withServices(FutureOr<void> Function() fn) async {
  return await withAppEngineAndCache(() async {
    return await withStorageRetry(() async {
      return await withPubServices(fn);
    });
  });
}

/// Run [fn] with pub services that are shared between server instances, CLI
/// tools and integration tests.
Future<void> withPubServices(FutureOr<void> Function() fn) async {
  return fork(() async {
    registerAccountBackend(AccountBackend(dbService));
    registerAnalyzerClient(AnalyzerClient());
    registerHistoryBackend(HistoryBackend(dbService));
    registerJobBackend(JobBackend(dbService));
    registerScoreCardBackend(ScoreCardBackend(dbService));

    registerScopeExitCallback(accountBackend.close);

    return await fn();
  });
}
