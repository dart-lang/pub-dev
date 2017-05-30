// Copyright (c) 2017, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:appengine/appengine.dart';

import 'package:pub_dartlang_org/analyzer_topic.dart';

import 'server_common.dart';

void main() {
  useLoggingPackageAdaptor();

  withAppEngineServices(() async {
    return withCorrectDatastore(() async {
      // Trigger idle check every minute.
      new Timer.periodic(new Duration(minutes: 1), _onIdle);

      // TODO: call await setupServices(activeConfiguration);
      // TODO: make sure AnalyzeTopic is initialized in setupServices

      for (;;) {
        _lastNonIdle = new DateTime.now();
        final AnalyzeRequest rq = await analyzerTopic.pullRequest();
        logger.info('Got AnalyzeRequest: ${rq.package} ${rq.version}');
        _processing = true;
        try {
          final Stopwatch sw = new Stopwatch()..start();
          await _analyze(rq.package, rq.version);
          sw.stop;
          logger.info('Analysis of ${rq.package} ${rq.version} completed '
              'in ${sw.elapsed.inSeconds} seconds.');
        } catch (e, st) {
          logger.severe(
              'Error while analyzing: ${rq.package} ${rq.version}', e, st);
        }
        _processing = false;
      }
    });
  });
}

Future _analyze(String package, String version) async {
  // TODO: do analyze
}

void _onIdle(_) {
  if (_idleCheckRunning) return;
  if (_processing) return;
  if (new DateTime.now().difference(_lastNonIdle).inMinutes <= 2) return;
  _idleCheckRunning = true;
  try {
    // TODO: trigger new analyzer request
  } finally {
    _idleCheckRunning = false;
    _lastNonIdle = new DateTime.now();
  }
}

DateTime _lastNonIdle = new DateTime.now();
bool _processing = false;
bool _idleCheckRunning = false;
