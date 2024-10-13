// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/search/backend.dart';
import 'package:pub_dev/search/dart_sdk_mem_index.dart';
import 'package:pub_dev/search/flutter_sdk_mem_index.dart';
import 'package:pub_dev/search/search_service.dart';
import 'package:pub_dev/search/updater.dart';
import 'package:pub_dev/service/entrypoint/_isolate.dart';
import 'package:pub_dev/service/entrypoint/logging.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:pub_dev/shared/logging.dart';
import 'package:pub_dev/shared/monitoring.dart';

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
      registerDartSdkMemIndex(await createDartSdkMemIndex());
      registerFlutterSdkMemIndex(await createFlutterSdkMemIndex());
      await indexUpdater.init();

      final requestReceivePort = ReceivePort();
      final entryMessage = Message.fromObject(message) as EntryMessage;

      final subs = requestReceivePort.listen((e) async {
        try {
          final msg = Message.fromObject(e) as RequestMessage;
          final payload = msg.payload;
          if (payload is String && payload == 'info') {
            final info = await searchIndex.indexInfo();
            msg.replyPort
                .send(ReplyMessage.result(info.toJson()).encodeAsJson());
            return;
          } else if (payload is String) {
            final q = ServiceSearchQuery.fromServiceUrl(Uri.parse(payload));
            final rs = await searchIndex.search(q);
            msg.replyPort.send(
                ReplyMessage.result(json.encode(rs.toJson())).encodeAsJson());
            return;
          } else {
            _logger.pubNoticeShout(
                'unknown-isolate-message', 'Unrecognized payload: $msg');
            msg.replyPort.send(ReplyMessage.error('Unrecognized payload: $msg')
                .encodeAsJson());
          }
        } catch (e, st) {
          _logger.pubNoticeShout(
              'isolate-message-error', 'Error processing message: $e', e, st);
        }
      });
      entryMessage.protocolSendPort.send(
        ReadyMessage(requestSendPort: requestReceivePort.sendPort)
            .encodeAsJson(),
      );

      await Completer().future;
      requestReceivePort.close();
      await subs.cancel();
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
