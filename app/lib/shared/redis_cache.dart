// Copyright (c) 2018, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:_pub_shared/data/download_counts_data.dart';
import 'package:_pub_shared/data/package_api.dart' show VersionScore;
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/youtube/v3.dart';
import 'package:indexed_blob/indexed_blob.dart' show BlobIndex;
import 'package:logging/logging.dart';
import 'package:neat_cache/cache_provider.dart';
import 'package:neat_cache/neat_cache.dart';
import 'package:pub_dev/service/download_counts/download_counts.dart';

import '../../../service/async_queue/async_queue.dart';
import '../../../service/rate_limit/models.dart';
import '../../../service/security_advisories/models.dart';
import '../../dartdoc/models.dart';
import '../../shared/env_config.dart';
import '../account/models.dart' show LikeData, SessionData;
import '../package/models.dart' show PackageView;
import '../publisher/models.dart' show PublisherPage;
import '../scorecard/models.dart' show ScoreCardData;
import '../search/search_service.dart' show PackageSearchResult;
import '../service/openid/openid_models.dart' show OpenIdData;
import '../service/secret/backend.dart';
import '../task/models.dart';
import 'convert.dart';
import 'versions.dart';

final Logger _log = Logger('rediscache');
final _random = Random.secure();
final _defaultCacheReadTimeout = Duration(milliseconds: 300);
final _defaultCacheWriteTimeout = Duration(milliseconds: 1000);

class CachePatterns {
  final Cache<List<int>> _cache;
  CachePatterns._(Cache<List<int>> cache)
      : _cache = cache
            .withPrefix('rv-$runtimeVersion/')
            .withTTL(Duration(minutes: 10));

  // NOTE: This class should only contain methods that return Entry<T>, as well
  //       configuration options like prefix and TTL.

  /// Cache for [SessionData].
  Entry<SessionData> userSessionData(String sessionId) => _cache
      .withPrefix('account-usersession/')
      .withTTL(Duration(hours: 24))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (SessionData data) => data.toJson(),
        decode: (d) => SessionData.fromJson(d as Map<String, dynamic>),
      ))[sessionId];

  Entry<String> uiPackagePage(String package, String? version) => _cache
      .withPrefix('ui-packagepage/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package-$version'];

  Entry<String> uiPackageChangelog(String package, String? version) => _cache
      .withPrefix('ui-package-changelog/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package-$version'];

  Entry<String> uiPackageExample(String package, String? version) => _cache
      .withPrefix('ui-package-example/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package-$version'];

  Entry<String> uiPackageInstall(String package, String? version) => _cache
      .withPrefix('ui-package-install/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package-$version'];

  Entry<String> uiPackageLicense(String package, String? version) => _cache
      .withPrefix('ui-package-license/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package-$version'];

  Entry<String> uiPackagePubspec(String package, String? version) => _cache
      .withPrefix('ui-package-pubspec/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package-$version'];

  Entry<String> uiPackageScore(String package, String? version) => _cache
      .withPrefix('ui-package-score/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package-$version'];

  Entry<String> uiPackageVersions(String package) => _cache
      .withPrefix('ui-package-versions/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package'];

  Entry<String> uiIndexPage() => _cache
      .withPrefix('ui-indexpage/')
      .withTTL(Duration(minutes: 60))
      .withCodec(utf8)['/'];

  Entry<String> uiPublisherListPage() => _cache
      .withPrefix('ui-publisherpage/')
      .withTTL(Duration(minutes: 60))
      .withCodec(utf8)['/publishers'];

  /// The first, non-search page for publisher's packages.
  Entry<String> uiPublisherPackagesPage(String publisherId) => _cache
      .withPrefix('ui-publisherpage/')
      .withTTL(Duration(minutes: 60))
      .withCodec(utf8)[publisherId];

  Entry<bool> packageVisible(String package) => _cache
      .withPrefix('package-visible/')
      .withTTL(Duration(days: 7))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (bool value) => value,
        decode: (d) => d as bool,
      ))[package];

  Entry<bool> packageModerated(String package) => _cache
      .withPrefix('package-moderated/')
      .withTTL(Duration(days: 7))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (bool value) => value,
        decode: (d) => d as bool,
      ))[package];

  Entry<List<int>> packageData(String package) => _cache
      .withPrefix('api-package-data-by-uri/')
      .withTTL(Duration(minutes: 10))['$package'];

  Entry<List<int>> packageDataGz(String package) => _cache
      .withPrefix('api-package-data-gz-by-uri/')
      .withTTL(Duration(minutes: 10))['$package'];

  Entry<VersionScore> versionScore(String package, String? version) => _cache
      .withPrefix('api-version-score/')
      .withTTL(Duration(minutes: 60))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (VersionScore d) => d.toJson(),
        decode: (d) => VersionScore.fromJson(d as Map<String, dynamic>),
      ))['$package-$version'];

  Entry<String> packageLatestVersion(String package) => _cache
      .withPrefix('package-latest-version/')
      .withTTL(Duration(minutes: 60))
      .withCodec(utf8)[package];

  Entry<String> latestFinishedVersion(String package) => _cache
      .withPrefix('latest-finished-version/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)[package];

  Entry<String> closestFinishedVersion(String package, String version) => _cache
      .withPrefix('closest-finished-version/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)['$package/$version'];

  Entry<PackageView> packageView(String package) => _cache
      .withPrefix('package-view/')
      .withTTL(Duration(minutes: 60))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (PackageView pv) => pv.toJson(),
        decode: (d) => PackageView.fromJson(d as Map<String, dynamic>),
      ))[package];

  Entry<Map<String, dynamic>> apiPackagesListPage(int page) => _cache
      .withPrefix('api-packages-list/')
      .withTTL(Duration(minutes: 10))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (Map<String, dynamic> map) => map,
        decode: (obj) => obj as Map<String, dynamic>,
      ))['$page'];

  Entry<PackageSearchResult> packageSearchResult(String url) {
    return _cache
        .withPrefix('search-result/')
        .withTTL(const Duration(minutes: 1))
        .withCodec(utf8)
        .withCodec(json)
        .withCodec(wrapAsCodec(
          encode: (PackageSearchResult r) => r.toJson(),
          decode: (d) =>
              PackageSearchResult.fromJson(d as Map<String, dynamic>),
        ))[url];
  }

  Entry<RateLimitRequestCounter> rateLimitRequestCounter(
      String sourceIp, String operation) {
    return _cache
        .withPrefix('rate-limit-request-counter/')
        .withTTL(const Duration(minutes: 3))
        .withCodec(utf8)
        .withCodec(json)
        .withCodec(wrapAsCodec(
          encode: (RateLimitRequestCounter r) => r.toJson(),
          decode: (d) =>
              RateLimitRequestCounter.fromJson(d as Map<String, dynamic>),
        ))['$sourceIp/$operation'];
  }

  Entry<ScoreCardData> scoreCardData(String package, String version) => _cache
      .withPrefix('scorecard-data/')
      .withTTL(Duration(hours: 2))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (ScoreCardData d) => d.toJson(),
        decode: (d) => ScoreCardData.fromJson(d as Map<String, dynamic>),
      ))['$package-$version'];

  Entry<List<SecurityAdvisoryData>> securityAdvisories(String package) => _cache
      .withPrefix('security-advisory/')
      .withTTL(Duration(hours: 8))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (List<SecurityAdvisoryData> l) =>
            l.map((SecurityAdvisoryData adv) => adv.toJson()).toList(),
        decode: (d) => (d as List)
            .map(
                (d) => SecurityAdvisoryData.fromJson(d as Map<String, dynamic>))
            .toList(),
      ))[package];

  Entry<CountData> downloadCounts(String package) => _cache
      .withPrefix('download-counts/')
      .withTTL(Duration(hours: 25))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (CountData cd) => cd.toJson(),
        decode: (d) => CountData.fromJson(d as Map<String, dynamic>),
      ))[package];

  Entry<WeeklyDownloadCounts> weeklyDownloadCounts(String package) => _cache
      .withPrefix('weekly-download-counts/')
      .withTTL(Duration(hours: 6))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (WeeklyDownloadCounts wdc) => wdc.toJson(),
        decode: (d) => WeeklyDownloadCounts.fromJson(d as Map<String, dynamic>),
      ))[package];

  Entry<WeeklyVersionDownloadCounts> weeklyVersionDownloadCounts(
          String package) =>
      _cache
          .withPrefix('weekly-versions-download-counts/')
          .withTTL(Duration(hours: 6))
          .withCodec(utf8)
          .withCodec(json)
          .withCodec(wrapAsCodec(
            encode: (WeeklyVersionDownloadCounts wdc) => wdc.toJson(),
            decode: (d) =>
                WeeklyVersionDownloadCounts.fromJson(d as Map<String, dynamic>),
          ))[package];

  Entry<List<LikeData>> userPackageLikes(String userId) => _cache
      .withPrefix('user-package-likes/')
      .withTTL(Duration(minutes: 60))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (List<LikeData> l) =>
            l.map((LikeData l) => l.toJson()).toList(),
        decode: (d) => (d as List)
            .map((d) => LikeData.fromJson(d as Map<String, dynamic>))
            .toList(),
      ))[userId];

  Entry<String> secretValue(String secretId) => _cache
      .withPrefix('secret-value/')
      .withTTL(Duration(minutes: 60))
      .withCodec(utf8)[secretId];

  Entry<String> sitemap(String requestedUri) => _cache
      .withPrefix('sitemap/')
      .withTTL(Duration(hours: 12))
      .withCodec(utf8)[requestedUri];

  Entry<List<int>> packageNamesDataJsonGz() => _cache
      .withPrefix('api-package-names-data-json-gz/')
      .withTTL(Duration(hours: 2))['-'];

  Entry<List<int>> packageNameCompletionDataJsonGz() => _cache
      .withPrefix('api-package-name-completion-data-json-gz/')
      .withTTL(Duration(hours: 8))['-'];

  Entry<PublisherPage> allPublishersPage() => publisherPage('-');

  Entry<PublisherPage> publisherPage(String userId) => _cache
      .withPrefix('publisher-page/')
      .withTTL(Duration(hours: 4))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (PublisherPage list) => list.toJson(),
        decode: (data) => PublisherPage.fromJson(data as Map<String, dynamic>),
      ))['$userId'];

  Entry<bool> publisherVisible(String publisherId) => _cache
      .withPrefix('publisher-visible/')
      .withTTL(Duration(days: 7))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (bool value) => value,
        decode: (d) => d as bool,
      ))[publisherId];

  Entry<String> atomFeedXml() => _cache
      .withPrefix('atom-feed-xml/')
      .withTTL(Duration(minutes: 3))
      .withCodec(utf8)['/'];

  Entry<List<int>> topicNameCompletionDataJsonGz() => _cache
      .withPrefix('topic-name-completion-data-json-gz/')
      .withTTL(Duration(hours: 8))['-'];

  Entry<List<int>> searchInputCompletionDataJsonGz() => _cache
      .withPrefix('search-input-completion-data-json-gz/')
      .withTTL(Duration(hours: 8))['-'];

  /// Stores the flag that latest version of packages have been scanned for job entities.
  Entry<bool> jobHistoryLatestScanned(String service) =>
      jobHistoryPackageScanned(service, '');

  /// Stores the flag that a [package]'s versions have been scanned for job entities.
  Entry<bool> jobHistoryPackageScanned(String service, String package) => _cache
      .withPrefix('job-history-package-scanned/')
      .withTTL(Duration(days: 7))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (bool value) => value,
        decode: (d) => d as bool,
      ))['$service/$package'];

  /// Cache for index objects, used by TaskBackend.
  Entry<BlobIndex> taskResultIndex(String package, String version) => _cache
      .withPrefix('task-result-index/')
      .withTTL(Duration(hours: 24))
      .withCodec(wrapAsCodec(
        encode: (BlobIndex entry) => entry.asBytes(),
        decode: (data) => BlobIndex.fromBytes(data),
      ))['$package-$version'];

  /// Cache for gzipped task-result files used by TaskBackend.
  Entry<List<int>> gzippedTaskResult(
    String blobId,
    String path,
  ) =>
      _cache
          .withPrefix('task-result/')
          .withTTL(Duration(hours: 4))['$blobId/$path'];

  /// Cache for task status.
  Entry<PackageStateInfo> taskPackageStatus(String package) => _cache
      .withPrefix('task-status-v2/')
      .withTTL(Duration(hours: 3))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (PackageStateInfo s) => s.toJson(),
        decode: (data) =>
            PackageStateInfo.fromJson(data as Map<String, dynamic>),
      ))[package];

  /// Cache for sanitized and re-rendered dartdoc HTML files.
  Entry<List<int>> dartdocHtmlBytes(
    String package,
    String urlSegment,
    String path,
  ) =>
      _cache
          .withPrefix('dartdoc-html/')
          .withTTL(Duration(minutes: 10))['$package/$urlSegment/$path'];

  /// Cache for sanitized and re-rendered dartdoc HTML files.
  Entry<DocPageStatus> dartdocPageStatus(
    String package,
    String urlSegment,
    String path,
  ) =>
      _cache
          .withPrefix('dartdoc-status/')
          .withTTL(Duration(minutes: 10))
          .withCodec(utf8)
          .withCodec(json)
          .withCodec(wrapAsCodec(
              encode: (DocPageStatus s) => s.toJson(),
              decode: (data) => DocPageStatus.fromJson(
                  data as Map<String, dynamic>)))['$package/$urlSegment/$path'];

  /// Stores the OpenID Data (including the JSON Web Key list).
  ///
  /// GitHub does not provide `Cache-Control` header for their
  /// OpenId config or their keys. It is assumed that key rotation
  /// (e.g. including a new key but not yet using it) should take
  /// more than a day, we don't have any clear guidance on it.
  /// Caching for 15 minutes seems to be a safe choice.
  Entry<OpenIdData> openIdData({
    required String configurationUrl,
    Duration? ttl,
  }) =>
      _cache
          .withPrefix('openid-data/')
          .withTTL(ttl ?? Duration(minutes: 15))
          .withCodec(utf8)
          .withCodec(json)
          .withCodec(wrapAsCodec(
            encode: (OpenIdData v) => v.toJson(),
            decode: (v) => OpenIdData.fromJson(v as Map<String, dynamic>),
          ))[configurationUrl];

  Entry<List<int>> topicsPageData() =>
      _cache.withPrefix('topics-page-data/').withTTL(Duration(hours: 1))['-'];

  /// When a rate limit is triggered, the cached entry holds the time
  /// until the block should be applied.
  Entry<DateTime> rateLimitUntil(String entryKey) => _cache
      .withPrefix('rate-limit-until/')
      .withTTL(Duration(hours: 1)) // gets override when the set is called
      .withCodec(utf8)
      .withCodec(wrapAsCodec(
        encode: (DateTime v) => v.toUtc().toIso8601String(),
        decode: (v) => DateTime.parse(v.toString()),
      ))[entryKey];

  /// The resolved display version and URL redirect info for /documentation/ URLs.
  Entry<ResolvedDocUrlVersion> resolvedDocUrlVersion(
          String package, String version) =>
      _cache
          .withPrefix('resolved-doc-url-version/')
          .withTTL(Duration(minutes: 15))
          .withCodec(utf8)
          .withCodec(json)
          .withCodec(wrapAsCodec(
            encode: (ResolvedDocUrlVersion v) => v.toJson(),
            decode: (v) =>
                ResolvedDocUrlVersion.fromJson(v as Map<String, dynamic>),
          ))['$package-$version'];

  Entry<PlaylistItemListResponse> youtubePlaylistItems() => _cache
      .withPrefix('youtube/playlist-item-list-response/')
      .withTTL(Duration(hours: 6))
      .withCodec(utf8)
      .withCodec(json)
      .withCodec(wrapAsCodec(
        encode: (PlaylistItemListResponse v) => v.toJson(),
        decode: (v) =>
            PlaylistItemListResponse.fromJson(v as Map<String, dynamic>),
      ))[''];
}

/// The active cache.
CachePatterns get cache => ss.lookup(#_cache) as CachePatterns;

void _registerCache(CachePatterns cache) => ss.register(#_cache, cache);

/// Initializes caches based on the environment.
/// - In AppEngine, it will use redis cache,
/// - otherwise, a local in-memory cache.
Future<void> setupCache() async {
  // Use in-memory cache, if not running on AppEngine
  if (envConfig.isRunningInAppengine) {
    await _registerRedisCache();
  } else {
    _log.warning('using in-memory cache instead of redis');
    await _registerInMemoryCache();
  }
}

/// Read redis connection string from the secret backend and initialize redis
/// cache.
Future _registerRedisCache() async {
  final connectionString =
      await secretBackend.lookup(SecretKey.redisConnectionString);
  // Validate that we got a connection string
  if (connectionString == null || connectionString.isEmpty) {
    throw Exception('Secret ${SecretKey.redisConnectionString} is missing');
  }
  final connectionUri = Uri.parse(connectionString);

  // Create and register a cache
  final cacheProvider = await _ConnectionRefreshingCacheProvider.connect(
      () async => Cache.redisCacheProvider(connectionUri));
  _registerCache(CachePatterns._(Cache(cacheProvider)));
  ss.registerScopeExitCallback(() async => cacheProvider.close());
}

Future _registerInMemoryCache() async {
  _registerCache(CachePatterns._(Cache(Cache.inMemoryCacheProvider(4096))));
}

/// Creates a [CacheProvider] when called.
typedef _CacheProviderFn<T> = Future<CacheProvider<T>> Function();

/// The redis client uses a single connection for a long period. To make sure we
/// don't accumulate objects around a single connection accidentally, this cache
/// provider will reconnect to redis ~every hour.
class _ConnectionRefreshingCacheProvider<T> implements CacheProvider<T> {
  final _CacheProviderFn<T> _fn;
  CacheProvider<T> _delegate;
  late Timer _timer;
  bool _isClosed = false;

  _ConnectionRefreshingCacheProvider._(this._fn, this._delegate) {
    final duration = Duration(minutes: 55 + _random.nextInt(10));
    _timer = Timer.periodic(duration, (_) async {
      _log.info('Starting to update redis connection...');
      try {
        final newProvider = await _fn();
        // Warm-up redis connection
        await newProvider.get('ping');

        if (_isClosed) {
          // discard if `close` was called during the Timer callback
          await newProvider.close();
        } else {
          // otherwise update provider and close old one
          final d = _delegate;
          _delegate = newProvider;
          await d.close();
        }
      } catch (e, st) {
        _log.shout('Failed to update redis connection.', e, st);
      }
    });
  }

  static Future<_ConnectionRefreshingCacheProvider<T>> connect<T>(
      _CacheProviderFn<T> fn) async {
    return _ConnectionRefreshingCacheProvider._(fn, await fn());
  }

  @override
  Future<void> close() async {
    _isClosed = true;
    _timer.cancel();
    await _delegate.close();
  }

  @override
  Future<T?> get(String key) async {
    try {
      return await _delegate
          .get(key)
          .timeout(_defaultCacheReadTimeout, onTimeout: () => null);
    } on IntermittentCacheException catch (e) {
      _log.info('Redis access failed.', e);
    } catch (e, st) {
      _log.warning('Redis access failed.', e, st);
    }
    return null;
  }

  @override
  Future<void> purge(String key) => _delegate
      .purge(key)
      .timeout(_defaultCacheWriteTimeout, onTimeout: () => null);

  @override
  Future<void> set(String key, T value, [Duration? ttl]) => _delegate
      .set(key, value, ttl)
      .timeout(_defaultCacheWriteTimeout, onTimeout: () => null);
}

extension EntryPurgeExt<T> on Entry<T> {
  /// Datastore.query is only eventually consistent, and when we are changing
  /// entries that are then fetched via query, the cache may store the old values.
  /// Running a repeated purge after a reasonable delay will make sure that the
  /// cache won't store the old values for too long.
  Future purgeAndRepeat({int retries = 0, Duration? delay}) async {
    await purge(retries: retries);
    asyncQueue.addAsyncFn(() async {
      await Future.delayed(delay ?? Duration.zero);
      await purge();
    });
  }

// Get or create a value.
  Future<T?> obtain(
    Future<T?> Function() create, {
    Duration? ttl,
    bool purgeCache = false,
  }) async {
    if (purgeCache) {
      final value = await create();
      if (ttl != null) {
        await set(value, ttl);
      } else {
        await set(value);
      }
      return value;
    }
    if (ttl != null) {
      return await get(create, ttl);
    }
    return await get(create);
  }
}
