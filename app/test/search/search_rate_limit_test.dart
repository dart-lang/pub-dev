// Copyright (c) 2023, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:clock/clock.dart';
import 'package:pub_dev/frontend/handlers/listing.dart';
import 'package:pub_dev/shared/exceptions.dart';
import 'package:shelf/shelf.dart';
import 'package:test/test.dart';

import '../frontend/handlers/_utils.dart';
import '../shared/test_services.dart';

void main() {
  group('Search rate limit', () {
    final refTime = clock.now();
    Future<Response> search(
      String query, {
      required Duration time,
    }) async {
      return await withClock(
        Clock.fixed(refTime.add(time)),
        () async {
          return await packagesHandler(Request(
            'GET',
            Uri(
              scheme: 'http',
              host: 'localhost',
              port: 8080, // ignored
              path: '/packages',
              queryParameters: {'q': query},
            ),
            headers: {
              'x-forwarded-for': '1.2.3.4',
            },
          ));
        },
      );
    }

    testWithProfile(
      'search rate limit reached and then released',
      fn: () async {
        for (var i = 0; i < 120; i++) {
          await expectHtmlResponse(
              await search('json', time: Duration(milliseconds: i)));
        }
        await expectLater(
          search('json', time: Duration(milliseconds: 120)),
          throwsA(isA<RateLimitException>()),
        );
        await expectLater(
          search('json', time: Duration(minutes: 2)),
          throwsA(isA<RateLimitException>()),
        );
        await expectHtmlResponse(
          await search('json', time: Duration(minutes: 2, milliseconds: 1)),
        );
      },
    );
  });
}
