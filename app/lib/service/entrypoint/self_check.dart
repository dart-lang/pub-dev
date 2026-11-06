// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:args/command_runner.dart';

import '../../package/attestation_verifier.dart';

/// Checks that the running binary is able to use its native dependencies.
///
/// Used to verify the production container image after it has been built,
/// see `app/test/service/entrypoint/dockerfile_app_build_test.dart`.
class SelfCheckCommand extends Command {
  @override
  String get name => 'self-check';

  @override
  String get description =>
      'Checks that the binary can load its native dependencies.';

  @override
  bool get hidden => true;

  @override
  Future<void> run() async {
    AttestationVerifier().checkNativeLibrary();
    print('self-check: OK');
  }
}
