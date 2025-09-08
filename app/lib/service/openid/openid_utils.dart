// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:_pub_shared/utils/http.dart';
import 'package:pub_dev/shared/env_config.dart';

import 'openid_models.dart';

/// Fetches the OpenID configuration and then the JSON Web Key list from the given endpoint.
Future<OpenIdData> fetchOpenIdData({required String configurationUrl}) async {
  final configUri = Uri.parse(configurationUrl);
  if (!envConfig.isRunningLocally && configUri.scheme != 'https') {
    throw AssertionError(
      'OpenID configuration URL must use `https` protocol, was: `$configurationUrl`.',
    );
  }
  final providerBody = await httpGetWithRetry(
    configUri,
    responseFn: (rs) => rs.body,
  );
  final providerData = json.decode(providerBody) as Map<String, dynamic>;
  final provider = OpenIdProvider.fromJson(providerData);
  final jwksUri = Uri.parse(provider.jwksUri);
  if (!envConfig.isRunningLocally && jwksUri.scheme != 'https') {
    throw AssertionError(
      'JWKS URL must use `https` protocol, was: `$jwksUri`.',
    );
  }
  final jwksBody = await httpGetWithRetry(jwksUri, responseFn: (rs) => rs.body);
  final jwksData = json.decode(jwksBody) as Map<String, dynamic>;
  return OpenIdData(
    provider: provider,
    jwks: JsonWebKeyList.fromJson(jwksData),
  );
}

String parseAsString(Map<String, dynamic> map, String key) {
  final value = parseAsStringOrNull(map, key);
  if (value == null) {
    throw FormatException('Missing value for `$key`.');
  } else {
    return value;
  }
}

String? parseAsStringOrNull(Map<String, dynamic> map, String key) {
  final value = map[key];
  if (value == null) {
    return null;
  }
  if (value is String) {
    return value;
  }
  throw FormatException('Unexpected value for `$key`: `$value`.');
}

List<String>? parseAsStringListOrNull(Map<String, dynamic> map, String key) {
  final value = map[key];
  if (value == null) {
    return null;
  }
  if (value is String) {
    return [value];
  }
  if (value is List && value.every((e) => e is String)) {
    return value.cast<String>();
  }
  throw FormatException('Unexpected value for `$key`: `$value`.');
}
