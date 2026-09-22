// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

/// Shared resilience policies — circuit breaking, retry with budget, per-attempt
/// timeouts and adaptive throttling — for the external dependencies pub.dev
/// talks to.
///
/// A single [ResilienceContext] is registered per service scope, so production
/// shares circuit state across all requests handled by an instance, while each
/// test gets its own isolated state.
library;

import 'dart:async';
import 'dart:convert';

import 'package:circuit_breaker/circuit_breaker.dart';
import 'package:circuit_breaker_http/circuit_breaker_http.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/storage/v1.dart'
    show ApiRequestError, DetailedApiRequestError;
import 'package:logging/logging.dart';

import 'monitoring.dart';

export 'package:circuit_breaker/circuit_breaker.dart'
    show
        CircuitBreakerOpenException,
        CircuitState,
        Criticality,
        OperationCancelledException,
        ResilienceException,
        ResilienceTimeoutException,
        ThrottledException;
export 'package:circuit_breaker_http/circuit_breaker_http.dart'
    show
        BoundResourceHttpExtension,
        HttpClassifier,
        HttpResponseException,
        HttpResponseTooLargeException,
        abortableRequest;

final _logger = Logger('pub.resilience');

/// Sets the resilience policies of the current service scope.
void registerResilience(PubResilience resilience) =>
    ss.register(#_resilience, resilience);

/// The active resilience policies of the current service scope.
PubResilience get resilience => ss.lookup(#_resilience) as PubResilience;

/// Returns the HTTP status code carried by [error], or `null` when [error] does
/// not originate from an HTTP response.
///
/// Recognizes [DetailedApiRequestError] from `package:googleapis`, which is how
/// every `googleapis`/`gcloud` client surfaces a non-2xx response. Without this
/// the resilience layer cannot tell a `404` apart from a `503`, and a handful of
/// missing objects would open the circuit for every caller.
int? gcpStatusCode(Object error) =>
    error is DetailedApiRequestError ? error.status : null;

/// Whether [error] indicates that a Google Cloud backend is unhealthy.
///
/// This drives the circuit breaker and the adaptive throttler — *not* retries,
/// see [isTransientGcpError]. A `404` answers "the object is not there", which
/// says nothing about the health of the backend, so it returns `false`.
///
/// An [ApiRequestError] without a status code is a malformed or undocumented
/// response, which is counted as a backend failure.
bool isGcpBackendFailure(Object error) {
  if (error is ApiRequestError && gcpStatusCode(error) == null) {
    return true;
  }
  return HttpClassifier.isFailure(error, statusCodeExtractor: gcpStatusCode);
}

/// Whether another attempt against a Google Cloud backend is likely to fare
/// better after [error].
///
/// Follows the [Cloud Storage retry strategy][retry-strategy] and retries `408`,
/// `429` and all `5xx` responses, plus transport-level failures. Note that this
/// deliberately disagrees with [isGcpBackendFailure]: a `500` is retried here
/// (all wrapped operations are idempotent or use a de-duplicating request id),
/// while a `404` is neither retried nor counted against the backend.
///
/// [retry-strategy]: https://cloud.google.com/storage/docs/retry-strategy
bool isTransientGcpError(Object error) {
  final status = gcpStatusCode(error);
  if (status != null) {
    return status == 408 || status == 429 || (status >= 500 && status < 600);
  }
  if (error is ApiRequestError) {
    // Undocumented errors and malformed responses.
    return true;
  }
  return HttpClassifier.isTransient(error);
}

/// The resilience policies protecting pub.dev's external dependencies.
///
/// Each dependency is modelled as a named [BoundResource] with its own circuit
/// breaker, retry budget and timeouts, so that a brownout in one dependency
/// cannot exhaust the resources of the others.
///
// TODO: none of the thresholds, deadlines or window sizes below are derived
//       from production measurements — they are plausible-looking defaults.
//       Each resource needs its numbers picked from the observed latency and
//       error rate of the dependency it guards before this is switched on.
final class PubResilience {
  /// How often [reportMetrics] writes the metrics of every resource to the log.
  static const _reportInterval = Duration(minutes: 1);

  /// The context owning the circuit state of every resource below.
  final ResilienceContext context;

  StreamSubscription<ResilienceEvent>? _subscription;
  Timer? _reportTimer;

  PubResilience._(this.context);

  /// Creates the resilience policies and starts reporting their events and
  /// metrics to the log.
  ///
  /// The number of tracked resources is bounded, so dynamically named resources
  /// (for example one per upstream host) cannot grow without limit.
  factory PubResilience.create() {
    final rs = PubResilience._(ResilienceContext(maxResources: 1024));
    rs._startLogging();
    rs._startReporting();
    return rs;
  }

  /// Google Cloud Storage, covering every bucket pub.dev reads or writes.
  ///
  /// Retries follow the Cloud Storage retry strategy, while the circuit breaker
  /// ignores client errors such as the `404`s that `Bucket.tryInfo` relies on.
  late final BoundResource cloudStorage = context.resource(
    'cloud-storage',
    config: httpResourceConfig(
      circuitBreaker: CircuitBreakerConfig(
        consecutiveFailuresThreshold: 10,
        resetTimeout: const Duration(seconds: 15),
      ),
      retry: RetryConfig(
        maxAttempts: 3,
        baseDelay: const Duration(seconds: 2),
        maxDelay: const Duration(seconds: 20),
      ),
      failureClassifier: isGcpBackendFailure,
      statusCodeExtractor: gcpStatusCode,
    ),
  );

  /// The versioned search service instance.
  ///
  /// Search is on the critical path of page rendering, so an unhealthy search
  /// service must fail fast and let the caller fall back rather than hold on to
  /// frontend isolates.
  late final BoundResource searchService = context.resource(
    'search-service',
    config: _searchServiceConfig(),
  );

  /// The unversioned search service instance, used while a new version is
  /// starting up.
  late final BoundResource fallbackSearchService = context.resource(
    'search-service-fallback',
    config: _searchServiceConfig(),
  );

  /// The redis instance backing `package:pub_dev/shared/redis_cache.dart`.
  ///
  /// A single page render performs a double-digit number of cache lookups, so
  /// when redis is unavailable the per-lookup timeouts dominate the latency of
  /// every request. Failing fast turns that into a plain cache miss.
  late final BoundResource redisCache = context.resource(
    'redis-cache',
    circuitBreaker: CircuitBreakerConfig(
      consecutiveFailuresThreshold: 5,
      resetTimeout: const Duration(seconds: 5),
      halfOpenSuccessThreshold: 1,
    ),
    // A cache lookup is never retried: the whole point of the cache is to be
    // faster than the source of truth.
    retry: RetryConfig(maxAttempts: 1),
  );

  /// The GCP Secret Manager API.
  ///
  /// Secrets are cached for an hour, so this resource sees a handful of calls
  /// per hour per instance. A time-based failure window would never reach
  /// `minimumNumberOfCalls`, hence the count-based window over the last few
  /// calls.
  ///
  // TODO: `attemptTimeout`, `timeout` and the window size are guesses, not
  //       measurements. The previous `withRetryHttpClient` path set no timeout
  //       at all. A secret lookup failing means we degrade without the secret
  //       (see `GcpSecretBackend._lookup`), so a too-short deadline here is a
  //       silent feature outage rather than a visible error — check the real
  //       Secret Manager latency before trusting these.
  late final BoundResource secretManager = context.resource(
    'secret-manager',
    config: httpResourceConfig(
      circuitBreaker: CircuitBreakerConfig(
        consecutiveFailuresThreshold: 3,
        slidingWindowType: SlidingWindowType.count,
        slidingWindowSize: 6,
        minimumNumberOfCalls: 6,
        failureRateThreshold: 0.5,
        resetTimeout: const Duration(minutes: 1),
      ),
      retry: RetryConfig(maxAttempts: 3),
      attemptTimeout: const Duration(seconds: 10),
      timeout: const Duration(seconds: 30),
      statusCodeExtractor: gcpStatusCode,
    ),
  );

  // TODO: the deadlines below are guesses, they are not derived from measured
  //       search service latency. They are also new behaviour: the previous
  //       `withRetryHttpClient` path set no timeout at all, so a slow search
  //       response used to be waited out rather than abandoned. Pick these from
  //       the p99 of `/search` before relying on them, and note that
  //       `attemptTimeout` below the real p99 turns a slow backend into a
  //       self-inflicted outage.
  static ResourceConfig _searchServiceConfig() => httpResourceConfig(
    circuitBreaker: CircuitBreakerConfig(
      consecutiveFailuresThreshold: 5,
      resetTimeout: const Duration(seconds: 10),
      failureRateThreshold: 0.5,
      minimumNumberOfCalls: 20,
      slidingWindowDuration: const Duration(seconds: 30),
    ),
    retry: RetryConfig(
      maxAttempts: 3,
      baseDelay: const Duration(milliseconds: 100),
      maxDelay: const Duration(seconds: 2),
    ),
    // A stalled attempt is abandoned and retried instead of consuming the
    // entire deadline.
    attemptTimeout: const Duration(seconds: 4),
    timeout: const Duration(seconds: 10),
  );

  void _startLogging() {
    _subscription = context.events.listen((event) {
      switch (event) {
        case CircuitBreakerStateChangedEvent(
          :final resourceName,
          :final previousState,
          :final newState,
        ):
          final message =
              'Circuit breaker for `$resourceName` moved from '
              '`${previousState.name}` to `${newState.name}`.';
          if (newState == CircuitState.open) {
            _logger.pubNoticeShout('circuit-breaker', message);
          } else {
            _logger.info(message);
          }
        case RequestThrottledEvent(:final resourceName, :final criticality):
          _logger.pubNoticeWarning(
            'adaptive-throttling',
            'Shed a `${criticality.name}` request to `$resourceName`.',
          );
        case RetryAttemptEvent(
          :final resourceName,
          :final attemptNumber,
          :final error,
        ):
          _logger.info(
            'Retrying `$resourceName` (attempt $attemptNumber): $error',
          );
        case HedgeFiredEvent():
        case OperationCompletedEvent():
        // Not interesting for the log.
      }
    });
  }

  /// The resources whose metrics are written to the log by [reportMetrics].
  ///
  /// Listed explicitly rather than enumerated from the context so that a
  /// resource created dynamically at runtime cannot start a new log series.
  late final List<BoundResource> _reportedResources = [
    cloudStorage,
    searchService,
    fallbackSearchService,
    redisCache,
    secretManager,
  ];

  /// The `circuitOpens` total of each resource at the previous report, used to
  /// turn a monotonic counter into a per-interval rate.
  final _previousCircuitOpens = <String, int>{};

  void _startReporting() {
    _reportTimer = Timer.periodic(_reportInterval, (_) => reportMetrics());
  }

  /// Writes one structured line per resource, and notices any resource whose
  /// circuit opened more than once since the previous report.
  ///
  /// The counters are cumulative, so a rate is the difference between two of
  /// these lines. That is what makes the numbers meaningful across instances:
  /// each AppEngine instance keeps its own circuit state, and only differences
  /// of monotonic counters can be summed over a fleet.
  ///
  /// Repeated opening is reported separately from opening because it is a
  /// different failure: a circuit that opens and recovers twenty times an hour
  /// is never observed open, but is degrading every request that hits it while
  /// it is.
  ///
  // TODO: the snapshot is encoded as a JSON string inside the log message, so a
  //       log-based metric has to pull values back out with a regex. It could
  //       be a real `jsonPayload` instead: outside a request handler
  //       `setupAppEngineLogging` already prints structured JSON to stdout, and
  //       `LogRecord.object` carries a non-`String` message all the way there.
  //       Inside a request handler the appengine logging service only accepts a
  //       string, so such a payload would silently degrade to text — which is
  //       why this is not done here.
  void reportMetrics() {
    for (final boundResource in _reportedResources) {
      final snapshot = boundResource.getSnapshot();
      _logger.info('[resilience] ${json.encode(snapshot.toJson())}');

      final opens = snapshot.counters.circuitOpens;
      final previous = _previousCircuitOpens[snapshot.resourceName] ?? 0;
      _previousCircuitOpens[snapshot.resourceName] = opens;
      if (opens - previous > 1) {
        _logger.pubNoticeWarning(
          'circuit-flapping',
          'Circuit breaker for `${snapshot.resourceName}` opened '
              '${opens - previous} times in the last $_reportInterval.',
        );
      }
    }
  }

  /// Stops reporting events and metrics, and releases the tracked circuit
  /// state.
  Future<void> close() async {
    _reportTimer?.cancel();
    _reportTimer = null;
    await _subscription?.cancel();
    _subscription = null;
    context.dispose();
  }
}
