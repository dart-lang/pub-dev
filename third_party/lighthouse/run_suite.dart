// Copyright (c) 2024, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

Future<void> main(List<String> args) async {
  final siteRoot = 'http://localhost:8080';
  final pages = [
    '/',
    '/help',
    '/packages',
    '/packages/retry',
    '/packages/retry/versions',
    '/packages/retry/score',
    '/documentation/retry/latest/retry/retry-library.html',
  ];
  final padRight = pages.map((p) => p.length).reduce((a, b) => a > b ? a : b);
  final total = <int>[];
  for (final isDesktop in [false, true]) {
    final section = isDesktop ? 'desktop:' : 'mobile:';
    print('${section.padRight(padRight)}  light/dark accessibility');
    print('');
    for (final page in pages) {
      final url = '$siteRoot$page';
      final light = await _runLighthouse(
        url,
        isDesktop: isDesktop,
        forceDarkMode: false,
      );

      final dark = await _runLighthouse(
        url,
        isDesktop: isDesktop,
        forceDarkMode: true,
      );
      print(
          '${page.padRight(padRight)} ${light.accessibility.toString().padLeft(3)}/${dark.accessibility.toString().padLeft(3)}');
      total.add(light.accessibility);
      total.add(dark.accessibility);
    }
    print('');
  }
  final avgScore = total.reduce((a, b) => a + b) / total.length;
  print('average: ${avgScore.toStringAsFixed(1)}');
}

class LighthouseResult {
  final int performance;
  final int accessibility;
  final int bestPractices;
  final int seo;

  LighthouseResult({
    required this.performance,
    required this.accessibility,
    required this.bestPractices,
    required this.seo,
  });

  late final _all = [performance, accessibility, bestPractices, seo];
  late final avg = _all.reduce((a, b) => a + b) ~/ _all.length;

  String _f(int v) => v.toString().padLeft(3);

  @override
  String toString() => '${_f(avg)} [${_all.map(_f).join(', ')}]';
}

Future<LighthouseResult> _runLighthouse(
  String url, {
  required bool isDesktop,
  required bool forceDarkMode,
}) async {
  final localChromePath = '/usr/bin/google-chrome-stable';
  final hasLocalChrome = await FileSystemEntity.isFile(localChromePath);
  final tempDir = await Directory.systemTemp.createTemp();
  if (forceDarkMode) {
    final uri = Uri.parse(url);
    url = uri.replace(queryParameters: {
      ...uri.queryParameters,
      'force-experimental-dark': '1'
    }).toString();
  }
  try {
    final flags = [
      '--headless',
      '--user-data-dir=${tempDir.path}',
    ];
    final pr = await Process.run(
      'node_modules/.bin/lighthouse',
      [
        url,
        if (isDesktop) '--preset=desktop',
        '--output=json',
        '--chrome-flags="${flags.join(' ')}"',
      ],
      environment: {
        if (hasLocalChrome) 'CHROME_PATH': localChromePath,
      },
    );
    if (pr.exitCode != 0) {
      throw Exception('Unknown exit code.\n${pr.stdout}\n${pr.stderr}');
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
    );
  } finally {
    await tempDir.delete(recursive: true);
  }
}
