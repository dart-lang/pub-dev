// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:collection/collection.dart';
import 'package:logging/logging.dart';
import 'package:meta/meta.dart';
import 'package:pub_dev/shared/redis_cache.dart';

import 'jwt.dart';
import 'openid_models.dart';
import 'openid_utils.dart';

final _logger = Logger('google_cloud_openid');

/// Fetches the OpenID configuration and then the JSON Web Key list from Google Cloud.
Future<OpenIdData> fetchGoogleCloudOpenIdData() async {
  final configurationUrl =
      'https://accounts.google.com/.well-known/openid-configuration';
  final list = await cache
      .openIdData(configurationUrl: configurationUrl)
      .get(() => fetchOpenIdData(configurationUrl: configurationUrl));
  return list!;
}

/// Parsed payload values Google Cloud Service account sends with the token.
class GcpServiceAccountJwtPayload {
  /// Email of the service account, in the format:
  /// `<GCP_PROJECT_ID>@cloudbuild.gserviceaccount.com`.
  final String email;

  /// focus obfuscated gaia id for the service account (aka. `OAuthUserId`)
  final String sub;

  /// The URL used as the `iss` property of JWT payloads.
  static const issuerUrl = 'https://accounts.google.com';

  @visibleForTesting
  static const requiredClaims = <String>{
    // generic claims
    'iat',
    // 'nbf', -- for some reason GCP doesn't provide this claim
    'exp',
    'iss',
    'aud',
    // Google Cloud-specific claims
    'email',
    'sub',
  };

  GcpServiceAccountJwtPayload._(Map<String, dynamic> map)
      : email = parseAsString(map, 'email'),
        sub = parseAsString(map, 'sub');

  factory GcpServiceAccountJwtPayload(JwtPayload payload) {
    final missing = requiredClaims.difference(payload.keys.toSet()).sorted();
    if (missing.isNotEmpty) {
      throw FormatException(
          'JWT from Google Cloud is missing following claims: ${missing.map((k) => '`$k`').join(', ')}.');
    }
    return GcpServiceAccountJwtPayload._(payload);
  }

  static GcpServiceAccountJwtPayload? tryParse(JwtPayload payload) {
    try {
      return GcpServiceAccountJwtPayload(payload);
    } on FormatException {
      return null;
    } catch (e, st) {
      _logger.warning('Unexpected JWT parser exception.', e, st);
      return null;
    }
  }
}
