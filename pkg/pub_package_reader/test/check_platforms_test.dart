// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:pub_package_reader/src/check_platforms.dart';
import 'package:test/test.dart';

void main() {
  group('platforms', _platforms);
  _basePlatformTests('android');
  _basePlatformTests('ios');
  _basePlatformTests('linux');
  _basePlatformTests('macos');
  _basePlatformTests('web');
  _basePlatformTests('windows');
}

List<String> _check(Map content) {
  return checkPlatforms(
    json.encode({
      'name': 'example',
      'environment': {'sdk': '>=2.14.0 <3.0.0'},
      ...content,
    }),
  ).map((e) => e.message).toList();
}

void _platforms() {
  test('no key present', () {
    expect(_check({}), isEmpty);
  });

  test('key present with null content', () {
    expect(_check({'platforms': null}), isEmpty);
  });

  test('key present with empty content', () {
    expect(_check({'platforms': {}}), isEmpty);
  });

  test('unexpected platforms value', () {
    expect(_check({'platforms': []}), ['Unsupported platforms value: `[]`.']);
  });

  test('unexpected platform key', () {
    expect(
      _check({
        'platforms': {'c64': null},
      }),
      ['Unsupported platform key: `c64`.'],
    );
  });
}

void _basePlatformTests(String platform) {
  group('base $platform config', () {
    test('key present with null content', () {
      expect(
        _check({
          'platforms': {platform: null},
        }),
        isEmpty,
      );
    });

    test('key present with empty content', () {
      expect(
        _check({
          'platforms': {platform: {}},
        }),
        isEmpty,
      );
    });

    test('key present with `true`', () {
      expect(
        _check({
          'platforms': {platform: true},
        }),
        ['Unsupported platform config for `$platform`: `true`.'],
      );
    });

    test('key present with `false`', () {
      expect(
        _check({
          'platforms': {platform: false},
        }),
        ['Unsupported platform config for `$platform`: `false`.'],
      );
    });

    test('key present with unexpected content', () {
      expect(
        _check({
          'platforms': {
            platform: {'unexpected': 'value'},
          },
        }),
        ['Unsupported platform config for `$platform`: `{unexpected: value}`.'],
      );
    });
  });
}
