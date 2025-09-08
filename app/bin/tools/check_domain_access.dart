// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

/// The script checks if the domains accessed by the pub client are available,
/// and not blocked by any network infrastructure.
Future<void> main(List<String> args) async {
  print('Testing host resolves...');
  await _checkHosts();

  print('Testing one connection per request...');
  await _checkUrls();

  print('Testing connection reuse...');
  final iterations = args.isEmpty ? 10 : int.parse(args.first);
  final client = HttpClient();
  for (var i = 0; i < iterations; i++) {
    print('- iteration #${i + 1}/$iterations...');
    await _checkUrls(client: client);
  }
  client.close();

  print('Done.');
}

final timeLimit = Duration(seconds: 15);
final urls = <String>[
  // package info
  'https://pub.dev/api/packages/http',
  'https://pub.dartlang.org/api/packages/http',
  // package archive
  'https://pub.dev/packages/http/versions/0.13.1.tar.gz',
  'https://pub.dartlang.org/packages/http/versions/0.13.1.tar.gz',
  'https://storage.googleapis.com/pub-packages/packages/http-0.13.1.tar.gz',
];
final uris = urls.map((u) => Uri.parse(u)).toList();
final hosts = uris.map((u) => u.host).toSet().toList();

Future<void> _checkHosts() async {
  for (final host in hosts) {
    for (final type in [InternetAddressType.IPv4, InternetAddressType.IPv6]) {
      final typeStr = type == InternetAddressType.IPv4 ? 'IPv4' : 'IPv6';
      try {
        final addresses = await InternetAddress.lookup(
          host,
          type: type,
        ).timeout(timeLimit);
        final failed = <InternetAddress>[];
        for (final address in addresses) {
          try {
            final s = await Socket.connect(address, 443).timeout(timeLimit);
            await s.close().timeout(timeLimit);
          } catch (_) {
            failed.add(address);
          }
        }
        final successCount = addresses.length - failed.length;
        print(
          '- $host $typeStr resolve and connect succeeded: $successCount / ${addresses.length}',
        );
      } catch (e) {
        print('- $host $typeStr lookup failed: $e');
      }
    }
  }
}

Future<void> _checkUrls({HttpClient? client}) async {
  for (final uri in uris) {
    await _checkUrlGetContent(uri, client: client);
  }
}

Future<void> _checkUrlGetContent(Uri uri, {HttpClient? client}) async {
  final closeClient = client == null;
  client ??= HttpClient();
  final rq = await client.getUrl(uri).timeout(timeLimit);
  final rs = await rq.close().timeout(timeLimit);
  final bodyList = await rs.toList().timeout(timeLimit);
  final bodyLength = bodyList.map((e) => e.length).reduce((a, b) => a + b);
  if (bodyLength <= 0) throw Exception('No body for $uri');
  if (rs.statusCode != 200) throw Exception('Failed to fetch $uri');
  if (closeClient) {
    client.close();
  }
}
