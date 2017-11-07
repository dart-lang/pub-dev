// Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:cli_util/cli_util.dart';
import 'package:cli_util/src/utils.dart';
import 'package:test/test.dart';

main() => defineTests();

void defineTests() {
  group('getSdkDir', () {
    test('arg parsing', () {
      // ignore: deprecated_member_use
      expect(getSdkDir(['--dart-sdk', '/dart/sdk']).path, equals('/dart/sdk'));
      // ignore: deprecated_member_use
      expect(getSdkDir(['--dart-sdk=/dart/sdk']).path, equals('/dart/sdk'));
    });

    test('finds the SDK without cli args', () {
      // ignore: deprecated_member_use
      expect(getSdkDir(), isNotNull);
    });
  });

  group('getSdkPath', () {
    test('sdkPath', () {
      expect(getSdkPath(), isNotNull);
    });
  });

  group('utils', () {
    test('isSdkDir', () {
      expect(isSdkDir(new Directory(getSdkPath())), true);
    });
  });
}
