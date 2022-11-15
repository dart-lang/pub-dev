// Copyright (c) 2019, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:convert';
import 'dart:io';

import 'package:_pub_shared/validation/html/html_validation.dart';
import 'package:http/http.dart';

const _jsonRequestHeaders = <String, String>{
  'content-type': 'application/json; charset="utf-8"',
};

/// Simple pub client library.
class PubHttpClient {
  final _http = _HtmlVerifierHttpClient(Client());
  final Uri _pubHostedUrl;

  PubHttpClient(String pubHostedUrl) : _pubHostedUrl = Uri.parse(pubHostedUrl);

  /// Forces the analyzer jobs to update and run.
  ///
  /// This works only with the local fake_pub_server instance, because the
  /// current implementation is blocking the analyzer instance, and we don't
  /// want to expose such functionality in production.
  Future<void> forceAnalyzerUpdate() async {
    final rs = await _http.post(_pubHostedUrl.resolve('/fake-update-analyzer'));
    if (rs.statusCode == 200) {
      return;
    }
    throw UnsupportedError(
        'Forced analyzer update is supported only on fake pub server.');
  }

  /// Forces the dartdoc jobs to update and run.
  ///
  /// This works only with the local fake_pub_server instance, because the
  /// current implementation is blocking the dartdoc instance, and we don't
  /// want to expose such functionality in production.
  Future<void> forceDartdocUpdate() async {
    final rs = await _http.post(_pubHostedUrl.resolve('/fake-update-dartdoc'));
    if (rs.statusCode == 200) {
      return;
    }
    throw UnsupportedError(
        'Forced dartdoc update is supported only on fake pub server.');
  }

  /// Forces the search index to update.
  ///
  /// This works only with the local fake_pub_server instance, because the
  /// current implementation is blocking the search instance, and we don't want
  /// to expose such functionality in production.
  Future<void> forceSearchUpdate() async {
    final rs = await _http.post(_pubHostedUrl.resolve('/fake-update-search'));
    if (rs.statusCode == 200) {
      return;
    }
    throw UnsupportedError(
        'Forced search update is supported only on fake pub server.');
  }

  /// Get the latest version name of a package.
  Future<String?> getLatestVersionName(String package) async {
    final rs = await _http.get(_pubHostedUrl.resolve('/api/packages/$package'));
    if (rs.statusCode == 404) {
      return null;
    } else if (rs.statusCode == 200) {
      final map = json.decode(rs.body) as Map<String, dynamic>;
      final latest = map['latest'] as Map<String, dynamic>;
      return latest['version'] as String?;
    } else {
      throw Exception('Unexpected result: ${rs.statusCode} ${rs.reasonPhrase}');
    }
  }

  /// Get the content of the latest version page of a package or null if it does
  /// not exists.
  Future<String?> getLatestVersionPage(String package, {String? tab}) async {
    final tabUrl = tab == null ? '' : '/$tab';
    final rs =
        await _http.get(_pubHostedUrl.resolve('/packages/$package$tabUrl'));
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
    final rs = await _http.get(_pubHostedUrl.resolve('/publishers'));
    if (rs.statusCode == 200) {
      return rs.body;
    } else {
      throw Exception('Unexpected result: ${rs.statusCode} ${rs.reasonPhrase}');
    }
  }

  /// Get the content of the publisher page or null if it does not exists.
  Future<String?> getPublisherPage(String publisherId) async {
    final rs =
        await _http.get(_pubHostedUrl.resolve('/publishers/$publisherId'));
    if (rs.statusCode == 404) {
      return null;
    } else if (rs.statusCode == 200) {
      return rs.body;
    } else {
      throw Exception('Unexpected result: ${rs.statusCode} ${rs.reasonPhrase}');
    }
  }

  /// Get the content text of a requested resource;
  Future<String> getContent(String path, {int expectedStatusCode = 200}) async {
    final rs = await _http.get(_pubHostedUrl.resolve(path));
    if (rs.statusCode != expectedStatusCode) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
    return rs.body;
  }

  Future<String> getDocumentationPage(String package,
          [String version = 'latest']) async =>
      getContent('/documentation/$package/$version/');

  /// Creates a publisher.
  Future<void> createPublisher({
    required String authToken,
    required String publisherId,
    required String accessToken,
  }) async {
    final rs = await _http.post(
      _pubHostedUrl.resolve('/api/publishers/$publisherId'),
      headers: {
        ..._jsonRequestHeaders,
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
    required String authToken,
    required String package,
    required String publisherId,
  }) async {
    final rs = await _http.put(
      _pubHostedUrl.resolve('/api/packages/$package/publisher'),
      headers: {
        ..._jsonRequestHeaders,
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
    required String authToken,
    required String publisherId,
    required String invitedEmail,
  }) async {
    final rs = await _http.post(
      _pubHostedUrl.resolve('/api/publishers/$publisherId/invite-member'),
      headers: {
        ..._jsonRequestHeaders,
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
  Future<Map<String?, String?>> listMembers({
    required String authToken,
    required String publisherId,
  }) async {
    final rs = await _http.get(
      _pubHostedUrl.resolve('/api/publishers/$publisherId/members'),
      headers: {
        ..._jsonRequestHeaders,
        HttpHeaders.authorizationHeader: 'Bearer $authToken',
      },
    );
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
    final map = json.decode(rs.body);
    final members = (map['members'] as List).cast<Map>();
    return Map.fromEntries(members.map((Map m) => MapEntry<String?, String?>(
        m['email'] as String?, m['role'] as String?)));
  }

  /// Returns the list of packages from `/api/package-names` endpoint.
  Future<List<String>> apiPackageNames() async {
    final rs = await _http.get(_pubHostedUrl.resolve('/api/package-names'));
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
    final map = json.decode(rs.body) as Map<String, dynamic>;
    final packages = (map['packages'] as List).cast<String>();
    if (!map.containsKey('nextUrl') || map['nextUrl'] != null) {
      throw Exception('"nextUrl" attribute is expected to be null');
    }
    return packages;
  }

  /// Returns the list of packages from `/api/package-name-completion-data` endpoint.
  Future<List<String>> apiPackageNameCompletionData() async {
    final rs = await _http
        .get(_pubHostedUrl.resolve('/api/package-name-completion-data'));
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
    final map = json.decode(rs.body) as Map<String, dynamic>;
    final packages = (map['packages'] as List).cast<String>();
    return packages;
  }

  /// Invites a new uploader to the package.
  Future<void> inviteUploader({
    required String packageName,
    required String accessToken,
    required String invitedEmail,
  }) async {
    final rs = await _http.post(
      _pubHostedUrl.resolve('/api/packages/$packageName/invite-uploader'),
      headers: {
        ..._jsonRequestHeaders,
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: json.encode({
        'email': invitedEmail,
      }),
    );
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
  }

  /// Invites a new uploader to the package.
  Future<void> removeUploader({
    required String packageName,
    required String accessToken,
    required String uploaderEmail,
  }) async {
    print(accessToken);
    final rs = await _http.post(
      _pubHostedUrl.resolve('/api/packages/$packageName/remove-uploader'),
      headers: {
        ..._jsonRequestHeaders,
        HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
      body: json.encode({
        'email': uploaderEmail,
      }),
    );
    if (rs.statusCode != 200) {
      throw Exception('Unexpected status code: ${rs.statusCode}');
    }
  }

  /// Free resources.
  Future<void> close() async {
    _http.close();
  }
}

/// Verifies each HTML response.
class _HtmlVerifierHttpClient extends BaseClient {
  final Client _delegate;

  _HtmlVerifierHttpClient(this._delegate);

  @override
  Future<StreamedResponse> send(BaseRequest request) async {
    final rs = await _delegate.send(request);
    final contentType = rs.headers[HttpHeaders.contentTypeHeader];
    if (contentType == null || contentType.isEmpty) {
      throw FormatException(
          'Content type header is missing for ${request.url}.');
    }
    if (rs.statusCode == 200 && contentType.contains('text/html')) {
      final body = await rs.stream.bytesToString();
      parseAndValidateHtml(body);
      return StreamedResponse(
        ByteStream.fromBytes(utf8.encode(body)),
        rs.statusCode,
        contentLength: rs.contentLength,
        headers: rs.headers,
        isRedirect: rs.isRedirect,
        persistentConnection: rs.persistentConnection,
        reasonPhrase: rs.reasonPhrase,
        request: rs.request,
      );
    }
    return rs;
  }

  @override
  void close() {
    super.close();
    _delegate.close();
  }
}
