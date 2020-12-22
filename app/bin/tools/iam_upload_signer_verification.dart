// Copyright (c) 2020, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/account/backend.dart';
import 'package:pub_dev/account/models.dart';
import 'package:pub_dev/package/backend.dart';
import 'package:pub_dev/package/upload_signer_service.dart';
import 'package:pub_dev/service/entrypoint/tools.dart';

/// Checks if the IAM based upload signer service can be called successfully.
/// TODO: remove this after the appengine 0.12 upgrade.
Future<void> main(List<String> args) async {
  forceIamSigner = true;
  await withToolRuntime(() async {
    // NOTE: We use a authenticated user scope here to ensure the uploading
    // user is authenticated. But we're not validating anything at this point
    // because we don't even know which package or version is going to be
    // uploaded.
    //
    // Keeping fields null and setting isBlocked = false only to pass the
    // verification in `requireAuthenticatedUser`.
    registerAuthenticatedUser(User()..isBlocked = false);

    await packageBackend.startUpload(
      Uri.parse('http://localhost:8080/api/packages/versions/newUploadFinish'),
    );

    print('OK. IAM upload signer service account is configured correctly.');
  });
}
