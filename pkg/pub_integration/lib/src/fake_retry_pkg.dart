// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:path/path.dart' as path;

/// The content of README.md
String readme() => '''
retry package
=============

''';

/// The content of pubspec.yaml
String pubspec(String version) => '''
name: retry
version: $version
homepage: 'https://github.com/dart-lang/pub-dev'
description: 'Dummy packages published from pub integration tests.'
author: 'Developer <developer@example.com>'
environment:
  sdk: ">=2.1.0 <3.0.0"

''';

/// The content of LICENSE
String license() => '''
Copyright 2019, the Dart project authors. All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are
met:

    * Redistributions of source code must retain the above copyright
      notice, this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above
      copyright notice, this list of conditions and the following
      disclaimer in the documentation and/or other materials provided
      with the distribution.
    * Neither the name of Google Inc. nor the names of its
      contributors may be used to endorse or promote products derived
      from this software without specific prior written permission.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
''';

/// The content of lib/_dummy_pkg.dart
String mainlib() => '''// main library
import 'dart:async';

  Future<T> retry<T>(
    FutureOr<T> Function() fn, {
    FutureOr<bool> Function(Exception) retryIf,
    FutureOr<void> Function(Exception) onRetry,
    int maxAttempts = 8,
  }) async {
    int attempt = 0;
    // ignore: literal_only_boolean_expressions
    while (true) {
      attempt++; // first invocation is the first attempt
      try {
        return await fn();
      } on Exception catch (e) {
        if (attempt >= maxAttempts || retryIf == null || !(await retryIf(e))) {
          rethrow;
        }
        if (onRetry != null) {
          await onRetry(e);
        }
      }

      // Sleep for a delay
      await Future.delayed(Duration(seconds: 1));
    }
  }
''';

/// Creates the files of the fake retry package in [dir] with [version].
Future createFakeRetryPkg(String dir, String version) async {
  await Directory(path.join(dir, 'lib')).create(recursive: true);
  await File(path.join(dir, 'LICENSE')).writeAsString(license());
  await File(path.join(dir, 'README.md')).writeAsString(readme());
  await File(path.join(dir, 'pubspec.yaml')).writeAsString(pubspec(version));
  await File(path.join(dir, 'lib', 'retry.dart')).writeAsString(mainlib());
}
