// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:pub_dev/task/backend.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:pub_worker/pana_report.dart';
import 'package:pub_worker/payload.dart';
import 'package:pub_worker/src/upload.dart' show upload;
import 'package:test/test.dart';

import '../shared/test_services.dart';

Future<void> delay({
  int days = 0,
  int hours = 0,
  int minutes = 0,
  int seconds = 0,
  int milliseconds = 0,
}) =>
    Future.delayed(Duration(
      days: days,
      hours: hours,
      minutes: minutes,
      seconds: seconds,
      milliseconds: milliseconds,
    ));

extension on FakeCloudInstance {
  /// First argument is always a JSON blob with the [Payload].
  Payload get payload =>
      Payload.fromJson(json.decode(arguments.first) as Map<String, dynamic>);
}

/// Get hold of the [FakeCloudCompute]
FakeCloudCompute get cloud => taskWorkerCloudCompute as FakeCloudCompute;

void main() {
  testWithFakeTime('tasks can scheduled and processed', (fakeTime) async {
    await taskBackend.backfillTrackingState();
    await fakeTime.elapse(minutes: 1);

    await taskBackend.start();
    await fakeTime.elapse(minutes: 5);

    // 5 minutes after start of scheduling we expect there to be 3 instances
    final instances = await cloud.listInstances().toList();
    expect(instances, hasLength(3));

    for (final instance in instances) {
      cloud.fakeStartInstance(instance.instanceName);
    }

    await fakeTime.elapse(minutes: 5);

    for (final instance in instances) {
      final payload = instance.payload;

      for (final v in payload.versions) {
        // Use token to get the upload information
        final api = createPubApiClient(authToken: v.token);
        final uploadInfo = await api.taskUploadResult(
          payload.package,
          v.version,
        );

        // Upload the minimum result, log file and empty pana-report
        final c = http.Client();
        try {
          await upload(
            c,
            uploadInfo.panaLog,
            utf8.encode('This is a pana log file'),
            filename: 'pana-log.txt',
            contentType: 'text/plain',
          );
          await upload(
            c,
            uploadInfo.panaReport,
            utf8.encode(json.encode(PanaReport(
              logId: uploadInfo.panaLogId,
              summary: null,
            ))),
            filename: 'pana-summary.json',
            contentType: 'application/json',
          );
        } finally {
          c.close();
        }

        // Report the task as finished
        await api.taskUploadFinished(payload.package, v.version);
      }
    }

    await fakeTime.elapse(minutes: 5);

    // All instances should be terminated, api.taskUploadFinished terminate
    // when all versions for the instance is done. And fake instances take 1
    // minute to simulate termination.
    expect(await cloud.listInstances().toList(), hasLength(0));

    await taskBackend.stop();

    await fakeTime.elapse(minutes: 10);
  });
}
