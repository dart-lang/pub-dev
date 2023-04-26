// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

import '../../shared/test_services.dart';
import '_utils.dart';

final _variableExp = RegExp(r'\<(.+?)\>');

void main() {
  // The test collects the GET routes containing a single `<publisherId>` named parameter.
  // These endpoints will be called with a combination of good and bad parameters, and
  // response status codes are checked against a valid set of codes specific to a use-case.
  final urls =
      _parseGetRoutes().where((url) => url.contains('<publisherId>')).where(
    (url) {
      final vars = _variableExp.allMatches(url).map((m) => m.group(1)).toSet();
      vars.remove('publisherId');
      return vars.isEmpty;
    },
  ).toSet();

  test('URLs are extracted', () {
    expect(urls, contains('/publishers/<publisherId>'));
    expect(urls, contains('/api/publishers/<publisherId>'));
    expect(urls, hasLength(8));
  });

  testWithProfile(
    'Long URL check with <publisherId>',
    processJobsWithFakeRunners: true,
    fn: () async {
      Future<void> check(
        String kind,
        String Function(String url) fn,
        Set<int> expectedCodes,
      ) async {
        final statusCodes = <int>{};
        for (final url in urls.toList()..sort()) {
          final u = fn(url);
          final rs = await issueGet(u);
          statusCodes.add(rs.statusCode);
          expect(rs.statusCode, lessThan(500), reason: '$u ${rs.statusCode}');
          expect(expectedCodes, contains(rs.statusCode),
              reason: '$kind $u ${rs.statusCode}');
        }
        expect(statusCodes, expectedCodes, reason: kind);
      }

      await check(
        'existing publisherId',
        (url) => url.replaceAll('<publisherId>', 'example.com'),
        <int>{200, 303, 401},
      );

      await check(
        'non-existing publisherId',
        (url) => url.replaceAll('<publisherId>', 'not-a-publisher.com'),
        <int>{303, 401, 404},
      );

      await check(
        'publisherId longer than 64',
        (url) => url.replaceAll('<publisherId>', ('a' * 64) + '.com'),
        <int>{400},
      );

      await check(
        'publisherId longer than 1500',
        (url) => url.replaceAll('<publisherId>', ('a' * 1500) + '.com'),
        <int>{400},
      );
    },
  );
}

Iterable<String> _parseGetRoutes() sync* {
  final exp = RegExp(r"'GET',\s+r'(.*?)',");
  final files = [
    'lib/frontend/handlers/pubapi.g.dart',
    'lib/frontend/handlers/routes.g.dart',
  ];
  for (final file in files) {
    final content = File(file).readAsStringSync();
    yield* exp.allMatches(content).map((m) => m.group(1)!);
  }
}
