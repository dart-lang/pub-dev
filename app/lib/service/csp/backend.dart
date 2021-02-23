// Copyright (c) 2021, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';

import 'package:gcloud/service_scope.dart' as ss;

import '../secret/backend.dart';

import 'default_csp.dart';

/// Sets the CSP backend service.
void registerCspBackend(CspBackend backend) =>
    ss.register(#_cspBackend, backend);

/// The active CSP backend service.
CspBackend get cspBackend => ss.lookup(#_cspBackend) as CspBackend;

/// Represents the backend for the CSP handling and related utilities.
class CspBackend {
  String _cspValue;
  Timer _updateTimer;

  String get cspValue => _cspValue ??= _serializeCSP(null);

  /// Updates the default CSP values with the customization from Datastore.
  Future<void> update() async {
    _cspValue = _serializeCSP({
      'script-src': await secretBackend.lookup(SecretKey.cspScriptSrc),
      'style-src': await secretBackend.lookup(SecretKey.cspStyleSrc),
    });
  }

  /// Sets a timer to update CSPs regularly.
  void scheduleRegularUpdates() {
    _updateTimer = Timer.periodic(Duration(minutes: 10), (_) async {
      await update();
    });
  }

  /// Cancel timer and free resources.
  Future<void> close() async {
    _updateTimer?.cancel();
    _updateTimer = null;
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
