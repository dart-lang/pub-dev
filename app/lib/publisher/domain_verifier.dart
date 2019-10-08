// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis_auth/auth.dart' as auth;
import 'package:googleapis/webmasters/v3.dart' as wmx;
import 'package:http/http.dart' as http;
import 'package:retry/retry.dart' show retry;

import '../shared/exceptions.dart' show AuthorizationException;

/// Sets the [DomainVerifier] service.
void registerDomainVerifier(DomainVerifier domainVerifier) =>
    ss.register(#_domainVerifier, domainVerifier);

/// The active [DomainVerifier] service.
DomainVerifier get domainVerifier =>
    ss.lookup(#_domainVerifier) as DomainVerifier;

/// Service that can verify ownership of a domain by asking Search Console
/// through Webmaster API v3.
///
/// Please obtain instances of this from [domainVerifier], as this allows for
/// dependency injection during testing.
class DomainVerifier {
  /// Verify ownership of [domain] using [accessToken] which has the read-only
  /// scope for Search Console API.
  Future<bool> verifyDomainOwnership(String domain, String accessToken) async {
    // Create client for talking to Webmasters API:
    // https://developers.google.com/webmaster-tools/search-console-api-original/v3/parameters
    final client = auth.authenticatedClient(
      http.Client(),
      auth.AccessCredentials(
        auth.AccessToken(
          'Bearer',
          accessToken,
          DateTime.now().toUtc().add(Duration(minutes: 20)), // avoid refresh
        ),
        null,
        [wmx.WebmastersApi.WebmastersReadonlyScope],
      ),
    );
    try {
      // Request list of sites/domains from the Search Console API.
      final sites = await retry(
        () => wmx.WebmastersApi(client).sites.list(),
        maxAttempts: 3,
        maxDelay: Duration(milliseconds: 500),
        retryIf: (e) => e is! auth.AccessDeniedException,
      );
      if (sites == null || sites.siteEntry == null) {
        return false;
      }
      // Determine if the user is in fact owner of the domain in question.
      // Note. domains are prefixed 'sc-domain:' and 'siteOwner' is the only
      //       permission that ensures the user actually did DNS verification.
      return sites.siteEntry.any(
        (s) =>
            s != null &&
            s.siteUrl != null &&
            s.siteUrl.toLowerCase() == 'sc-domain:$domain' &&
            s.permissionLevel == 'siteOwner', // must be 'siteOwner'!
      );
    } on auth.AccessDeniedException {
      throw AuthorizationException.missingSearchConsoleReadAccess();
    } finally {
      client.close();
    }
  }
}
