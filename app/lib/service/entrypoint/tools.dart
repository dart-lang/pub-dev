// Copyright (c) 2014, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/package/upload_signer_service.dart';
import '../services.dart';

/// Helper for utilities in bin/tools to setup a minimal AppEngine environment,
/// calling [fn] to run inside it. It registers only the most frequently used
/// services (at the moment only `frontend/backend.dart`).
///
/// Connection parameters are inferred from the GCLOUD_PROJECT and the GCLOUD_KEY
/// environment variables.
Future withProdServices(Future Function() fn) {
  return withServices(() {
    registerUploadSigner(ServiceAccountBasedUploadSigner());
    return fn();
  });
}
