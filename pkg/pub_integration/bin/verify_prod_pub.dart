// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/retry.dart' as http_retry;
import 'package:pub_integration/pub_integration.dart';
import 'package:pub_integration/src/test_browser.dart';
import 'package:puppeteer/puppeteer.dart';

final _argParser = ArgParser()
  ..addOption(
    'pub-hosted-url',
    help: 'The site (and PUB_HOSTED_URL) to use for the verification.',
    mandatory: true,
  )
  ..addUserOptions('user-a-', 'user-A', 'the package admin')
  ..addUserOptions('user-b-', 'user-B', 'the invited user');

extension on ArgParser {
  void addUserOptions(String prefix, String name, String description) {
    addOption(
      '${prefix}email',
      help: 'The email address of $name ($description)',
      mandatory: true,
    );
    addOption(
      '${prefix}api-access-token-callback',
      help: 'The command to execute to get API access token for $name',
      mandatory: true,
    );
    addOption(
      '${prefix}client-credentials-json-callback',
      help:
          'The command to execute to get pub client credentials.json content for $name',
      mandatory: true,
    );
    addOption(
      '${prefix}browser-cookies-callback',
      help:
          'The command to execute to get the browser cookies (serialized as JSON)',
      mandatory: true,
    );
    addOption(
      '${prefix}last-email-callback',
      help: 'The command to execute to read last email for $name',
      mandatory: true,
    );
  }
}

Future<void> main(List<String> arguments) async {
  final argv = _argParser.parse(arguments);
  final pubHostedUrl = argv['pub-hosted-url'] as String;
  final expectLiveSite = !pubHostedUrl.startsWith('http://localhost:');

  final browser = TestBrowser(origin: pubHostedUrl);
  try {
    await browser.startBrowser();
    await verifyPub(
      pubHostedUrl: pubHostedUrl,
      adminUser: await _initializeUser(
          browser, pubHostedUrl, _argsWithPrefix(argv, 'user-a-')),
      invitedUser: await _initializeUser(
          browser, pubHostedUrl, _argsWithPrefix(argv, 'user-b-')),
      expectLiveSite: expectLiveSite,
    );
  } finally {
    await browser.close();
  }
}

Map<String, String> _argsWithPrefix(ArgResults argv, String prefix) {
  final result = <String, String>{};
  for (final o in argv.options) {
    if (!o.startsWith(prefix)) {
      continue;
    }
    final v = argv[o].toString();
    result[o.substring(prefix.length)] = v;
  }
  return result;
}

Future<TestUser> _initializeUser(
  TestBrowser browser,
  String pubHostedUrl,
  Map<String, String> map,
) async {
  final email = map['email']!;
  final apiAccessToken = await _callback(map['api-access-token-callback']!);
  final credentialsJsonContent =
      await _callback(map['client-credentials-json-callback']!);
  final cookiesString = await _callback(map['browser-cookies-callback']!);
  List<CookieParam>? cookies;
  if (cookiesString.trim().isNotEmpty) {
    final list = json.decode(cookiesString);
    if (list is! List) {
      throw ArgumentError('Unable to decode cookie list: `$cookiesString`.');
    }
    cookies = list
        .map((e) => CookieParam.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  final session = await browser.createSession();
  return TestUser(
    email: email,
    browserApi: PubApiClient(
      pubHostedUrl,
      client: http_retry.RetryClient(
        createHttpClientWithHeaders(
          {'Authorization': 'Bearer $apiAccessToken'},
        ),
      ),
    ),
    serverApi: PubApiClient(
      pubHostedUrl,
      client: http_retry.RetryClient(
        createHttpClientWithHeaders(
          {'Authorization': 'Bearer $apiAccessToken'},
        ),
      ),
    ),
    withBrowserPage: <T>(Future<T> Function(Page) fn) async {
      return await session.withPage<T>(fn: (page) async {
        if (cookies != null && cookies.isNotEmpty) {
          await page.setCookies(cookies);
        }
        return await fn(page);
      });
    },
    readLatestEmail: () async => await _callback(map['last-email-callback']!),
    createCredentials: () =>
        json.decode(credentialsJsonContent) as Map<String, dynamic>,
  );
}

Future<String> _callback(String command) async {
  print('... $command');
  final parts = command.split(' ');
  final pr = await Process.run(
    parts.first,
    parts.skip(1).toList(),
  );
  if (pr.exitCode != 0) {
    throw Exception('Unexpected exit code: ${pr.exitCode}\n${pr.stderr}');
  }
  return pr.stdout.toString().trim();
}
