// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:test/test.dart';

import '../../shared/test_services.dart';

import '_utils.dart';

void main() {
  group('account handlers tests', () {
    // TODO: add test for /consent page
    // TODO: add test for GET /api/account/consent/<consentId> API calls
    // TODO: add test for PUT /api/account/consent/<consentId> API calls
  });

  group('pub client authorization landing page', () {
    testWithServices('/authorized', () async {
      await expectHtmlResponse(await issueGet('/authorized'));
    });
  });
}
