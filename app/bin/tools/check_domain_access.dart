// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

/// The script checks if the domains accessed by the pub client are available,
/// and not blocked by any network infrastructure.
Future<void> main(List<String> args) async {
  final urls = <String>[
    // package info
    'https://pub.dev/api/packages/http',
    'https://pub.dartlang.org/api/packages/http',
    // package archive
    'https://pub.dev/packages/http/versions/0.13.1.tar.gz',
    'https://pub.dartlang.org/packages/http/versions/0.13.1.tar.gz',
    'https://storage.googleapis.com/pub-packages/packages/http-0.13.1.tar.gz',
  ];

  final iterations = args.isEmpty ? 10 : int.parse(args.first);

  for (var i = 0; i < iterations; i++) {
    print('Iteration #${i + 1}/$iterations...');
    for (final url in urls) {
      await _checkUrlAccess(url);
    }
  }
  print('Done.');
}

Future<void> _checkUrlAccess(String url) async {
  final client = HttpClient();
  final rq = await client.getUrl(Uri.parse(url));
  final rs = await rq.close();
  final bodyList = await rs.toList();
  final bodyLength = bodyList.map((e) => e.length).reduce((a, b) => a + b);
  if (bodyLength <= 0) throw Exception('No body for $url');
  if (rs.statusCode != 200) throw Exception('Failed to fetch $url');
}
