// Copyright (c) 2025, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:pub_dev_image_proxy/image_proxy_service.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:test/test.dart';

Future<int> startImageProxy() async {
  final p = await Process.start(
    Platform.resolvedExecutable,
    ['run', '-r', 'bin/server.dart'],
    environment: {'IMAGE_PROXY_TESTING': 'true', 'IMAGE_PROXY_PORT': '0'},
  );
  addTearDown(() => p.kill());
  int? port;
  await for (final line in LineSplitter().bind(Utf8Decoder().bind(p.stdout))) {
    if (line.startsWith('Serving image proxy on')) {
      port = int.parse(line.split(':').last);
      break;
    }
  }
  return port!;
}

Stream<List<int>> infiniteStream() async* {
  while (true) {
    yield List.generate(1000, (i) => 0);
  }
}

void validateSecurityHeaders(HttpClientResponse response) {
  for (final header in securityHeaders.entries) {
    expect(response.headers[header.key], [header.value]);
  }
}

Future<int> startImageServer() async {
  var i = 0;
  final server = await shelf_io.serve(
    (shelf.Request request) async {
      switch (request.url.path) {
        case 'path/to/image.jpg':
          return shelf.Response.ok(
            File(jpgImagePath).readAsBytesSync(),
            headers: {'content-type': 'image/jpeg'},
          );
        case 'path/to/image.png':
          return shelf.Response.ok(
            File(pngImagePath).readAsBytesSync(),
            headers: {'content-type': 'image/png'},
          );
        case 'path/to/image.svg':
          return shelf.Response.ok(
            GZipCodec().encode(File(svgImagePath).readAsBytesSync()),
            headers: {
              'content-type': 'image/svg+xml',
              'Content-Encoding': 'gzip',
            },
          );
        case 'canBeCachedLong':
          return shelf.Response.ok(
            File(jpgImagePath).readAsBytesSync(),
            headers: {
              'content-type': 'image/jpeg',
              'cache-control': 'max-age=20000, public',
            },
          );
        case 'redirect':
          return shelf.Response.movedPermanently('path/to/image.jpg');
        case 'redirectForever':
          return shelf.Response.movedPermanently('redirectForever');
        case 'serverError':
          return shelf.Response.internalServerError();
        case 'worksSecondTime':
          if (i++ == 0) {
            return shelf.Response.internalServerError();
          }
          return shelf.Response.ok(
            File(jpgImagePath).readAsBytesSync(),
            headers: {'content-type': 'image/jpeg'},
          );
        case 'timeout':
          await Future.delayed(Duration(hours: 1));
          return shelf.Response.notFound('Not found');
        case 'timeoutstreaming':
          late final StreamController lateStreamController;
          lateStreamController = StreamController(
            onListen: () async {
              // Return a single byte, and then stall.
              lateStreamController.add([1]);
              await Future.delayed(Duration(hours: 1));
              await lateStreamController.close();
            },
          );
          return shelf.Response.ok(
            lateStreamController.stream,
            headers: {'content-type': 'image/jpeg'},
          );
        case 'okstreaming':
          return shelf.Response.ok(
            // Has no content-length
            File(jpgImagePath).openRead(),
            headers: {'content-type': 'image/jpeg'},
          );
        case 'toobig':
          return shelf.Response.ok(
            infiniteStream(),
            headers: {
              'content-type': 'image/jpeg',
              'content-length': '100000000',
            },
          );
        case 'toobigstreaming':
          return shelf.Response.ok(
            infiniteStream(),
            headers: {'content-type': 'image/jpeg'},
          );
        default:
          return shelf.Response.notFound('Not found');
      }
    },
    'localhost',
    0,
  );
  return server.port;
}

final jpgImagePath = 'test/test_data/image.jpg';
final pngImagePath = 'test/test_data/image.png';
final svgImagePath = 'test/test_data/image.svg';

final now = DateTime.now();
final yesterday = DateTime(now.year, now.month, now.day - 1);
final today = DateTime(now.year, now.month, now.day);
final tomorrow = DateTime(now.year, now.month, now.day + 1);

Future<HttpClientResponse> getImage({
  required int imageProxyPort,
  required int imageServerPort,
  String pathToImage = 'path/to/image.jpg',
  DateTime? day,
  bool disturbSignature = false,
}) async {
  final client = HttpClient();
  day ??= today;
  final dailySecret = await getDailySecretMock(day);
  final imageUrl = 'http://localhost:$imageServerPort/$pathToImage';
  final signature = hmacSign(dailySecret, utf8.encode(imageUrl));
  if (disturbSignature) {
    signature[0]++;
  }
  final url = Uri(
    scheme: 'http',
    host: 'localhost',
    port: imageProxyPort,
    pathSegments: [
      base64Encode(signature),
      day.millisecondsSinceEpoch.toString(),
      imageUrl,
    ],
  );
  final request = await client.getUrl(url);
  return await request.close();
}

Future<void> main() async {
  test('Can proxy images', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();

    for (final day in [yesterday, today, tomorrow]) {
      final response = await getImage(
        day: day,
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
      );
      validateSecurityHeaders(response);
      expect(response.statusCode, 200);
      expect(response.headers['content-type']!.single, 'image/jpeg');
      expect(response.headers['cache-control']!.single, 'max-age=180, public');
      final hash = await sha256.bind(response).single;
      final expected = sha256.convert(File(jpgImagePath).readAsBytesSync());
      expect(hash, expected);
    }

    {
      final response = await getImage(
        day: today,
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        pathToImage: 'path/to/image.png',
      );
      validateSecurityHeaders(response);
      expect(response.statusCode, 200);
      expect(response.headers['content-type']!.single, 'image/png');
      final hash = await sha256.bind(response).single;
      final expected = sha256.convert(File(pngImagePath).readAsBytesSync());
      expect(hash, expected);
    }

    {
      final response = await getImage(
        day: today,
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        pathToImage: 'path/to/image.svg',
      );
      validateSecurityHeaders(response);
      expect(response.statusCode, 200);
      expect(response.headers['content-type']!.single, 'image/svg+xml');
      final hash = await sha256.bind(response).single;
      final expected = sha256.convert(File(svgImagePath).readAsBytesSync());
      expect(hash, expected);
    }

    {
      final response = await getImage(
        day: today,
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        // Gives no content-length
        pathToImage: 'okstreaming',
      );
      validateSecurityHeaders(response);
      expect(response.statusCode, 200);
      expect(response.headers['content-type']!.single, 'image/jpeg');
      final jpgFile = File(jpgImagePath).readAsBytesSync();
      expect(response.contentLength, jpgFile.length);
      final hash = await sha256.bind(response).single;
      final expected = sha256.convert(jpgFile);
      expect(hash, expected);
    }
  });

  test('Fails on days outside recent range', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: tomorrow.add(Duration(days: 1)),
      );
      validateSecurityHeaders(response);
      expect(response.statusCode, 400);

      expect(
        await Utf8Codec().decodeStream(response),
        'malformed request, proxy url expired',
      );
    }
  });

  test('Fails with bad hmac', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        disturbSignature: true,
      );
      validateSecurityHeaders(response);
      expect(response.statusCode, 401);

      expect(await Utf8Codec().decodeStream(response), 'Bad hmac');
    }
  });

  test('Fails with too long query url', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        disturbSignature: true,
        pathToImage: 'next/' * 1000 + 'image.jpg',
      );
      validateSecurityHeaders(response);
      expect(response.statusCode, 400);

      expect(await Utf8Codec().decodeStream(response), 'proxied url too long');
    }
  });

  test('Follows redirect', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'redirect',
      );
      validateSecurityHeaders(response);

      expect(response.statusCode, 200);
      final hash = await sha256.bind(response).single;
      final expected = sha256.convert(File(jpgImagePath).readAsBytesSync());
      expect(hash, expected);
    }
  });

  test('Fails with infinite redirect', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'redirectForever',
      );
      validateSecurityHeaders(response);

      expect(await Utf8Codec().decodeStream(response), 'Too many redirects.');
      expect(response.statusCode, 400);
    }
  });

  test('Fails with 500', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'serverError',
      );
      validateSecurityHeaders(response);

      expect(
        await Utf8Codec().decodeStream(response),
        'Failed to retrieve image. Status code 500',
      );
      expect(response.statusCode, 400);
    }
  });

  test('Fails on 4xx', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'doesntexist',
      );
      validateSecurityHeaders(response);

      expect(await Utf8Codec().decodeStream(response), 'Not found');
      expect(response.statusCode, 404);
    }
  });

  test('Retries 500', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'worksSecondTime',
      );
      validateSecurityHeaders(response);

      expect(response.statusCode, 200);
      final hash = await sha256.bind(response).single;
      final expected = sha256.convert(File(jpgImagePath).readAsBytesSync());
      expect(hash, expected);
    }
  });

  test('Doesn\'t forward cache header', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'canBeCachedLong',
      );
      validateSecurityHeaders(response);

      expect(response.statusCode, 200);
      // The proxy doesn't cache as long time as the original.
      expect(response.headers['cache-control']!.single, 'max-age=180, public');
      final hash = await sha256.bind(response).single;
      final expected = sha256.convert(File(jpgImagePath).readAsBytesSync());
      expect(hash, expected);
    }
  });

  test('times out', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'timeout',
      );
      validateSecurityHeaders(response);

      expect(response.statusCode, 400);
      // The proxy doesn't cache as long time as the original.
      expect(await Utf8Codec().decodeStream(response), 'No response');
    }
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'timeoutstreaming',
      );
      validateSecurityHeaders(response);

      expect(response.statusCode, 400);
      // The proxy doesn't cache as long time as the original.
      expect(await Utf8Codec().decodeStream(response), 'No response');
    }
  });

  test('protects against too big files', () async {
    final imageProxyPort = await startImageProxy();
    final imageServerPort = await startImageServer();
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'toobig',
      );
      validateSecurityHeaders(response);

      expect(response.statusCode, 400);
      // The proxy doesn't cache as long time as the original.
      expect(await Utf8Codec().decodeStream(response), 'Image too large');
    }
    {
      final response = await getImage(
        imageProxyPort: imageProxyPort,
        imageServerPort: imageServerPort,
        day: today,
        pathToImage: 'toobigstreaming',
      );
      validateSecurityHeaders(response);

      expect(response.statusCode, 400);
      // The proxy doesn't cache as long time as the original.
      expect(await Utf8Codec().decodeStream(response), 'Image too large');
    }
  });
}
