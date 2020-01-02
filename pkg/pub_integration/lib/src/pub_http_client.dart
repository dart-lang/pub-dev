// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:meta/meta.dart';

/// Simple pub client library.
class PubHttpClient {
  final _http = Client();
  final String pubHostedUrl;

  PubHttpClient(this.pubHostedUrl) {
    if (pubHostedUrl == null) {
      throw Exception('pubHostedUrl must be set');
    }
  }

  /// Forces the search index to update.
  ///
  /// This works only with the local fake_pub_server instance, because the
  /// current implementation is blocking the search instance, and we don't want
  /// to expose such functionality in production.
  Future<void> forceSearchUpdate() async {
    final url = '$pubHostedUrl/fake-update-search';
    final rs = await _http.post(url);
    if (rs.statusCode == 200) {
      return;
    }
    throw UnsupportedError(
        'Forced search update is supported only on fake pub server.');
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

  /// Get the content of the latest version page of a package or null if it does
  /// not exists.
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

  /// Get the content of the publisher list page.
  Future<String> getPublisherListPage() async {
    final rs = await _http.get('$pubHostedUrl/publishers');
    if (rs.statusCode == 200) {
      return rs.body;
    } else {
      throw Exception('Unexpected result: ${rs.statusCode} ${rs.reasonPhrase}');
    }
  }

  /// Get the content of the publisher page or null if it does not exists.
  Future<String> getPublisherPage(String publisherId) async {
    final rs = await _http.get('$pubHostedUrl/publishers/$publisherId');
    if (rs.statusCode == 404) {
      return null;
    } else if (rs.statusCode == 200) {
      return rs.body;
    } else {
      throw Exception('Unexpected result: ${rs.statusCode} ${rs.reasonPhrase}');
    }
  }

  /// Get the content text of a requested resource;
  Future<String> getContent(String path) async {
    final rs = await _http.get('$pubHostedUrl$path');
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
    return rs.body;
  }

  /// Creates a publisher.
  Future<void> createPublisher({
    @required String authToken,
    @required String publisherId,
    @required String accessToken,
  }) async {
    final rs = await _http.post(
      '$pubHostedUrl/api/publishers/$publisherId',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
      body: json.encode({
        'accessToken': accessToken,
      }),
    );
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
  }

  /// Move a package under a publisher.
  Future<void> setPackagePublisher({
    @required String authToken,
    @required String package,
    @required String publisherId,
  }) async {
    final rs = await _http.put(
      '$pubHostedUrl/api/packages/$package/publisher',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
      body: json.encode({
        'publisherId': publisherId,
      }),
    );
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
  }

  /// Invite a member into a publisher.
  Future<void> inviteMember({
    @required String authToken,
    @required String publisherId,
    @required String invitedEmail,
  }) async {
    final rs = await _http.post(
      '$pubHostedUrl/api/publishers/$publisherId/invite-member',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
      body: json.encode({
        'email': invitedEmail,
      }),
    );
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
  }

  /// Returns the e-mail -> role map of publisher members.
  Future<Map<String, String>> listMembers({
    @required String authToken,
    @required String publisherId,
  }) async {
    final rs = await _http.get(
      '$pubHostedUrl/api/publishers/$publisherId/members',
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
    final map = json.decode(rs.body);
    final members = (map['members'] as List).cast<Map>();
    return Map.fromEntries(members.map((Map m) =>
        MapEntry<String, String>(m['email'] as String, m['role'] as String)));
  }

  /// Free resources.
  Future<void> close() async {
    _http.close();
  }
}
