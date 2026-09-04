// Copyright (c) 2026, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';

import 'download_signer_service.dart';
import 'upload_signer_service.dart' show SigningResult;

/// A fake implementation of DownloadSignerService for testing.
final class FakeDownloadSignerService extends DownloadSignerService {
  @override
  String get googleAccessId => 'fake-download-signer@example.com';

  @override
  Future<SigningResult> sign(List<int> bytes) async {
    return SigningResult(googleAccessId, Uint8List.fromList([1, 2, 3]));
  }
}
