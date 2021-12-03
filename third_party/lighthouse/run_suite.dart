// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final siteRoot = 'https://pub.dev';
  final pages = [
    '/',
    '/packages',
    '/packages/retry',
    '/packages/retry/versions',
    '/documentation/retry/latest/retry/retry-library.html',
  ];
  final padRight = pages.map((p) => p.length).reduce((a, b) => a > b ? a : b);
  final total = <int>[];
  for (final isDesktop in [false, true]) {
    final section = isDesktop ? 'desktop:' : 'mobile:';
    print('${section.padRight(padRight)}  avg [per, acc, bps, seo, pwa]');
    print('');
    for (final page in pages) {
      final url = '$siteRoot$page';
      final result = await _runLighthouse(url, isDesktop: isDesktop);
      print('${page.padRight(padRight)}  $result');
      total.add(result.avg);
    }
    print('');
  }
  print('total: ${total.reduce((a, b) => a + b) / total.length}');
}

class LighthouseResult {
  final int performance;
  final int accessibility;
  final int bestPractices;
  final int seo;
  final int pwa;

  LighthouseResult({
    required this.performance,
    required this.accessibility,
    required this.bestPractices,
    required this.seo,
    required this.pwa,
  });

  late final _all = [performance, accessibility, bestPractices, seo, pwa];
  late final avg = _all.reduce((a, b) => a + b) ~/ _all.length;

  String _f(int v) => v.toString().padLeft(3);

  @override
  String toString() => '${_f(avg)} [${_all.map(_f).join(', ')}]';
}

Future<LighthouseResult> _runLighthouse(
  String url, {
  required bool isDesktop,
}) async {
  final localChromePath = '/usr/bin/google-chrome-stable';
  final hasLocalChrome = await FileSystemEntity.isFile(localChromePath);
  final tempDir = await Directory.systemTemp.createTemp();
  try {
    final pr = await Process.run(
      'node_modules/.bin/lighthouse',
      [
        url,
        if (isDesktop) '--preset=desktop',
        '--output=json',
        '--chrome-flags="--headless --user-data-dir=${tempDir.path}"'
      ],
      environment: {
        if (hasLocalChrome) 'CHROME_PATH': localChromePath,
      },
    );
    if (pr.exitCode != 0) {
      throw Exception('Unknown exit code.\n${pr.stdout}');
    }
    final data = json.decode(pr.stdout.toString()) as Map<String, dynamic>;
    final categories = data['categories'] as Map<String, dynamic>;

    int score(String category) {
      final d = (categories[category] as Map<String, dynamic>)['score'] as num;
      return (d * 100).round();
    }

    return LighthouseResult(
      performance: score('performance'),
      accessibility: score('accessibility'),
      bestPractices: score('best-practices'),
      seo: score('seo'),
      pwa: score('pwa'),
    );
  } finally {
    await tempDir.delete(recursive: true);
  }
}
