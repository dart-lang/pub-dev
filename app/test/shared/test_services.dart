// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:fake_gcloud/mem_datastore.dart';
import 'package:fake_gcloud/mem_storage.dart';
import 'package:gcloud/db.dart';
import 'package:gcloud/service_scope.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/fake/backend/fake_auth_provider.dart';
import 'package:pub_dev/fake/backend/fake_download_counts.dart';
import 'package:pub_dev/fake/backend/fake_email_sender.dart';
import 'package:pub_dev/fake/backend/fake_pub_worker.dart';
import 'package:pub_dev/frontend/handlers/pubapi.client.dart';
import 'package:pub_dev/frontend/static_files.dart';
import 'package:pub_dev/package/name_tracker.dart';
import 'package:pub_dev/search/top_packages.dart';
import 'package:pub_dev/search/updater.dart';
import 'package:pub_dev/service/async_queue/async_queue.dart';
import 'package:pub_dev/service/services.dart';
import 'package:pub_dev/service/youtube/backend.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/integrity.dart';
import 'package:pub_dev/shared/logging.dart';
import 'package:pub_dev/shared/redis_cache.dart';
import 'package:pub_dev/shared/versions.dart';
import 'package:pub_dev/task/clock_control.dart';
import 'package:pub_dev/task/cloudcompute/fakecloudcompute.dart';
import 'package:pub_dev/task/global_lock.dart';
import 'package:pub_dev/tool/neat_task/pub_dev_tasks.dart';
import 'package:pub_dev/tool/test_profile/import_source.dart';
import 'package:pub_dev/tool/test_profile/importer.dart';
import 'package:pub_dev/tool/test_profile/models.dart';
import 'package:pub_dev/tool/utils/pub_api_client.dart';
import 'package:test/test.dart';

import '../shared/utils.dart';
import 'handlers_test_utils.dart';
import 'test_models.dart';

export 'package:pub_dev/tool/utils/pub_api_client.dart';

void _registerClockControl(ClockController clockControl) =>
    register(#_clockControl, clockControl);

/// Get [ClockController] for manipulating time.
///
/// This is only valid inside [testWithProfile].
ClockController get clockControl => lookup(#_clockControl) as ClockController;

/// Create a [StaticFileCache] for reuse when testing.
// TODO: Find out if there are any downsides to doing this, and make forTests()
//       a factory constructor that always returns the same value.
//       Further consider cleanup of [StaticFileCache] to avoid computing hashes
//       when they are discarded during tests. And always load concurrently!
final _staticFileCacheForTesting = StaticFileCache.forTests();

/// Wraps [fn] in a new service scope with runtime versions and related initializations.
Future<void> withRuntimeVersions(
  List<String> versions,
  Future Function() fn,
) async {
  await fork(() async {
    registerAcceptedRuntimeVersions(versions);
    await setupCache();
    await fn();
  });
}

/// The stored and shared state of the appengine context (including datastore,
/// storage and cloud compute).
final class FakeAppengineEnv {
  final _storage = MemStorage();
  final _datastore = MemDatastore();
  final _cloudCompute = FakeCloudCompute();

  /// Create a service scope with fake services and run [fn] in it.
  ///
  /// All services will terminate when [fn] returns.
  ///
  /// Calling [run] more than once, is allowed. Services will not survive between
  /// invocations, but datastore, storage and cloud compute will retain state.
  Future<R> run<R>(
    Future<R> Function() fn, {
    TestProfile? testProfile,
    ImportSource? importSource,
    bool processJobsWithFakeRunners = false,
    Pattern? integrityProblem,
    List<String>? runtimeVersions,
  }) async {
    return await fork(() async {
      if (runtimeVersions != null) {
        registerAcceptedRuntimeVersions(runtimeVersions);
      }
      return await withClockControl((clockControl) async {
        _registerClockControl(clockControl);
        return await withFakeServices(
          datastore: _datastore,
          storage: _storage,
          cloudCompute: _cloudCompute,
          fn: () async {
            registerStaticFileCacheForTest(_staticFileCacheForTesting);

            if (testProfile != null) {
              await importProfile(
                profile: testProfile,
                source: importSource,
              );
            }
            if (processJobsWithFakeRunners) {
              await generateFakeDownloadCountsInDatastore();
              await processTasksWithFakePanaAndDartdoc();
            }
            await nameTracker.reloadFromDatastore();
            await indexUpdater.updateAllPackages();
            await topPackages.start();
            await youtubeBackend.start();
            await asyncQueue.ongoingProcessing;
            fakeEmailSender.sentMessages.clear();

            await fork(() async {
              await fn();
            });
            await _postTestVerification(integrityProblem: integrityProblem);
          },
        );
      });
    }) as R;
  }
}

Future<void> _postTestVerification({
  required Pattern? integrityProblem,
}) async {
  final problems = await IntegrityChecker(dbService).findProblems().toList();
  if (problems.isNotEmpty &&
      (integrityProblem == null ||
          integrityProblem.matchAsPrefix(problems.first) == null)) {
    throw Exception(
        '${problems.length} integrity problems detected. First: ${problems.first}');
  } else if (problems.isEmpty && integrityProblem != null) {
    throw Exception('Integrity problem expected but not present.');
  }

  // run all background tasks here
  final schedulers = createPeriodicTaskSchedulers(isPostTestVerification: true);
  for (final scheduler in schedulers) {
    await scheduler.trigger();
  }

  // re-run integrity checks on the updated state
  final laterProblems =
      await IntegrityChecker(dbService).findProblems().toList();
  expect(laterProblems, problems);
}

/// Registers test with [name] and runs it in pkg/fake_gcloud's scope, populated
/// with [testProfile] data.
@isTest
void testWithProfile(
  String name, {
  TestProfile? testProfile,
  ImportSource? importSource,
  required Future<void> Function() fn,
  Timeout? timeout,
  bool processJobsWithFakeRunners = false,
  Pattern? integrityProblem,
  Iterable<Pattern>? expectedLogMessages,
  dynamic skip,
}) {
  final env = FakeAppengineEnv();

  scopedTest(
    name,
    () async {
      setupDebugEnvBasedLogging();
      await env.run(
        fn,
        testProfile: testProfile ?? defaultTestProfile,
        importSource: importSource,
        processJobsWithFakeRunners: processJobsWithFakeRunners,
        integrityProblem: integrityProblem,
      );
    },
    expectedLogMessages: expectedLogMessages,
    timeout: timeout,
    skip: skip,
  );
}

void setupTestsWithCallerAuthorizationIssues(
    Future Function(PubApiClient client) fn) {
  testWithProfile('No active user', fn: () async {
    final rs = fn(createPubApiClient());
    await expectApiException(rs, status: 401, code: 'MissingAuthentication');
  });

  testWithProfile('Active user is not authorized', fn: () async {
    final rs =
        fn(await createFakeAuthPubApiClient(email: 'unauthorized@pub.dev'));
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });

  testWithProfile('Active user is moderated', fn: () async {
    final users = await dbService.query<User>().run().toList();
    final user = users.firstWhere((u) => u.email == 'admin@pub.dev');
    final client = await createFakeAuthPubApiClient(email: adminAtPubDevEmail);
    await dbService.commit(inserts: [
      user
        ..isModerated = true
        ..moderatedAt = clock.now()
    ]);
    final rs = fn(client);
    await expectApiException(rs,
        status: 401, code: 'MissingAuthentication', message: 'failed');
  });
}

/// Creates generic test cases for admin API operations with failure expectations
/// (e.g. missing or wrong authentication).
void setupTestsWithAdminTokenIssues(Future Function(PubApiClient client) fn) {
  testWithProfile('No active user', fn: () async {
    final rs = fn(createPubApiClient());
    await expectApiException(rs, status: 401, code: 'MissingAuthentication');
  });

  testWithProfile('Regular user token from the client.', fn: () async {
    final token = createFakeAuthTokenForEmail(
      'unauthorized@pub.dev',
      audience: activeConfiguration.pubClientAudience,
    );
    final rs = fn(createPubApiClient(authToken: token));
    await expectApiException(rs, status: 401, code: 'MissingAuthentication');
  });

  testWithProfile('Regular user token from the website.', fn: () async {
    final token = createFakeAuthTokenForEmail(
      'unauthorized@pub.dev',
      audience: activeConfiguration.pubServerAudience,
    );
    final rs = fn(createPubApiClient(authToken: token));
    await expectApiException(rs, status: 401, code: 'MissingAuthentication');
  });

  testWithProfile('Regular user token with external audience.', fn: () async {
    final token = createFakeAuthTokenForEmail(
      'unauthorized@pub.dev',
      audience: activeConfiguration.externalServiceAudience,
    );
    final rs = fn(createPubApiClient(authToken: token));
    await expectApiException(rs, status: 401, code: 'MissingAuthentication');
  });

  testWithProfile('Non-admin service agent token', fn: () async {
    final token = createFakeServiceAccountToken(
        email: 'unauthorized@pub.dev', audience: 'https://pub.dev');
    final rs = fn(createPubApiClient(authToken: token));
    await expectApiException(rs, status: 403, code: 'InsufficientPermissions');
  });
}

class FakeGlobalLockClaim implements GlobalLockClaim {
  @override
  DateTime expires;

  FakeGlobalLockClaim(this.expires);

  @override
  Future<bool> refresh() async {
    return true;
  }

  @override
  Future<void> release() async {}

  @override
  bool get valid => expires.isAfter(clock.now());
}
