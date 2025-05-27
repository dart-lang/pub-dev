// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/search/sdk_mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/updater.dart';
import 'package:pub_dev/service/entrypoint/_isolate.dart';
import 'package:pub_dev/service/entrypoint/logging.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:pub_dev/shared/logging.dart';
import 'package:pub_dev/shared/monitoring.dart';
import 'package:pub_dev/shared/utils.dart';

final _logger = Logger('search_index');

/// Entry point for the search index isolate.
Future<void> main(List<String> args, var message) async {
  final timer = Timer.periodic(Duration(milliseconds: 250), (_) {});

  final ServicesWrapperFn servicesWrapperFn;
  if (envConfig.isRunningInAppengine) {
    servicesWrapperFn = withServices;
    setupAppEngineLogging();
  } else {
    servicesWrapperFn = (fn) => withFakeServices(fn: fn);
    setupDebugEnvBasedLogging();
  }
  await fork(() async {
    await servicesWrapperFn(() async {
      registerSdkMemIndex(await createSdkMemIndex());
      await indexUpdater.init();

      await runIsolateFunctions(
        message: message,
        logger: _logger,
        fn: (payload) async {
          if (payload is String && payload == 'info') {
            final info = await searchIndex.indexInfo();
            return ReplyMessage.result(info.toJson());
          } else if (payload is String) {
            final q = ServiceSearchQuery.fromServiceUrl(Uri.parse(payload));
            final rs = await searchIndex.search(q);
            return ReplyMessage.result(json.encode(rs.toJson()));
          } else {
            _logger.pubNoticeShout(
                'unknown-isolate-message', 'Unrecognized payload: $payload');
            return ReplyMessage.error('Unrecognized payload: $payload');
          }
        },
      );
    });
  });

  timer.cancel();
}

/// Implementation of [SearchIndex] that uses [RequestMessage]s to send requests
/// across isolate boundaries. The instance should be registered inside the
/// `frontend` isolate, and it calls the `index` isolate as a delegate.
class IsolateSearchIndex implements SearchIndex {
  final IsolateRunner _runner;
  IsolateSearchIndex(this._runner);
  var _isReady = false;

  @override
  FutureOr<bool> isReady() async {
    // Set the ready flag once, and after the first time always return as ready.
    if (!_isReady) {
      final info = await indexInfo();
      _isReady = info.isReady;
    }
    return _isReady;
  }

  @override
  FutureOr<IndexInfo> indexInfo() async {
    try {
      final info = await _runner.sendRequest(
        'info',
        timeout: Duration(seconds: 5),
      );
      return IndexInfo.fromJson(info as Map<String, dynamic>);
    } catch (e, st) {
      _logger.warning('Failed to get index info.', e, st);
    }
    return IndexInfo(
      isReady: false,
      packageCount: 0,
      lastUpdated: null,
    );
  }

  @override
  FutureOr<PackageSearchResult> search(ServiceSearchQuery query) async {
    try {
      final rs = await _runner.sendRequest(
        Uri(queryParameters: query.toUriQueryParameters()).toString(),
        timeout: Duration(minutes: 1),
      );
      return PackageSearchResult.fromJson(
          json.decode(rs as String) as Map<String, dynamic>);
    } catch (e, st) {
      _logger.warning('Failed to search index.', e, st);
    }
    return PackageSearchResult.error(
      errorMessage: 'Failed to process request.',
      statusCode: 500,
    );
  }
}

/// A search index that adjusts the extent of the text matching based on the
/// observed recent latency (adjusted with a 1-minute half-life decay).
class LatencyAwareSearchIndex implements SearchIndex {
  final SearchIndex _delegate;
  final _latencyTracker = DecayingMaxLatencyTracker();

  LatencyAwareSearchIndex(this._delegate);

  @override
  FutureOr<IndexInfo> indexInfo() => _delegate.indexInfo();

  @override
  FutureOr<bool> isReady() => _delegate.isReady();

  @override
  Future<PackageSearchResult> search(ServiceSearchQuery query) async {
    final sw = Stopwatch()..start();
    try {
      return await _delegate.search(query.change(
        textMatchExtent: _selectTextMatchExtent(),
      ));
    } finally {
      sw.stop();
      final elapsed = sw.elapsed;
      // Note: The maximum latency value here limits how long an outlier
      //       processing will affect later queries. With the current 1-minute
      //       decay half-life, it will allow:
      //       - name-only search after about 2.5 minutes,
      //       - descriptions after 4 minutes,
      //       - readmes after 6 minutes,
      //       - everything after 7 minutes.
      _latencyTracker.observe(
          elapsed.inMinutes >= 1 ? const Duration(minutes: 1) : elapsed);
    }
  }

  /// Selects the text match extent value based on the recent maximum latency.
  ///
  /// Note: the latency here may be a residue of a large spike that happened
  ///       more than a few minute ago, therefore we are deciding on latency
  ///       range over the default 5 seconds timeout window.
  TextMatchExtent _selectTextMatchExtent() {
    final latency = _latencyTracker.getLatency();
    if (latency < const Duration(seconds: 1)) {
      _logger.info('[text-match-normal]');
      return TextMatchExtent.api;
    }
    if (latency < const Duration(seconds: 2)) {
      _logger.info('[text-match-readme]');
      return TextMatchExtent.readme;
    }
    if (latency < const Duration(seconds: 4)) {
      _logger.info('[text-match-description]');
      // TODO: use `TextMatchExtent.description` after we are confident about this change.
      return TextMatchExtent.readme;
    }
    if (latency < const Duration(seconds: 10)) {
      _logger.info('[text-match-name]');
      // TODO: use `TextMatchExtent.name` after we are confident about this change.
      return TextMatchExtent.readme;
    }
    // TODO: use `TextMatchExtent.none` after we are confident about this change.
    _logger.info('[text-match-none]');
    return TextMatchExtent.readme;
  }
}
