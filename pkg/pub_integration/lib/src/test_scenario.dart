// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/pubapi.dart';
import 'package:http/http.dart' as http;
import 'package:puppeteer/puppeteer.dart';

/// Interface that provides all the information and access required to run an
/// integration [TestScenario].
final class TestContext {
  TestContext({
    required this.pubHostedUrl,
    required this.client,
    required this.publicApi,
    required this.adminApi,
    required this.adminServiceAccount,
    required this.userA,
    required this.userB,
    required this.testPackage,
    required this.tempDir,
    required this.dartSdkRoot,
  });

  /// `PUB_HOSTED_URL` for the server to be tested.
  final String pubHostedUrl;

  /// An [http.Client] that can be used for making requests.
  ///
  /// This [client] will not retry failed requests, it is the responsibility to
  /// retry requests.
  final http.Client client;

  /// A API client for accessing the API without authentication.
  final PubApiClient publicApi;

  /// A API client for accessing the API with admin authentication.
  ///
  /// Using this [PubApiClient] is equivalent to making a request authenticated
  /// with [adminServiceAccount].
  final PubApiClient adminApi;

  /// Service account that can call admin API on pub.dev
  final TestServiceAccount adminServiceAccount;

  /// A user that can be used for testing.
  ///
  /// This user is owner of testPackage;
  final TestUser userA;

  /// A user that can be used for testing.
  final TestUser userB;

  /// Name of a package that is owned by [userA], and which may be used for
  /// testing.
  final String testPackage;

  /// Temporary directory which will be deleted after test are completed.
  final String tempDir;

  /// Path to the Dart SDK root folder to be used for testing.
  final String dartSdkRoot;
}

/// Interface that provides all the information and access required to run an
/// integration [TestScenario].
final class TestServiceAccount {
  final Future<String> Function() _getIdToken;

  TestServiceAccount({
    required this.email,
    required Future<String> Function() getIdToken,
  }) : _getIdToken = getIdToken;

  /// Get the identifier for this service account.
  final String email;

  /// Get `id_token` impersonating this service account with audience set to
  /// `https://pub.dev`.
  ///
  /// Valid for at-least 30 minutes.
  Future<String> getIdToken() => _getIdToken();
}

typedef WithBrowserPageCallbackFn = Future<T> Function<T>(
    Future<T> Function(Page page) fn);
typedef ReadLatestEmailFn = FutureOr<String> Function();
typedef CreateCredentialsFn = FutureOr<Map<String, Object?>> Function();

final class TestUser {
  /// The email of the given test user.
  final String email;

  /// An API client for access the API authenticated with a session associated
  /// with this user.
  final PubApiClient api;

  /// Executes callback `fn` with the browser page where this test user is
  /// signed-in to their account.
  final WithBrowserPageCallbackFn withBrowserPage;

  /// Read the latest email sent to this test user.
  final ReadLatestEmailFn readLatestEmail;

  /// Create contents for `pub-credentials.json` for this test user.
  ///
  /// These credentials can be used by the `dart pub` client to publish packages
  /// as this test user.
  final CreateCredentialsFn createCredentials;

  TestUser({
    required this.email,
    required this.api,
    required this.withBrowserPage,
    required this.readLatestEmail,
    required this.createCredentials,
  });
}

final class TestScenario {
  /// Human readable title for this test scenario.
  final String title;

  /// Function that runs the test scenario given a [TestContext].
  final Future<void> Function(TestContext ctx) run;

  /// Create a [TestScenario] given [title] and function [run] that runs the
  /// test scenario.
  ///
  /// The [run] function should aim to leave the server in the same state as
  /// when it got it. Best effort clean up will be attempted before calling
  /// [run].
  TestScenario(this.title, this.run);
}
