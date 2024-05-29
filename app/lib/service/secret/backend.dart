// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert';

import 'package:clock/clock.dart';
import 'package:gcloud/service_scope.dart' as ss;
import 'package:googleapis/secretmanager/v1.dart' as secretmanager;
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:pub_dev/shared/configuration.dart';
import 'package:pub_dev/shared/monitoring.dart';
import 'package:retry/retry.dart';

import 'models.dart';

export 'models.dart' show SecretKey;

final _log = Logger('pub.secrets');

/// Sets the secret backend service.
void registerSecretBackend(SecretBackend backend) =>
    ss.register(#_secretBackend, backend);

/// The active secret backend service.
SecretBackend get secretBackend => ss.lookup(#_secretBackend) as SecretBackend;

sealed class SecretBackend {
  /// Lookup secret with given [id], allow an in-memory cached value no older
  /// than [maxAge] (default 1 hour).
  ///
  /// Return `null`, if secret is missing, or if looking up the secret failed!
  /// Caller is expected to gracefully degrade without the secret, or fail as it
  /// deems fit.
  Future<String?> lookup(
    String id, {
    Duration maxAge = const Duration(hours: 1),
  });
}

final class GcpSecretBackend extends SecretBackend {
  final http.Client _client;
  // Map from cached secret id to:
  // * time it was fetched, and
  // * future secret
  final _cache = <String, (DateTime, Future<String?>)>{};

  GcpSecretBackend(this._client);

  @override
  Future<String?> lookup(
    String id, {
    Duration maxAge = const Duration(hours: 1),
  }) async {
    if (maxAge < Duration.zero) {
      throw ArgumentError.value(maxAge, 'maxAge', 'must be positive');
    }
    if (maxAge > Duration(days: 1)) {
      throw ArgumentError.value(maxAge, 'maxAge', 'must less than 1 day');
    }
    if (!SecretKey.isValid(id)) {
      throw ArgumentError.value(id, 'id', 'invalid secret key identifier');
    }
    var (fetchedAt, secret) = _cache[id] ?? (DateTime(0), Future.value(null));
    if (clock.timeSince(fetchedAt) > maxAge) {
      (fetchedAt, secret) = _cache[id] = (clock.now(), _lookup(id));
    }
    return secret;
  }

  Future<String?> _lookup(String id) async {
    try {
      final api = secretmanager.SecretManagerApi(_client);
      final secret = await retry(
        () async => await api.projects.secrets.versions.access(
          'projects/${activeConfiguration.projectId}/secrets/$id/versions/latest',
        ),
      );
      final data = secret.payload?.data;
      if (data == null) {
        return null;
      }
      return utf8.decode(base64.decode(data));
    } catch (e, st) {
      // Log the issue
      _log.pubNoticeShout(
        'lookup-secret-failed',
        'Failed to fetch/access secret from SecretManager API',
        e,
        st,
      );
      // clear any cached value
      _cache.remove(id);
      // Return null, and hope the world survives a bit longer
      return null;
    }
  }
}

extension on Clock {
  /// Get the [Duration] since a [pastEvent] happened.
  Duration timeSince(DateTime pastEvent) => this.now().difference(pastEvent);
}

class FakeSecretBackend extends SecretBackend {
  final Map<String, String> _secrets;

  FakeSecretBackend(this._secrets);

  @override
  Future<String?> lookup(
    String id, {
    Duration maxAge = const Duration(hours: 1),
  }) async {
    return _secrets[id];
  }

  /// Update fake secret for [id], clear the secret by setting it `null`.
  void update(String id, String? value) {
    if (value != null) {
      _secrets[id] = value;
    } else {
      _secrets.remove(id);
    }
  }
}
