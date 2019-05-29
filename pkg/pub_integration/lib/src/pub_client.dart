// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';

import 'package:http/http.dart';

/// Simple pub client library.
class PubClient {
  final _http = Client();
  final String pubHostedUrl;

  PubClient(this.pubHostedUrl) {
    if (pubHostedUrl == null) {
      throw Exception('pubHostedUrl must be set');
    }
  }

  /// Get the latest version name of a package.
  Future<String> getLatestVersionName(String package) async {
    final url = '$pubHostedUrl/api/packages/$package';
    final rs = await _http.get(url);
    if (rs.statusCode == 404) {
      return null;
    } else if (rs.statusCode == 200) {
      final map = json.decode(rs.body) as Map<String, dynamic>;
      final latest = map['latest'] as Map<String, dynamic>;
      return latest['version'] as String;
    } else {
      throw Exception('Unexpected result: ${rs.statusCode} ${rs.reasonPhrase}');
    }
  }

  /// Get the content of the latest version page of a package.
  Future<String> getLatestVersionPage(String package) async {
    final rs = await _http.get('$pubHostedUrl/packages/$package');
    if (rs.statusCode == 404) {
      return null;
    } else if (rs.statusCode == 200) {
      return rs.body;
    } else {
      throw Exception('Unexpected result: ${rs.statusCode} ${rs.reasonPhrase}');
    }
  }

  /// Free resources.
  Future close() async {
    _http.close();
  }
}
