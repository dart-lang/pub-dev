// Copyright (c) 2022, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'dart:convert' show json;
import 'dart:io' show IOException;

import 'package:http/http.dart' as http;
import 'package:pana/pana.dart';
import 'package:pub_semver/pub_semver.dart' show Version;
import 'package:retry/retry.dart';

/// Fetch pubspec for the given version
Future<Pubspec> fetchPubspec({
  required String package,
  required String version,
  required String pubHostedUrl,
}) async {
  final c = http.Client();
  try {
    final result = await retry(
      () async {
        // TODO: Make some reusable HTTP request logic
        final u = Uri.parse(_urlJoin(pubHostedUrl, 'api/packages/$package'));
        final r = await c.get(u).timeout(Duration(seconds: 30));
        if (r.statusCode >= 500) {
          throw _IntermittentHttpException._(
            'Failed to list versions, got ${r.statusCode} from "$u"',
          );
        }
        if (r.statusCode != 200) {
          throw Exception(
            'Failed to list versions, got ${r.statusCode} from "$u"',
          );
        }
        return json.decode(r.body);
      },
      retryIf: (e) =>
          e is _IntermittentHttpException ||
          e is FormatException ||
          e is IOException ||
          e is TimeoutException,
    );

    final versions = result['versions'] as List? ?? [];

    final v = Version.parse(version);
    return versions.map((e) => Pubspec(e['pubspec'] as Map)).firstWhere(
        (p) => p.version == v,
        orElse: () => throw Exception('could not find $version'));
  } finally {
    c.close();
  }
}

String _urlJoin(String url, String suffix) {
  if (!url.endsWith('/')) {
    url += '/';
  }
  return url + suffix;
}

class _IntermittentHttpException implements Exception {
  final String _message;
  _IntermittentHttpException._(this._message);
  @override
  String toString() => _message;
}
