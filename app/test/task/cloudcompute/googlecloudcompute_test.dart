// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

// Test is fragile because creating instances and waiting for them to start is
// slow, and something that could throw all sorts of exceptions, we don't want
// run this as part of normal testing.
@Tags(['fragile'])
library;

import 'dart:async';

import 'package:appengine/appengine.dart';
import 'package:pub_dev/shared/env_config.dart';
import 'package:pub_dev/shared/logging.dart';
import 'package:pub_dev/task/cloudcompute/cloudcompute.dart';
import 'package:pub_dev/task/cloudcompute/googlecloudcompute.dart';
import 'package:test/test.dart';

void main() {
  test('CloudCompute from createGoogleCloudCompute()', () async {
    setupDebugEnvBasedLogging();

    await withAppEngineServices(() async {
      registerCloudComputeClient(authClientService);

      // Create CloudCompute instance
      final gce = createGoogleCloudCompute(
        project: envConfig.googleCloudProject!,
        // NOTE: It's important to have a Cloud NAT for the 'default' network.
        //       This is probably only reasonable to do in a test project.
        //       In production we use a non-default network, we could also do
        //       that when testing this. It's merely a matter of setup.
        network: 'default',
        poolLabel: 'manual-testing',
        cosImage: 'projects/cos-cloud/global/images/family/cos-97-lts',
        taskWorkerServiceAccount:
            '${envConfig.googleCloudProject}@appspot.gserviceaccount.com',
        maxRunDuration: Duration(hours: 1),
      );

      // Fail if any instances exist
      var instances = await gce.listInstances().toList();
      expect(instances, isEmpty);

      // Create instance that terminates
      scheduleMicrotask(() async {
        print('creating instance');
        final instance = await gce.createInstance(
          instanceName: gce.generateInstanceName(),
          zone: gce.zones.first,
          // HACK: Remove '-u worker:2000' from googlecloudcompute.dart when
          //       running this test, or find a public docker image that
          //       contains this user+uid.
          // We could also make the user configurable, but for now we just this
          // limitation, and hack around it when we do manual testing.
          dockerImage: 'busybox:1.31.1',
          arguments: [
            'sh',
            '-c',
            'whoami; date -R; sleep 5s; date -R; uname -a',
          ],
          description: 'test instance that terminates rather quickly',
        );
        print('Created instance: ${instance.instanceName}, $instance');
      });

      // Wait until we have a terminated instance
      print('### Wait for instance to terminate on its own');
      while (!instances.any((i) => i.state == InstanceState.terminated)) {
        instances = await gce.listInstances().toList();
        print('listInstances():');
        for (final inst in instances) {
          print(' - ${inst.instanceName}, state: ${inst.state}');
        }
        await Future.delayed(Duration(seconds: 1));
      }
      // Delete instances
      print('### Delete all instances');
      for (final inst in instances) {
        await gce.delete(inst.zone, inst.instanceName);
      }

      // Wait until instances are deleted from listing
      print('### Wait for instance to disappear from listings');
      while (instances.isNotEmpty) {
        instances = await gce.listInstances().toList();
        print('listInstances():');
        for (final inst in instances) {
          print(' - ${inst.instanceName}, state: ${inst.state}');
        }
        await Future.delayed(Duration(seconds: 1));
      }
    });
  },
      timeout: Timeout.parse('30m'),
      skip: envConfig.googleCloudProject == null ||
              // Avoid running against production by accident
              envConfig.googleCloudProject == 'dartlang-pub'
          ? 'createGoogleCloudCompute testing requires GOOGLE_CLOUD_PROJECT'
          : false);
}
