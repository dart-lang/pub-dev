// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:pub_dev/service/openid/github_openid.dart';
import 'package:test/test.dart';

import '../../shared/test_services.dart';

void main() {
  testWithProfile('GitHub key list', fn: () async {
    final data = await fetchGithubOpenIdData();
    expect(data.provider.issuer, 'https://token.actions.githubusercontent.com');
    expect(data.jwks.keys, isNotEmpty);
    final rsaKeys = data.jwks.keys.where((key) => key.kty == 'RSA').toList();
    expect(rsaKeys, isNotEmpty);
    final firstRsaKey = rsaKeys.first;
    expect(firstRsaKey.alg, 'RS256');
    expect(firstRsaKey.n, isNotEmpty);
    expect(firstRsaKey.e, isNotEmpty);
  });
}
