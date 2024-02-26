// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/utils/http.dart';
import 'package:args/args.dart';
import 'package:pool/pool.dart';

/// Crawls and checks public package pages on pub.dev site, intended for pre-release
/// checks for rendering user-generated content (esp. markdown).
Future<void> main(List<String> args) async {
  final argParser = ArgParser()
    ..addOption('concurrency',
        abbr: 'c', defaultsTo: '1', help: 'Number of concurrent processing.')
    ..addOption('pub-hosted-url', abbr: 'p', help: 'The PUB_HOSTED_URL to use.')
    ..addOption('limit', help: 'Stop after N successful checks.')
    ..addFlag('help', abbr: 'h', defaultsTo: false, help: 'Show help.');

  final argv = argParser.parse(args);
  if (argv['help'] as bool) {
    print(
        'Usage: dart public_package_page_checker.dart --pub-hosted-url https://staging-site/ -c 8');
    print('Crawls and checks public package pages on pub.dev site');
    print(argParser.usage);
    return;
  }

  final pubHostedUrl = (argv['pub-hosted-url'] as String?) ??
      Platform.environment['PUB_HOSTED_URL'];
  if (pubHostedUrl == null) {
    print('Missing PUB_HOSTED_URL.');
    return;
  }

  final concurrency = int.parse(argv['concurrency'] as String);
  final limit = int.parse((argv['limit'] as String?) ?? '0');

  final client = httpRetryClient();
  try {
    final nameRs =
        await client.get(Uri.parse('$pubHostedUrl/api/package-names'));
    final packages =
        ((json.decode(nameRs.body) as Map)['packages'] as List).cast<String>();
    packages.shuffle();

    var count = 0;
    var running = true;
    final pool = Pool(concurrency);
    await Future.wait(
      packages.map(
        (p) => pool.withResource(
          () async {
            if (!running) {
              return;
            }

            Future<String> checkContent(String subPath) async {
              final uri = Uri.parse('$pubHostedUrl/packages/$p$subPath');
              print('GET $uri');
              final rs = await client.get(uri);
              if (rs.statusCode != 200) {
                print('Failed to GET: $uri');
                throw StateError('Failed to GET "$uri".');
              }
              return rs.body;
            }

            final mainBody = await checkContent('');
            if (mainBody.contains('$p/changelog')) {
              await checkContent('/changelog');
            }
            if (mainBody.contains('$p/example')) {
              await checkContent('/example');
            }
            count++;
            if (running && limit > 0 && count >= limit) {
              print('Limit reached, stopping...');
              running = false;
            }
          },
        ),
      ),
    );
  } finally {
    client.close();
  }
}
