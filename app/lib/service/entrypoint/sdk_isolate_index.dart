// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/service/entrypoint/logging.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:pub_dev/shared/logging.dart';

import '../../../service/entrypoint/_isolate.dart';

import '../../search/sdk_mem_index.dart';
import '../../search/search_service.dart';

final _logger = Logger('sdk_search_index');

/// Entry point for the SDK search index isolate.
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
      final sdkMemIndex = await createSdkMemIndex();
      await runIsolateFunctions(
          message: message,
          logger: _logger,
          fn: (payload) async {
            final args = payload as List;
            final rs = sdkMemIndex!.search(
              args[0] as String,
              limit: args[1] as int?,
              skipFlutter: args[2] as bool,
            );
            return ReplyMessage.result(rs.map((e) => e.toJson()).toList());
          });
    });
  });

  timer.cancel();
}

/// Implementation of [SdkMemIndex] that uses [RequestMessage]s to send requests
/// across isolate boundaries. The instance should be registered inside the
/// `frontend` isolate, and it calls the `sdk-index` isolate as a delegate.
class SdkIsolateIndex implements SdkIndex {
  final IsolateRunner _runner;
  SdkIsolateIndex(this._runner);

  @override
  Future<List<SdkLibraryHit>> search(
    String query, {
    int? limit,
    bool skipFlutter = false,
  }) async {
    try {
      final rs = await _runner.sendRequest(
        [query, limit, skipFlutter],
        timeout: Duration(seconds: 2),
      );
      return (rs as List)
          .map((v) => SdkLibraryHit.fromJson(v as Map<String, dynamic>))
          .toList();
    } catch (e, st) {
      _logger.warning('Failed to search SDK index.', e, st);
      return <SdkLibraryHit>[];
    }
  }
}
