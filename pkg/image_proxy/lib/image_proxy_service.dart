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

bool isTesting = Platform.environment['IMAGE_PROXY_TESTING'] == 'true';

Duration timeoutDelay = Duration(seconds: isTesting ? 1 : 8);

/// The keys we currently allow the url to be signed with.
Map<int, Uint8List> allowedKeys = {};

// Inspired by https://github.com/atmos/camo/blob/master/server.coffee#L39.
Map<String, String> securityHeaders = {
  'X-Frame-Options': 'deny',
  'X-XSS-Protection': '1; mode=block',
  'X-Content-Type-Options': 'nosniff',
  'Content-Security-Policy':
      "default-src 'none'; img-src data:; style-src 'unsafe-inline'",
  'Strict-Transport-Security': 'max-age=31536000; includeSubDomains',
};

/// Ensure that [allowedKeys] contains keys for today and the two surrounding
/// days.
Future<void> updateAllowedKeys() async {
  final now = DateTime.now();
  final yesterday = DateTime(now.year, now.month, now.day - 1);
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = DateTime(now.year, now.month, now.day + 1);

  for (final d in [yesterday, today, tomorrow]) {
    if (!allowedKeys.containsKey(d.millisecondsSinceEpoch)) {
      allowedKeys[d.millisecondsSinceEpoch] = isTesting
          ? await getDailySecretMock(d)
          : await getDailySecret(d);
      print('Generating new key for ${d.toIso8601String()}');
    }
  }
  while (allowedKeys.length > 3) {
    final dates = allowedKeys.keys.toList()..sort();
    allowedKeys.remove(dates.first);
  }
  assert(allowedKeys.length == 3);
}

late auth.AuthClient? _apiClient;

/// The client used for communicating with the google apis.
Future<AuthClient> authClient() async {
  return (_apiClient ??= await retry(() async {
    return await auth.clientViaApplicationDefaultCredentials(scopes: []);
  }))!;
}

Future<Uint8List> getDailySecretMock(DateTime day) async {
  return hmacSign(
    utf8.encode('fake secret'),
    utf8.encode(
      DateTime(day.year, day.month, day.day).toUtc().toIso8601String(),
    ),
  );
}

/// Requests a derived hmac key corresponding to [day] using.
Future<Uint8List> getDailySecret(DateTime day) async {
  final api = kms.CloudKMSApi(await authClient());
  final response = await api
      .projects
      .locations
      .keyRings
      .cryptoKeys
      .cryptoKeyVersions
      .macSign(
        kms.MacSignRequest()
          ..dataAsBytes = utf8.encode(
            DateTime(day.year, day.month, day.day).toUtc().toIso8601String(),
          ),
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
        headers: {...securityHeaders},
      );
    }
    final segments = request.url.pathSegments;
    if (segments.length != 3) {
      return shelf.Response.badRequest(
        body:
            'malformed request, ${segments.length} should be of the form <base64(hmac(url,daily_secret))>/<date>/<urlencode(url)>',
        headers: {...securityHeaders},
      );
    }
    final Uint8List signature;
    try {
      signature = base64Decode(segments[0]);
    } on FormatException catch (_) {
      return shelf.Response.badRequest(
        body: 'malformed request, could not decode mac signature',
        headers: {...securityHeaders},
      );
    }
    final date = int.tryParse(segments[1]);
    if (date == null) {
      return shelf.Response.badRequest(
        body: 'malformed request, missing date',
        headers: {...securityHeaders},
      );
    }
    final secret = allowedKeys[date];
    if (secret == null) {
      return shelf.Response.badRequest(
        body: 'malformed request, proxy url expired',
        headers: {...securityHeaders},
      );
    }

    final imageUrl = segments[2];
    if (imageUrl.length > 1024) {
      return shelf.Response.badRequest(
        body: 'proxied url too long',
        headers: {...securityHeaders},
      );
    }
    final imageUrlBytes = utf8.encode(imageUrl);

    if (_constantTimeEquals(hmacSign(secret, imageUrlBytes), signature)) {
      final Uri parsedImageUrl;
      try {
        parsedImageUrl = Uri.parse(imageUrl);
      } on FormatException catch (e) {
        return shelf.Response.badRequest(
          body: 'Malformed proxied url $e',
          headers: {...securityHeaders},
        );
      }
      if (!(parsedImageUrl.isScheme('http') ||
          parsedImageUrl.isScheme('https'))) {
        return shelf.Response.badRequest(
          body: 'Can only proxy http and https urls',
          headers: {...securityHeaders},
        );
      }
      if (!parsedImageUrl.isAbsolute) {
        return shelf.Response.badRequest(
          body: 'Can only proxy absolute urls',
          headers: {...securityHeaders},
        );
      }

      int statusCode;
      List<int> bytes;
      String? contentType;
      String? contentEncoding;
      try {
        (statusCode, bytes, contentType, contentEncoding) = await retry(
          maxDelay: timeoutDelay,
          maxAttempts: isTesting ? 2 : 8,
          () async {
            final request = await client.getUrl(parsedImageUrl);
            Timer? timeoutTimer;
            void scheduleRequestTimeout() {
              timeoutTimer?.cancel();
              timeoutTimer = Timer(timeoutDelay, () {
                request.abort(RequestTimeoutException('No response'));
              });
            }

            request.headers.add(
              'user-agent',
              'Image proxy for pub.dev. See https://github.com/dart-lang/pub-dev/pkg/image-proxy. If you have any issues, contact support@pub.dev.',
            );
            request.followRedirects = false;
            scheduleRequestTimeout();
            var response = await request.close();
            var redirectCount = 0;
            while (response.isRedirect) {
              await response.drain();
              redirectCount++;
              if (redirectCount > 10) {
                throw RedirectException('Too many redirects.');
              }
              final location = response.headers.value(
                HttpHeaders.locationHeader,
              );
              if (location == null) {
                throw RedirectException('No location header in redirect.');
              }
              final uri = parsedImageUrl.resolve(location);
              final request = await client.getUrl(uri);

              request.headers.add('user-agent', 'pub-proxy');
              // Set the body or headers as desired.
              request.followRedirects = false;
              scheduleRequestTimeout();
              response = await request.close();
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
              response.statusCode,
              await readAllBytes(
                response,
                contentLength == -1 ? maxImageSize : contentLength,
              ).timeout(
                timeoutDelay,
                onTimeout: () {
                  throw RequestTimeoutException('No response');
                },
              ),
              response.headers.value('content-type'),
              response.headers.value('content-encoding'),
            );
          },
          retryIf: (e) =>
              e is SocketException ||
              e is http.ClientException ||
              e is ServerSideException,
        );
      } on TooLargeException {
        return shelf.Response.badRequest(
          body: 'Image too large',
          headers: {...securityHeaders},
        );
      } on RedirectException catch (e) {
        return shelf.Response.badRequest(
          body: e.message,
          headers: {...securityHeaders},
        );
      } on RequestTimeoutException catch (e) {
        return shelf.Response.badRequest(
          body: e.message,
          headers: {...securityHeaders},
        );
      } on ServerSideException catch (e) {
        return shelf.Response.badRequest(
          body: 'Failed to retrieve image. Status code ${e.statusCode}',
          headers: {...securityHeaders},
        );
      }

      return shelf.Response(
        statusCode,
        body: bytes,
        headers: {
          'Cache-control': 'max-age=180, public',
          'content-type': ?contentType,
          'content-encoding': ?contentEncoding,
          ...securityHeaders,
        },
      );
    } else {
      return shelf.Response.unauthorized(
        'Bad hmac',
        headers: {...securityHeaders},
      );
    }
  } catch (e, st) {
    stderr.writeln('Uncaught error: $e $st');
    rethrow;
  }
}

void main(List<String> args) async {
  await updateAllowedKeys();
  Timer.periodic(Duration(hours: 1), (_) => updateAllowedKeys());
  final server = await serve(
    handler,
    InternetAddress.anyIPv6,
    int.tryParse(Platform.environment['IMAGE_PROXY_PORT'] ?? '') ?? 80,
  );
  print('Serving image proxy on ${server.address}:${server.port}');
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
