// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:args/command_runner.dart';
import 'package:pub_integration/src/fake_credentials.dart';
import 'package:pub_integration/src/fake_pub_server_process.dart';
import 'package:pub_integration/src/fake_test_context_provider.dart';
import 'package:pub_integration/src/pub_puppeteer_helpers.dart';
import 'package:pub_integration/src/test_browser.dart';

Future<void> main(List<String> args) async {
  final runner = CommandRunner<String>(
    'fake_user_callback',
    'Provides integration test details for fake server user authentication.',
  )
    ..addCommand(_ApiAccessTokenCommand())
    ..addCommand(_ClientCredentialsJsonCommand())
    ..addCommand(_BrowserCookiesCommand())
    ..addCommand(_LastEmailCommand());
  final rs = await runner.run(args);
  print(rs);
}

class _ApiAccessTokenCommand extends Command<String> {
  @override
  String get name => 'api-access-token';

  @override
  String get description => 'Provides API access token';

  _ApiAccessTokenCommand() {
    argParser
      ..addOption('pub-hosted-url')
      ..addOption('email');
  }

  @override
  Future<String> run() async {
    final pubHostedUrl = argResults!['pub-hosted-url'] as String;
    final email = argResults!['email'] as String;
    return await createFakeGcpToken(pubHostedUrl: pubHostedUrl, email: email);
  }
}

class _ClientCredentialsJsonCommand extends Command<String> {
  @override
  String get name => 'client-credentials-json';

  @override
  String get description =>
      'Provides pub client credentials.json file content.';

  _ClientCredentialsJsonCommand() {
    argParser.addOption('email');
  }

  @override
  Future<String> run() async {
    final email = argResults!['email'] as String;
    final map = fakeCredentialsMap(email: email);
    return json.encode(map);
  }
}

class _BrowserCookiesCommand extends Command<String> {
  @override
  String get name => 'browser-cookies';

  @override
  String get description =>
      'Provides browser cookies for the signed-in user session';

  _BrowserCookiesCommand() {
    argParser
      ..addOption('pub-hosted-url')
      ..addOption('email')
      ..addOption('scopes');
  }

  @override
  Future<String> run() async {
    final pubHostedUrl = argResults!['pub-hosted-url'] as String;
    final email = argResults!['email'] as String;
    final scopes = (argResults!['scopes'] as String?)?.split(',');
    final testBrowser = TestBrowser(
      origin: pubHostedUrl,
    );
    try {
      await testBrowser.startBrowser();
      final session = await testBrowser.createSession();
      return await session.withPage(fn: (page) async {
        await page.fakeAuthSignIn(email: email, scopes: scopes);
        await page.gotoOrigin('/my-liked-packages');
        final cookies = await page.cookies();
        return json.encode(cookies.map((e) => e.toJson()).toList());
      });
    } finally {
      await testBrowser.close();
    }
  }
}

class _LastEmailCommand extends Command<String> {
  @override
  String get name => 'last-email';

  @override
  String get description => 'Provides the last email body for the user';

  _LastEmailCommand() {
    argParser
      ..addOption('email-output-dir')
      ..addOption('email');
  }

  @override
  Future<String> run() async {
    final emailOutputDir = argResults!['email-output-dir'] as String;
    final email = argResults!['email'] as String;

    final reader = FakeEmailReaderFromOutputDirectory(emailOutputDir);
    final map = await reader.readLatestEmail(recipient: email);
    return map['bodyText'] as String;
  }
}
