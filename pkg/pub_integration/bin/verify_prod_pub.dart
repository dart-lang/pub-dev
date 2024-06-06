// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:args/args.dart';
import 'package:http/http.dart' as http;
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
      '${prefix}client-access-token-callback',
      help: 'The command to execute to get pub client access token for $name',
      mandatory: true,
    );
    addOption(
      '${prefix}client-refresh-token-callback',
      help: 'The command to execute to get pub client refresh token for $name',
      mandatory: true,
    );
    addOption(
      '${prefix}browser-cookies-callback',
      help:
          'The command to execute to get the browser cookies (serialized as JSON)',
      mandatory: true,
    );
    addOption(
      '${prefix}gmail-access-token-callback',
      help: 'The command to execute to get Gmail access token for $name',
      mandatory: true,
    );
  }
}

Future<void> main(List<String> arguments) async {
  final argv = _argParser.parse(arguments);
  final pubHostedUrl = argv['pub-hosted-url'] as String;

  final browser = TestBrowser(origin: pubHostedUrl);
  try {
    await browser.startBrowser();
    await verifyPub(
      pubHostedUrl: pubHostedUrl,
      adminUser: await _initializeUser(
          browser, pubHostedUrl, _argsWithPrefix(argv, 'user-a-')),
      invitedUser: await _initializeUser(
          browser, pubHostedUrl, _argsWithPrefix(argv, 'user-b-')),
      expectLiveSite: true,
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
  final clientAccessToken =
      await _callback(map['client-access-token-callback']!);
  final clientRefreshToken =
      await _callback(map['client-refresh-token-callback']!);
  final gmailAccessToken = await _callback(map['gmail-access-token-callback']!);
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
    api: PubApiClient(
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
        await fn(page);
      });
    },
    readLatestEmail: () async => _readLastEmail(email, gmailAccessToken),
    createCredentials: () => {
      'accessToken': clientAccessToken,
      'refreshToken': clientRefreshToken,
      'tokenEndpoint': 'https://accounts.google.com/o/oauth2/token',
      'scopes': [
        'openid',
        'https://www.googleapis.com/auth/userinfo.email',
      ],
      'expiration': 0,
    },
  );
}

Future<String> _callback(String command) async {
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

Future<String> _readLastEmail(String email, String token) async {
  final client = http_retry.RetryClient(http.Client());
  try {
    final gmail = _GmailClient(client, email, token);
    final messageIds = await gmail.listMessages();
    return await gmail.getMessage(messageIds.first);
  } finally {
    client.close();
  }
}

class _GmailClient {
  final http.Client _client;
  final String _email;
  final String _token;

  _GmailClient(this._client, this._email, this._token);

  Future<List<String>> listMessages() async {
    final u = Uri.parse(
        'https://gmail.googleapis.com/gmail/v1/users/$_email/messages');
    final res = await _client.get(u, headers: {
      'Authorization': 'Bearer $_token',
    });
    if (res.statusCode != 200) {
      throw Exception('Failed to list messages from gmail');
    }
    final ids = <String>[];
    for (final m in json.decode(res.body)['messages'] as Iterable) {
      ids.add(m['id'] as String);
    }
    return ids;
  }

  Future<String> getMessage(String id) async {
    final u = Uri.parse(
        'https://gmail.googleapis.com/gmail/v1/users/$_email/messages/$id');
    final res = await _client.get(u, headers: {
      'Authorization': 'Bearer $_token',
    });
    if (res.statusCode != 200) {
      throw Exception('Failed to fetch message from gmail');
    }

    final data = json.decode(res.body) as Map;
    final content = base64Decode(data['payload']['body']['data'] as String);

    return utf8.decode(content);
  }
}
