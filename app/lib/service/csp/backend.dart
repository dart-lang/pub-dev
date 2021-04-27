// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;
import 'package:meta/meta.dart';

import '../../shared/cached_value.dart';
import '../secret/backend.dart';

import 'default_csp.dart';

/// Sets the CSP backend service.
void registerCspBackend(CspBackend backend) =>
    ss.register(#_cspBackend, backend);

/// The active CSP backend service.
CspBackend get cspBackend => ss.lookup(#_cspBackend) as CspBackend;

/// Represents the backend for the CSP handling and related utilities.
class CspBackend {
  final _defaultCspValue = _serializeCSP(null);
  final _cspValue = CachedValue<String>(
    name: 'csp',
    maxAge: Duration(days: 7),
    interval: Duration(minutes: 30),
    updateFn: () async {
      return _serializeCSP({
        'script-src': await secretBackend.lookup(SecretKey.cspScriptSrc),
        'style-src': await secretBackend.lookup(SecretKey.cspStyleSrc),
      });
    },
  );

  String get cspValue =>
      _cspValue.isAvailable ? _cspValue.value : _defaultCspValue;

  /// Update CSP values from Datastore.
  @visibleForTesting
  Future<void> update() async {
    // ignore: invalid_use_of_visible_for_testing_member
    await _cspValue.update();
  }

  /// Update CSP values regularly.
  Future<void> start() async {
    await _cspValue.start();
  }

  /// Cancel updates and free resources.
  Future<void> close() async {
    await _cspValue.close();
  }
}

/// Returns the serialized string of the CSP header.
String _serializeCSP(Map<String, String> extraValues) {
  final keys = <String>{
    ...defaultContentSecurityPolicyMap.keys,
    if (extraValues != null) ...extraValues.keys,
  };
  return keys.map((key) {
    final list = defaultContentSecurityPolicyMap[key];
    final extra = extraValues == null ? null : extraValues[key];
    final extraStr = (extra == null || extra.trim().isEmpty) ? '' : ' $extra';
    return '$key ${list.join(' ')}$extraStr';
  }).join(';');
}
