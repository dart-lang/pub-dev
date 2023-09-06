// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:test/test.dart';

import '../../shared/test_services.dart';
import '_utils.dart';

final _variableExp = RegExp(r'\<(.+?)\>');

void main() {
  // The test collects the GET routes containing at least a `<package>` named parameter, and
  // optionally a `<version>` named parameter. These endpoints will be called with a combination
  // of good and bad package parameters, and response status codes are checked against a valid
  // set of codes specific to a use-case.
  final urls =
      _parseGetRoutes().where((url) => url.contains('<package>')).where(
    (url) {
      final vars = _variableExp.allMatches(url).map((m) => m.group(1)).toSet();
      vars.remove('package');
      vars.remove('version');
      return vars.isEmpty;
    },
  ).toSet();

  test('URLs are extracted', () {
    expect(urls, contains('/packages/<package>'));
    expect(urls, contains('/packages/<package>/versions/<version>'));
    expect(urls, contains('/api/packages/<package>'));
    // this a naive assertion that fails, if new end-points are introduced!
    expect(urls, hasLength(42), reason: 'check if new end-points was added');
  });

  testWithProfile(
    'Long URL check with <package>',
    processJobsWithFakeRunners: true,
    fn: () async {
      Future<void> check(
        String kind,
        String Function(String url) fn,
        Set<int> expectedCodes, {
        bool onlyWithVersion = false,
      }) async {
        final statusCodes = <int>{};
        for (final url in urls.toList()..sort()) {
          if (onlyWithVersion && !url.contains('<version>')) continue;
          final u = fn(url);
          final rs = await issueGet(u, headers: {
            'Cookie': 'PUB_EXPERIMENTAL_INSECURE=nosandbox',
          });
          statusCodes.add(rs.statusCode);
          expect(rs.statusCode, lessThan(500), reason: '$u ${rs.statusCode}');
          expect(rs.statusCode,
              anyOf(expectedCodes.map((c) => equals(c)).toList()),
              reason: '$kind $u ${rs.statusCode}');
        }
        expect(statusCodes, expectedCodes, reason: kind);
      }

      await check(
        'existing package',
        (url) => url
            .replaceAll('<package>', 'oxygen')
            .replaceAll('<version>', '1.2.0'),
        <int>{200, 303, 401},
      );

      await check(
        'existing package, non-existing version',
        (url) => url
            .replaceAll('<package>', 'oxygen')
            .replaceAll('<version>', '111.11.1'),
        <int>{303, 404},
        onlyWithVersion: true,
      );

      await check(
        'existing package, version longer than 64',
        (url) => url
            .replaceAll('<package>', 'oxygen')
            .replaceAll('<version>', '111.11.1-dev.' + ('0' * (65 - 13))),
        <int>{400},
        onlyWithVersion: true,
      );

      await check(
        'existing package, version longer than 1500',
        (url) => url
            .replaceAll('<package>', 'oxygen')
            .replaceAll('<version>', '111.11.1-dev.' + ('0' * 1500)),
        <int>{400},
        onlyWithVersion: true,
      );

      await check(
        'non-existing package, non-existing version',
        (url) => url
            .replaceAll('<package>', 'non_existing_package')
            .replaceAll('<version>', '111.11.1'),
        <int>{303, 401, 404},
      );

      await check(
        'package longer than 64, non-existing version',
        (url) => url
            .replaceAll('<package>', 'oxygen' + ('0' * (65 - 6)))
            .replaceAll('<version>', '111.11.1'),
        <int>{400},
      );

      await check(
        'package longer than 1500, non-existing version',
        (url) => url
            .replaceAll('<package>', 'oxygen' + ('0' * 1500))
            .replaceAll('<version>', '111.11.1'),
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
