// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:math';

import 'package:args/command_runner.dart';
import 'package:gcloud/service_scope.dart';
import 'package:logging/logging.dart';
import 'package:pub_dev/search/result_combiner.dart';
import 'package:pub_dev/service/entrypoint/sdk_isolate_index.dart';
import 'package:pub_dev/service/entrypoint/search_index.dart';
import 'package:shelf/shelf.dart';

import '../../search/backend.dart';
import '../../search/handlers.dart';
import '../../service/services.dart';
import '../../shared/env_config.dart';
import '../../shared/handler_helpers.dart';

import '_isolate.dart';

final Logger _logger = Logger('pub.search');
final _random = Random.secure();

class SearchCommand extends Command {
  @override
  String get name => 'search';

  @override
  String get description => 'The search service entrypoint.';

  @override
  Future<void> run() async {
    // An instance-specific additional drift, to make sure that the index updates
    // are stretched out over time.
    final delayDrift = _random.nextInt(60);

    envConfig.checkServiceEnvironment(name);
    await withServices(() async {
      await runSearchInstanceController(
        port: 8080,
        renewPackageIndex: _createRenewStream(delayDrift: delayDrift),
      );
    });
  }
}

/// Creates a stream with events separated by 12 - 17 minutes
Stream<Completer> _createRenewStream({required int delayDrift}) {
  return Stream.periodic(Duration(minutes: 12), (_) => Completer()).asyncMap(
    (c) => Future.delayed(
      Duration(seconds: delayDrift + _random.nextInt(240)),
      () => c,
    ),
  );
}

/// Runs the search instance main controller, which creates separate isolates
/// for the package and the SDK indexes.
///
/// When the [renewPackageIndex] has a new event, it will trigger the renewal of the
/// package index isolate, updating the search index.
Future<void> runSearchInstanceController({
  required int port,
  required Stream<Completer> renewPackageIndex,
  Duration renewWait = const Duration(minutes: 2),
  String? snapshot,
  Handler? handler,
  Future<void> Function()? processTerminationSignal,
}) async {
  final packageIsolate = await startSearchIsolate(
    logger: _logger,
    snapshot: snapshot,
  );
  registerScopeExitCallback(packageIsolate.close);

  final sdkIsolate = await startQueryIsolate(
    logger: _logger,
    kind: 'sdk',
    spawnUri: Uri.parse(
      'package:pub_dev/service/entrypoint/sdk_isolate_index.dart',
    ),
  );
  registerScopeExitCallback(sdkIsolate.close);

  registerSearchIndex(
    SearchResultCombiner(
      primaryIndex: LatencyAwareSearchIndex(IsolateSearchIndex(packageIsolate)),
      sdkIndex: SdkIsolateIndex(sdkIsolate),
    ),
  );

  final updateStream = renewPackageIndex.asyncMap((c) async {
    try {
      // create a new index and handover with a 2-minute maximum wait
      await packageIsolate.renew(count: 1, wait: renewWait);
      c.complete(null);
    } catch (e, st) {
      c.completeError(e, st);
    }
  });
  final updateListener = updateStream.listen((_) {
    _logger.info('Package SDK isolate renewed.');
  });

  await runHandler(
    _logger,
    handler ?? searchServiceHandler,
    port: port,
    processTerminationSignal: processTerminationSignal,
  );
  await updateListener.cancel();
}
