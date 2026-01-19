// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:googleapis/cloudkms/v1.dart' as kms;
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:googleapis_auth/googleapis_auth.dart';
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart';

enum Severity {
  notice,
  info,
  warning,
  error;

  String get name {
    switch (this) {
      case Severity.notice:
        return 'NOTICE';
      case Severity.warning:
        return 'WARNING';
      case Severity.error:
        return 'ERROR';
      case Severity.info:
        return 'INFO';
    }
  }
}

void log(String message, {Severity severity = Severity.notice}) {
  final object = {'severity': severity.name, 'message': message};
  stdout.writeln(json.encode(object));
  // stdout.writeln(object);
}

bool isTesting = Platform.environment['IMAGE_PROXY_TESTING'] == 'true';

Duration timeoutDelay = Duration(seconds: isTesting ? 1 : 8);

/// The keys we currently allow the url to be signed with.
Map<int, Uint8List> _allowedKeys = {};

DateTime _lastAllowedKeysUpdate = DateTime.fromMillisecondsSinceEpoch(0);

Future<Map<int, Uint8List>> get allowedKeys async {
  await updateAllowedKeys();
  return _allowedKeys;
}

// Inspired by https://github.com/atmos/camo/blob/master/server.coffee#L39.
Map<String, String> securityHeaders = {
  'X-Frame-Options': 'deny',
  'X-XSS-Protection': '1; mode=block',
  'X-Content-Type-Options': 'nosniff',
  'Content-Security-Policy':
      "default-src 'none'; img-src data:; style-src 'unsafe-inline'",
  'Strict-Transport-Security': 'max-age=31536000; includeSubDomains; preload',
};

/// Ensure that [allowedKeys] contains keys for today and the two surrounding
/// days.
Future<void> updateAllowedKeys() async {
  final now = DateTime.timestamp();
  if (now.difference(_lastAllowedKeysUpdate) < Duration(minutes: 5)) {
    return;
  }
  final yesterday = DateTime.utc(now.year, now.month, now.day - 1);
  final today = DateTime.utc(now.year, now.month, now.day);
  final tomorrow = DateTime.utc(now.year, now.month, now.day + 1);

  for (final d in [yesterday, today, tomorrow]) {
    if (!_allowedKeys.containsKey(d.millisecondsSinceEpoch)) {
      _allowedKeys[d.millisecondsSinceEpoch] = isTesting
          ? await getDailySecretMock(d.millisecondsSinceEpoch)
          : await getDailySecret(d.millisecondsSinceEpoch);
      log(
        'Generating new key for ${d.toIso8601String()} using ${Platform.environment['HMAC_KEY_ID']}',
      );
    }
  }
  while (_allowedKeys.length > 3) {
    final dates = _allowedKeys.keys.toList()..sort();
    _allowedKeys.remove(dates.first);
  }
  assert(_allowedKeys.length == 3);
  _lastAllowedKeysUpdate = now;
}

auth.AuthClient? _apiClient;

/// The client used for communicating with the google apis.
Future<AuthClient> authClient() async {
  return (_apiClient ??= await retry(() async {
    return await auth.clientViaApplicationDefaultCredentials(scopes: []);
  }))!;
}

Future<Uint8List> getDailySecretMock(int timestamp) async {
  return hmacSign(
    utf8.encode('fake secret'),
    utf8.encode(timestamp.toString()),
  );
}

/// Requests a derived hmac key corresponding to [timestamp].
Future<Uint8List> getDailySecret(int timestamp) async {
  final api = kms.CloudKMSApi(await authClient());
  final response = await api
      .projects
      .locations
      .keyRings
      .cryptoKeys
      .cryptoKeyVersions
      .macSign(
        kms.MacSignRequest()..dataAsBytes = utf8.encode(timestamp.toString()),
        Platform.environment['HMAC_KEY_ID']!,
      );
  return response.macAsBytes as Uint8List;
}

bool _constantTimeEquals(Uint8List a, Uint8List b) {
  if (a.length != b.length) return false;
  bool answer = true;
  for (var i = 0; i < a.length; i++) {
    answer &= a[i] == b[i];
  }
  return answer;
}

// The client used for requesting the images.
// Using raw dart:io client such that we can disable autoUncompress.
final HttpClient client = HttpClient()
  ..autoUncompress = false
  ..connectionTimeout = Duration(seconds: 10)
  ..idleTimeout = Duration(seconds: 15);

final maxImageSize = 1024 * 1024 * 10; // At most 10 MB.

Future<shelf.Response> handler(shelf.Request request) async {
  try {
    if (request.method != 'GET') {
      return shelf.Response.notFound(
        'Unsupported method',
        headers: securityHeaders,
      );
    }
    final segments = request.url.pathSegments;
    if (segments.length != 3) {
      return shelf.Response.badRequest(
        body:
            'malformed request, ${segments.length} should be of the form <base64(hmac(url,daily_secret))>/<date>/<urlencode(url)>',
        headers: securityHeaders,
      );
    }
    final Uint8List signature;
    try {
      signature = base64Decode(segments[0]);
    } on FormatException catch (_) {
      return shelf.Response.badRequest(
        body: 'malformed request, could not decode mac signature',
        headers: securityHeaders,
      );
    }
    final date = int.tryParse(segments[1]);
    if (date == null) {
      return shelf.Response.badRequest(
        body: 'malformed request, missing date',
        headers: securityHeaders,
      );
    }
    final secret = (await allowedKeys)[date];
    if (secret == null) {
      return shelf.Response.badRequest(
        body: 'malformed request, proxy url expired',
        headers: securityHeaders,
      );
    }

    final imageUrl = segments[2];
    if (imageUrl.length > 1024) {
      return shelf.Response.badRequest(
        body: 'proxied url too long',
        headers: securityHeaders,
      );
    }
    final imageUrlBytes = utf8.encode(imageUrl);

    if (!_constantTimeEquals(hmacSign(secret, imageUrlBytes), signature)) {
      return shelf.Response.unauthorized('Bad hmac', headers: securityHeaders);
    }
    final Uri parsedImageUrl;
    try {
      parsedImageUrl = Uri.parse(imageUrl);
    } on FormatException catch (e) {
      return shelf.Response.badRequest(
        body: 'Malformed proxied url $e',
        headers: securityHeaders,
      );
    }
    if (!(parsedImageUrl.isScheme('http') ||
        parsedImageUrl.isScheme('https'))) {
      return shelf.Response.badRequest(
        body: 'Can only proxy http and https urls',
        headers: securityHeaders,
      );
    }
    if (!parsedImageUrl.isAbsolute) {
      return shelf.Response.badRequest(
        body: 'Can only proxy absolute urls',
        headers: securityHeaders,
      );
    }

    Future<
      ({
        int statusCode,
        List<int> body,
        String? contentType,
        String? contentEncoding,
      })
    >
    makeRequest(Uri url, {int redirectCount = 0}) async {
      stderr.writeln('Requesting $url');
      if (redirectCount > 10) {
        throw RedirectException('Too many redirects.');
      }
      final request = await client.getUrl(url);
      final timeout = Timer(timeoutDelay, () {
        request.abort(RequestTimeoutException('No response'));
      });
      HttpClientResponse? response;
      try {
        request.headers.add(
          'user-agent',
          'Image proxy for pub.dev. See https://github.com/dart-lang/pub-dev/pkg/image-proxy. If you have any issues, contact support@pub.dev.',
        );
        request.followRedirects = false;
        response = await request.close();
        if (response.isRedirect) {
          await response.listen((_) => null).cancel();
          final location = response.headers.value(HttpHeaders.locationHeader);
          if (location == null) {
            throw RedirectException('No location header in redirect.');
          }
          return makeRequest(
            parsedImageUrl.resolve(location),
            redirectCount: redirectCount + 1,
          );
        }
        switch (response.statusCode) {
          case final int statusCode && >= 500 && < 600:
            throw ServerSideException(statusCode: statusCode);
          case final int statusCode && >= 300 && < 400:
            throw ServerSideException(statusCode: statusCode);
        }
        final contentLength = response.contentLength;
        if (contentLength != -1 && contentLength > maxImageSize) {
          throw TooLargeException();
        }
        return (
          statusCode: response.statusCode,
          body:
              await readAllBytes(
                response,
                contentLength == -1 ? maxImageSize : contentLength,
              ).timeout(
                timeoutDelay,
                onTimeout: () {
                  throw RequestTimeoutException('No response');
                },
              ),
          contentType: response.headers.value('content-type'),
          contentEncoding: response.headers.value('content-encoding'),
        );
      } finally {
        timeout.cancel();
        try {
          // Attempt closing resources
          request.abort();
          await response?.listen((_) => null).cancel();
        } catch (_) {}
      }
    }

    try {
      final (:statusCode, :body, :contentType, :contentEncoding) = await retry(
        maxDelay: timeoutDelay,
        maxAttempts: isTesting ? 2 : 8,
        () => makeRequest(parsedImageUrl),
        retryIf: (e) =>
            e is SocketException ||
            e is http.ClientException ||
            e is ServerSideException,
      );

      return shelf.Response(
        statusCode,
        body: body,
        headers: {
          'Cache-control': 'max-age=180, public',
          'content-type': ?contentType,
          'content-encoding': ?contentEncoding,
          ...securityHeaders,
        },
      );
    } on TooLargeException {
      return shelf.Response.badRequest(
        body: 'Image too large',
        headers: securityHeaders,
      );
    } on RedirectException catch (e) {
      return shelf.Response.badRequest(
        body: e.message,
        headers: securityHeaders,
      );
    } on RequestTimeoutException catch (e) {
      return shelf.Response.badRequest(
        body: e.message,
        headers: securityHeaders,
      );
    } on ServerSideException catch (e) {
      return shelf.Response.badRequest(
        body: 'Failed to retrieve image. Status code ${e.statusCode}',
        headers: securityHeaders,
      );
    }
  } catch (e, st) {
    stderr.writeln('Uncaught error: $e $st');
    rethrow;
  }
}

void main(List<String> args) async {
  final server = await serve(
    handler,
    InternetAddress.anyIPv6,
    int.tryParse(
          Platform.environment['IMAGE_PROXY_PORT'] ??
              Platform.environment['PORT'] ??
              '',
        ) ??
        8080,
  );
  log('Serving image proxy on port ${server.port}');
}

class TooLargeException implements Exception {
  TooLargeException();
}

class ServerSideException implements Exception {
  int statusCode;
  ServerSideException({required this.statusCode});
}

class RedirectException implements Exception {
  String message;
  RedirectException(this.message);
}

class RequestTimeoutException implements Exception {
  String message;
  RequestTimeoutException(this.message);
}

Uint8List hmacSign(Uint8List key, Uint8List imageUrlBytes) {
  return Hmac(sha256, key).convert(imageUrlBytes).bytes as Uint8List;
}

Future<Uint8List> readAllBytes(Stream<List<int>> stream, int maxBytes) async {
  final builder = BytesBuilder();

  await for (final chunk in stream) {
    if (builder.length + chunk.length > maxBytes) {
      throw TooLargeException();
    }
    builder.add(chunk);
  }
  return builder.takeBytes();
}
