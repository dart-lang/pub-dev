// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:_pub_shared/pubapi.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
import 'package:puppeteer/puppeteer.dart';

@sealed
abstract class TestContext {
  /// `PUB_HOSTED_URL` for the server to be tested.
  String get pubHostedUrl;

  /// An [http.Client] that can be used for making requests.
  ///
  /// This [client] will not retry failed requests, it is the responsibility to
  /// retry requests.
  http.Client get client;

  /// A API client for accessing the API without authentication.
  PubApiClient get publicApi;

  /// A API client for accessing the API with admin authentication.
  ///
  /// Using this [PubApiClient] is equivalent to making a request authenticated
  /// with [adminServiceAccount].
  PubApiClient get adminApi;

  /// Service account that can call admin API on pub.dev
  TestServiceAccount get adminServiceAccount;

  /// A user that can be used for testing.
  ///
  /// This user is owner of testPackage;
  TestUser get userA;

  /// A user that can be used for testing.
  TestUser get userB;

  /// Name of a package that is owned by [userA], and which may be used for
  /// testing.
  String get testPackage => '_dummy_pkg';

  /// Temporary directory which will be deleted after test are completed.
  String get tempDir;

  /// Path to the Dart SDK root folder to be used for testing.
  String get dartSdkRoot;
}

@sealed
abstract class TestServiceAccount {
  /// Get the identifier for this service account.
  String get email;

  /// Get `id_token` impersonating this service account with audience set to
  /// `https://pub.dev`.
  ///
  /// Valid for at-least 30 minutes.
  Future<String> getIdToken();
}

typedef WithBrowserPageCallbackFn = Future<T> Function<T>(
    Future<T> Function(Page page) fn);
typedef ReadLatestEmailFn = FutureOr<String> Function();
typedef CreateCredentialsFn = FutureOr<Map<String, Object?>> Function();

@sealed
class TestUser {
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

@sealed
class TestScenario {
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
