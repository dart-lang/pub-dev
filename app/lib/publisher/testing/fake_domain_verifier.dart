// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import '../../shared/exceptions.dart' show AuthorizationException;
import '../domain_verifier.dart';

/// Fake implementation of [DomainVerifier] for testing.
class FakeDomainVerifier implements DomainVerifier {
  @override
  Future<bool> verifyDomainOwnership(String domain, String accessToken) async {
    if (domain == 'verified.com' || domain == 'example.com') {
      return true;
    }
    if (domain == 'notverified.net') {
      return false;
    }
    throw AuthorizationException.missingSearchConsoleReadAccess();
  }
}
