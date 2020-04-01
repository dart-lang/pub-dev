// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:client_data/package_api.dart';
import 'package:pub_dev/package/upload_signer_service.dart';

/// Returns an upload URL with no signed signature.
class FakeUploadSignerService implements UploadSignerService {
  final String _storagePrefix;
  FakeUploadSignerService(this._storagePrefix);

  @override
  Future<UploadInfo> buildUpload(
    String bucket,
    String object,
    Duration lifetime,
    String successRedirectUrl, {
    String predefinedAcl = 'project-private',
    int maxUploadSize = UploadSignerService.maxUploadSize,
  }) async {
    return UploadInfo(
      url: Uri.parse('$_storagePrefix/$bucket/$object').toString(),
      fields: <String, String>{
        'key': '$bucket/$object',
        'success_action_redirect': successRedirectUrl,
      },
    );
  }

  @override
  Future<SigningResult> sign(List<int> bytes) async {
    return SigningResult('google-access-id', [1, 2, 3, 4]);
  }
}
