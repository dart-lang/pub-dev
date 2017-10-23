// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'dart:isolate';
import 'package:logging/logging.dart';

import 'configuration.dart';
import 'handlers.dart';
import 'task_client.dart';

Future startIsolates(
    Logger logger, void entryPoint(List<SendPort> ports)) async {
  final errorReceivePort = new ReceivePort();

  Future startIsolate() async {
    logger.info('About to start isolate...');
    final mainReceivePort = new ReceivePort();
    final statsReceivePort = new ReceivePort();
    await Isolate.spawn(
      entryPoint,
      [mainReceivePort.sendPort, statsReceivePort.sendPort],
      onError: errorReceivePort.sendPort,
      onExit: errorReceivePort.sendPort,
      errorsAreFatal: true,
    );
    final List<SendPort> sendPorts = await mainReceivePort.take(1).toList();
    registerTaskSendPort(sendPorts[0]);
    registerSchedulerStatsStream(statsReceivePort as Stream<Map>);
    logger.info('Isolate started.');
  }

  errorReceivePort.listen((e) async {
    logger.severe('ERROR from isolate', e);
    // restart isolate after a brief pause
    await new Future.delayed(new Duration(minutes: 1));
    logger.warning('Restarting isolate...');
    await startIsolate();
  });

  for (var i = 0; i < envConfig.isolateCount; i++) {
    await startIsolate();
  }
}
